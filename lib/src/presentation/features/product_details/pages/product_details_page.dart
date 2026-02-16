import 'package:do_commerce/src/presentation/features/product_details/riverpod/product_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsPage extends ConsumerWidget {
  const ProductDetailsPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productDetailsProvider(id));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.surface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Product Details',
          style: TextStyle(color: Theme.of(context).colorScheme.surface),
        ),
      ),
      body: SafeArea(
        child: product.when(
          data: (data) {
            final allImages = [data.thumbnail, ...data.images];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (allImages.isNotEmpty) ...[
                    Stack(
                      children: [
                        _ImageSlider(allImages: allImages),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.error,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.network(
                              data.qrCodeUrl,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(child: Icon(Icons.error));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    data.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        data.brand,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(color: Colors.grey),
                      ),
                      const Spacer(),
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        data.rating.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        '\$${data.getDiscountPrice()}',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(width: 8),
                      if (data.discountPercentage > 0) ...[
                        Text(
                          '\$${data.price}',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                decoration: TextDecoration.lineThrough,
                              ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${data.discountPercentage}% OFF',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),

                  // Tags
                  if (data.tags.isNotEmpty) ...[
                    Text(
                      'Tags',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      children: data.tags
                          .map((tag) => Chip(label: Text(tag)))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Metadata
                  _buildInfoRow('Category', data.category),
                  _buildInfoRow('Availability', data.availabilityStatus),
                  _buildInfoRow('Warranty', data.warrantyInformation),
                  _buildInfoRow('Return Policy', data.returnPolicy),

                  const SizedBox(height: 16),

                  // Reviews
                  Text(
                    'Reviews (${data.reviews.length})',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.reviews.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final review = data.reviews[index];
                      return ListTile(
                        title: Text(review.reviewerName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(review.comment),
                            Text(
                              review.date.substring(0, 10),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            Text(review.rating.toString()),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
          loading: () => Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _ImageSlider extends StatelessWidget {
  const _ImageSlider({super.key, required this.allImages});

  final List<String> allImages;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        itemCount: allImages.length,
        itemBuilder: (context, index) {
          return Image.network(allImages[index], fit: BoxFit.contain);
        },
      ),
    );
  }
}
