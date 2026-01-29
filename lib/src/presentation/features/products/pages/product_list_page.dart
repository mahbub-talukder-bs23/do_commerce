import 'package:do_commerce/src/presentation/core/widgets/product_card.dart';
import 'package:do_commerce/src/presentation/features/products/riverpod/get_data_provider.dart';
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
      // if (scrollController.position.pixels ==
      //     scrollController.position.maxScrollExtent) {
      //   ref.read(productListProvider.notifier).loadProductList();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productListProvider);

    final newData = ref.watch(getDataProvider);

    // final isLoading = state.isLoading;
    // final isRef = state.isRefreshing;
    // final isReloading = state.isReloading;

    // print('dbg: for list: ${state.hasValue}');
    // print('dbg: for list: ${state.isLoading}');
    // print('dbg: for data: ${newData.hasValue}');
    // print('dbg: for data: ${newData.isLoading}');
    // print('dbg: new step\n');

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(getDataProvider);
        ref.refresh(productListProvider);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (state is AsyncError) ...[
            const Center(child: Text("Something went wrong")),
          ],
          Text(newData.value.toString()),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: state.value?.length ?? 0,
              // (!state.isRefreshing && !state.isReloading ? 1 : 0),
              itemBuilder: (context, index) {
                // if (index == products.length) {
                //   return Padding(
                //     padding: const EdgeInsets.all(16),
                //     child: Center(
                //       child: SizedBox(
                //         width: 20,
                //         height: 20,
                //         child: CircularProgressIndicator(
                //           color: Theme.of(context).colorScheme.primary,
                //         ),
                //       ),
                //     ),
                //   );
                // }
                return ProductCard(product: state.value![index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
