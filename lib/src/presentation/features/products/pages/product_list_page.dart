import 'package:do_commerce/src/presentation/core/widgets/product_card.dart';
import 'package:do_commerce/src/presentation/features/products/riverpod/product_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  final scrollController = ScrollController();

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
        ref.read(productListProvider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productListProvider);

    return state.when(
      data: (data) => ListView.builder(
        controller: scrollController,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ProductCard(product: data[index]);
        },
      ),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
