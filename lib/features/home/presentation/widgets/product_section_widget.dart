import 'package:flutter/material.dart';

import '../../domain/entities/home_entities.dart';
import 'product_card_widget.dart';

class ProductSectionWidget extends StatelessWidget {
  const ProductSectionWidget({
    super.key,
    required this.items,
    required this.layout,
    this.bottomLoader,
    this.onItemTap,
  });

  final List<HomeItemEntity> items;
  final HomeSectionLayout layout;
  final Widget? bottomLoader;
  final ValueChanged<HomeItemEntity>? onItemTap;

  @override
  Widget build(BuildContext context) {
    if (layout == HomeSectionLayout.grid2) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length + (bottomLoader != null ? 1 : 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index >= items.length && bottomLoader != null) {
              return bottomLoader!;
            }
            return ProductCardWidget(
              item: items[index],
              onTap: () => onItemTap?.call(items[index]),
            );
          },
        ),
      );
    }
    if (layout == HomeSectionLayout.circles) {
      return SizedBox(
        height: 92,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (BuildContext context, int index) {
            final HomeItemEntity item = items[index];
            return InkWell(
              onTap: () => onItemTap?.call(item),
              borderRadius: BorderRadius.circular(30),
              child: Column(
                children: <Widget>[
                  ClipOval(
                    child: Image.network(
                      item.imageUrl,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const ColoredBox(
                        color: Color(0x22000000),
                        child: SizedBox(width: 56, height: 56),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 64,
                    child: Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
    return SizedBox(
      height: 212,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (BuildContext context, int index) => SizedBox(
          width: 150,
          child: ProductCardWidget(
            item: items[index],
            isCompact: true,
            onTap: () => onItemTap?.call(items[index]),
          ),
        ),
      ),
    );
  }
}
