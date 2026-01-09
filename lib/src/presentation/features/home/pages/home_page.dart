import 'package:do_commerce/src/presentation/features/carts/pages/cart_page.dart';
import 'package:do_commerce/src/presentation/features/products/pages/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part '../widgets/bottom_nav_button.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            Text(
              'Product List',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.logout_rounded,
                color: Theme.of(context).colorScheme.surface,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: selectedIndex,
                builder: (context, value, child) {
                  if (value == 0) {
                    return const ProductListPage();
                  }
                  return const CartPage();
                },
              ),
            ),
            Container(
              color: Colors.grey.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavButton(
                    text: 'Products',
                    icon: Icons.list,
                    index: 0,
                    selectedIndex: selectedIndex,
                  ),
                  BottomNavButton(
                    text: 'Cart',
                    icon: Icons.shopping_cart,
                    index: 1,
                    selectedIndex: selectedIndex,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
