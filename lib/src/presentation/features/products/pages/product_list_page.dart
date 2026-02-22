import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entity/product_entity.dart';
import '../riverpod/product_list_provider.dart';
import '../../../core/widgets/product_card.dart';

part '../widgets/product_list_builder.dart';
part '../widgets/search_bar.dart';
part '../widgets/category_chips.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});

  @override
  ConsumerState<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  static const _debounce = Duration(milliseconds: 400);
  static const _categories = [
    'All',
    'beauty',
    'fragrances',
    'furniture',
    'groceries',
    'home-decoration',
    'kitchen-accessories',
  ];

  late final ScrollController _scrollController;
  late final TextEditingController _searchController;

  Timer? _debounceTimer;
  String _selectedCategory = _categories.first;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _searchController = TextEditingController();

    ref.listenManual(productListProvider, _onStateChanged);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onStateChanged(AsyncValue? previous, AsyncValue next) {
    if (next is AsyncError) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(next.error.toString())));
    }
  }

  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent) {
      ref.read(productListProvider.notifier).loadMoreProduct();
    }
  }

  void _onSearchChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounce, () {
      ref
          .read(productListProvider.notifier)
          .updateSearch(value.trim().isEmpty ? null : value.trim());
    });
    setState(() {});
  }

  void _onClearSearch() {
    _debounceTimer?.cancel();
    _searchController.clear();
    ref.read(productListProvider.notifier).updateSearch(null);
    setState(() {});
  }

  void _onCategorySelected(String category) {
    if (_selectedCategory == category) return;
    setState(() => _selectedCategory = category);
    ref
        .read(productListProvider.notifier)
        .updateCategory(category == _categories.first ? null : category);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productListProvider);

    return Column(
      children: [
        _SearchBar(
          controller: _searchController,
          onChanged: _onSearchChanged,
          onClear: _onClearSearch,
        ),
        _CategoryChips(
          categories: _categories,
          selected: _selectedCategory,
          onSelected: _onCategorySelected,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => ref.refresh(productListProvider.future),
            child: state.when(
              skipLoadingOnReload: true,
              data: (products) => _ProductListBuilder(
                scrollController: _scrollController,
                products: products,
                state: state,
              ),
              error: (_, __) =>
                  const Center(child: Text('Something went wrong')),
              loading: () => Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
