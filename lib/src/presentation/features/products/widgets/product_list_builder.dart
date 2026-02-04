part of '../pages/product_list_page.dart';

class _ProductListBuilder extends StatelessWidget {
  const _ProductListBuilder({
    required this.scrollController,
    required this.products,
    required this.state,
  });

  final ScrollController scrollController;
  final List<ProductEntity> products;
  final AsyncValue<List<ProductEntity>> state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
