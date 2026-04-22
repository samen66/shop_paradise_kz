import 'package:flutter/material.dart';

import '../../../home/domain/entities/home_entities.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.item});

  final HomeItemEntity item;

  @override
  Widget build(BuildContext context) {
    final ProductDetailsEntity details =
        item.details ?? _buildFallbackDetails(item);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final List<String> gallery = details.galleryImageUrls.isEmpty
        ? <String>[item.imageUrl]
        : details.galleryImageUrls;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _HeroSection(
              imageUrl: gallery.first,
              imageCount: gallery.length,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 120),
            sliver: SliverList.list(
              children: <Widget>[
                Text(
                  _formatPrice(item.price),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  details.description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(height: 1.4),
                ),
                const SizedBox(height: 14),
                _VariationsSection(variations: details.variations),
                const SizedBox(height: 18),
                _SpecificationsSection(specifications: details.specifications),
                const SizedBox(height: 18),
                _OriginSection(
                  originLabel: details.originLabel,
                  sizeGuideLabel: details.sizeGuideLabel,
                ),
                const SizedBox(height: 18),
                _DeliverySection(options: details.deliveryOptions),
                const SizedBox(height: 20),
                _ReviewSection(reviewPreview: details.reviewPreview),
                const SizedBox(height: 20),
                _RelatedHorizontalSection(
                  title: 'Most Popular',
                  items: details.mostPopularItems,
                ),
                const SizedBox(height: 18),
                _RelatedGridSection(
                  title: 'You Might Like',
                  items: details.youMightLikeItems,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(Icons.favorite_border, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.tonal(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF202020),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: const Text('Add to cart'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF004CFF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: const Text('Buy now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.imageUrl, required this.imageCount});

  final String imageUrl;
  final int imageCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 445,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => ColoredBox(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                imageCount.clamp(1, 5),
                (int index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: index == 0 ? 40 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: index == 0
                        ? const Color(0xFF0042E0)
                        : Colors.white70,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VariationsSection extends StatelessWidget {
  const _VariationsSection({required this.variations});

  final List<ProductVariationEntity> variations;

  @override
  Widget build(BuildContext context) {
    final ProductVariationEntity? color = variations
        .cast<ProductVariationEntity?>()
        .firstWhere(
          (ProductVariationEntity? item) =>
              item?.label.toLowerCase() == 'color',
          orElse: () => null,
        );
    final ProductVariationEntity? size = variations
        .cast<ProductVariationEntity?>()
        .firstWhere(
          (ProductVariationEntity? item) => item?.label.toLowerCase() == 'size',
          orElse: () => null,
        );
    final List<String> previews = color?.previewImageUrls ?? <String>[];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(
          title: 'Variations',
          trailing: const _CircleActionButton(),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            if (color != null)
              _InfoChip(label: color.label, value: color.value),
            const SizedBox(width: 8),
            if (size != null) _InfoChip(label: size.label, value: size.value),
          ],
        ),
        if (previews.isNotEmpty) ...<Widget>[
          const SizedBox(height: 10),
          SizedBox(
            height: 75,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  previews[index],
                  width: 75,
                  height: 75,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => ColoredBox(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    child: const SizedBox(width: 75, height: 75),
                  ),
                ),
              ),
              separatorBuilder: (_, __) => const SizedBox(width: 6),
              itemCount: previews.length,
            ),
          ),
        ],
      ],
    );
  }
}

class _SpecificationsSection extends StatelessWidget {
  const _SpecificationsSection({required this.specifications});

  final List<ProductSpecificationEntity> specifications;

  @override
  Widget build(BuildContext context) {
    if (specifications.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Specifications',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        ...specifications.map(
          (ProductSpecificationEntity spec) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  spec.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: spec.values
                      .map((String value) => _PlainChip(label: value))
                      .toList(growable: false),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OriginSection extends StatelessWidget {
  const _OriginSection({
    required this.originLabel,
    required this.sizeGuideLabel,
  });

  final String? originLabel;
  final String? sizeGuideLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Origin',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        _PlainChip(
          label: originLabel ?? 'EU',
          background: const Color(0xFFE5EBFC),
        ),
        const SizedBox(height: 8),
        _SectionTitle(
          title: sizeGuideLabel ?? 'Size guide',
          trailing: const _CircleActionButton(),
        ),
      ],
    );
  }
}

class _DeliverySection extends StatelessWidget {
  const _DeliverySection({required this.options});

  final List<DeliveryOptionEntity> options;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Delivery',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        ...options.map(
          (DeliveryOptionEntity option) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF004CFF)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(child: Text(option.title)),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F8FF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    option.etaLabel,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: const Color(0xFF004CFF),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _formatPrice(option.price),
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ReviewSection extends StatelessWidget {
  const _ReviewSection({required this.reviewPreview});

  final ProductReviewPreviewEntity? reviewPreview;

  @override
  Widget build(BuildContext context) {
    final ProductReviewPreviewEntity review =
        reviewPreview ??
        const ProductReviewPreviewEntity(
          overallRatingText: '4/5',
          authorName: 'Veronika',
          authorAvatarUrl: '',
          comment: 'No reviews yet.',
          rating: 4,
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Rating & Reviews',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            ...List<Widget>.generate(5, (int index) {
              final bool isFilled = index < review.rating.round();
              return Icon(
                isFilled ? Icons.star : Icons.star_border,
                color: const Color(0xFFFFD33C),
                size: 18,
              );
            }),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFDFE9FF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(review.overallRatingText),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 20,
              backgroundImage: review.authorAvatarUrl.isEmpty
                  ? null
                  : NetworkImage(review.authorAvatarUrl),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    review.authorName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    review.comment,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF004CFF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            child: const Text('View All Reviews'),
          ),
        ),
      ],
    );
  }
}

