import 'package:do_commerce/src/domain/entity/product_entity.dart';
import 'package:do_commerce/src/presentation/core/widgets/product_card.dart';
import 'package:do_commerce/src/presentation/features/products/riverpod/product_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});

  @override
  ConsumerState<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  final scrollController = ScrollController();
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();

    ref.listenManual(productListProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        ref.read(productListProvider.notifier).loadProductList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productListProvider);
    final products = state.value ?? [];

    if (state is AsyncError) {
      return const Center(child: Text("Something went wrong"));
    }

    return RefreshIndicator(
      onRefresh: () {
        isRefreshing = true;
        return ref
            .read(productListProvider.notifier)
            .loadProductList(reset: true);
      },
      child: ListView.builder(
        controller: scrollController,
        itemCount: products.length + (state.isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == products.length) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            );
          }

          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}
