import 'package:do_commerce/src/domain/entity/product_entity.dart';
import 'package:do_commerce/src/presentation/core/widgets/product_card.dart';
import 'package:do_commerce/src/presentation/features/products/riverpod/product_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part '../widgets/product_list_builder.dart';

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
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        ref.read(productListProvider.notifier).loadMoreProduct();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productListProvider);

    return RefreshIndicator(
      onRefresh: () async => ref.refresh(productListProvider.future),
      child: state.when(
        skipLoadingOnReload: true,
        data: (data) => _ProductListBuilder(
          scrollController: scrollController,
          products: data,
          state: state,
        ),
        error: (error, stackTrace) {
          return const Center(child: Text("Something went wrong"));
        },
        loading: () => Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