class _RelatedHorizontalSection extends StatelessWidget {
  const _RelatedHorizontalSection({required this.title, required this.items});

  final String title;
  final List<HomeItemEntity> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(title: title, trailing: const _CircleActionButton()),
        const SizedBox(height: 8),
        SizedBox(
          height: 170,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (BuildContext context, int index) {
              final HomeItemEntity item = items[index];
              return SizedBox(
                width: 104,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.network(
                        item.imageUrl,
                        width: 104,
                        height: 140,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => ColoredBox(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          child: const SizedBox(width: 104, height: 140),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _formatPrice(item.price),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RelatedGridSection extends StatelessWidget {
  const _RelatedGridSection({required this.title, required this.items});

  final String title;
  final List<HomeItemEntity> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (BuildContext context, int index) {
            final HomeItemEntity item = items[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(9),
                    ),
                    child: Image.network(
                      item.imageUrl,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => ColoredBox(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        child: const SizedBox(
                          height: 120,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _formatPrice(item.price),
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text('$label  $value'),
    );
  }
}

class _PlainChip extends StatelessWidget {
  const _PlainChip({
    required this.label,
    this.background = const Color(0xFFFFEBEB),
  });

  final String label;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label),
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  const _CircleActionButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: Color(0xFF004CFF),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
    );
  }
}

ProductDetailsEntity _buildFallbackDetails(
  HomeItemEntity item,
) => ProductDetailsEntity(
  description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam arcu mauris, scelerisque eu mauris id, pretium pulvinar sapien.',
  galleryImageUrls: <String>[item.imageUrl],
  variations: const <ProductVariationEntity>[
    ProductVariationEntity(label: 'Color', value: 'Pink'),
    ProductVariationEntity(label: 'Size', value: 'M'),
  ],
  specifications: const <ProductSpecificationEntity>[
    ProductSpecificationEntity(
      name: 'Material',
      values: <String>['Cotton 95%', 'Nylon 5%'],
    ),
  ],
  originLabel: 'EU',
  sizeGuideLabel: 'Size guide',
  deliveryOptions: const <DeliveryOptionEntity>[
    DeliveryOptionEntity(title: 'Standart', etaLabel: '5-7 days', price: 3),
    DeliveryOptionEntity(title: 'Express', etaLabel: '1-2 days', price: 12),
  ],
);

String _formatPrice(double? value) {
  if (value == null) {
    return '\$17,00';
  }
  return '\$${value.toStringAsFixed(2).replaceAll('.', ',')}';
}
