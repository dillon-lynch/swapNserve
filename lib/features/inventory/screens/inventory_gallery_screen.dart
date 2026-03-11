import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swap_n_serve/models/inventory_item.dart';
import 'package:swap_n_serve/providers/inventory.dart';
import 'package:swap_n_serve/providers/transaction.dart';
import 'package:swap_n_serve/repositories/inventory_repository.dart';

class InventoryGalleryScreen extends ConsumerStatefulWidget {
  const InventoryGalleryScreen({super.key});

  @override
  ConsumerState<InventoryGalleryScreen> createState() =>
      _InventoryGalleryScreenState();
}

class _InventoryGalleryScreenState
    extends ConsumerState<InventoryGalleryScreen> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final inventoryAsync = ref.watch(inventoryStreamProvider);
    final allStockAsync = ref.watch(allCategoryStockProvider);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: inventoryAsync.when(
        data: (items) {
          final categories =
              items.map((i) => i.category).toSet().toList()..sort();
          final filtered = _selectedCategory == null
              ? items
              : items
                    .where((i) => i.category == _selectedCategory)
                    .toList();

          return CustomScrollView(
            slivers: [
              SliverAppBar.large(
                title: const Text('Inventory'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => showSearch(
                      context: context,
                      delegate: _InventorySearchDelegate(items),
                    ),
                  ),
                ],
              ),

              // Category filter chips with stock counts
              if (categories.length > 1)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 52,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: allStockAsync.when(
                              data: (stockMap) {
                                final total = stockMap.values
                                    .fold<int>(0, (s, cs) => s + cs.total);
                                return Text('All ($total)');
                              },
                              loading: () => const Text('All'),
                              error: (_, __) => const Text('All'),
                            ),
                            selected: _selectedCategory == null,
                            onSelected: (_) =>
                                setState(() => _selectedCategory = null),
                          ),
                        ),
                        ...categories.map(
                          (cat) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: allStockAsync.when(
                                data: (stockMap) {
                                  final count =
                                      stockMap[cat]?.total ?? 0;
                                  return Text('$cat ($count)');
                                },
                                loading: () => Text(cat),
                                error: (_, __) => Text(cat),
                              ),
                              selected: _selectedCategory == cat,
                              onSelected: (_) => setState(
                                () => _selectedCategory =
                                    _selectedCategory == cat ? null : cat,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 8)),

              // Item count
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '${filtered.length} item${filtered.length == 1 ? '' : 's'}',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 8)),

              // Grid
              filtered.isEmpty
                  ? const SliverFillRemaining(
                      child: Center(child: Text('No items found')),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 220,
                          childAspectRatio: 0.62,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) =>
                              _ItemCard(item: filtered[index]),
                          childCount: filtered.length,
                        ),
                      ),
                    ),

              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to add inventory item
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Item card
// ---------------------------------------------------------------------------

class _ItemCard extends ConsumerWidget {
  final InventoryItem item;
  const _ItemCard({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catStockAsync = ref.watch(categoryStockProvider(item.category));
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => context.go('/inventory/${item.id}'),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  item.imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: item.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                            color: colors.surfaceContainerHighest,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (_, __, ___) =>
                              _PlaceholderIcon(colors: colors),
                        )
                      : _PlaceholderIcon(colors: colors),

                  // Stock badge — shows category total
                  Positioned(
                    top: 8,
                    right: 8,
                    child: catStockAsync.when(
                      data: (cs) => _StockBadge(stock: cs.total),
                      loading: () => _StockBadge.loading(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ),

            // Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: colors.secondaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item.category,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colors.onSecondaryContainer,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (item.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Expanded(
                        child: Text(
                          item.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: colors.onSurfaceVariant),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stock badge
// ---------------------------------------------------------------------------

class _StockBadge extends StatelessWidget {
  final int? stock;
  final bool isLoading;

  const _StockBadge({required this.stock}) : isLoading = false;
  const _StockBadge.loading() : stock = null, isLoading = true;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    Color bg;
    Color fg;
    if (isLoading || stock == null) {
      bg = colors.surfaceContainerHighest;
      fg = colors.onSurface;
    } else if (stock! <= 0) {
      bg = colors.errorContainer;
      fg = colors.onErrorContainer;
    } else if (stock! < 10) {
      bg = Colors.orange.shade100;
      fg = Colors.orange.shade900;
    } else {
      bg = colors.primaryContainer;
      fg = colors.onPrimaryContainer;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: isLoading
          ? SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(strokeWidth: 1.5, color: fg),
            )
          : Text(
              '$stock',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontWeight: FontWeight.bold, color: fg),
            ),
    );
  }
}

// ---------------------------------------------------------------------------
// Placeholder icon
// ---------------------------------------------------------------------------

class _PlaceholderIcon extends StatelessWidget {
  final ColorScheme colors;
  const _PlaceholderIcon({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.surfaceContainerHighest,
      child: Center(
        child: Icon(Icons.inventory_2_outlined, size: 48, color: colors.outline),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Search delegate
// ---------------------------------------------------------------------------

class _InventorySearchDelegate extends SearchDelegate<String?> {
  final List<InventoryItem> items;

  _InventorySearchDelegate(this.items);

  @override
  List<Widget> buildActions(BuildContext context) => [
    if (query.isNotEmpty)
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
  ];

  @override
  Widget buildLeading(BuildContext context) =>
      IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));

  @override
  Widget buildResults(BuildContext context) => _buildList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context);

  Widget _buildList(BuildContext context) {
    final lowerQuery = query.toLowerCase();
    final filtered = items
        .where((i) =>
            i.name.toLowerCase().contains(lowerQuery) ||
            i.category.toLowerCase().contains(lowerQuery))
        .toList();

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final item = filtered[index];
        return ListTile(
          leading: item.imageUrl.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: item.imageUrl,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                )
              : const CircleAvatar(child: Icon(Icons.inventory_2_outlined)),
          title: Text(item.name),
          subtitle: Text(item.category),
          onTap: () {
            close(context, null);
            context.go('/inventory/${item.id}');
          },
        );
      },
    );
  }
}
