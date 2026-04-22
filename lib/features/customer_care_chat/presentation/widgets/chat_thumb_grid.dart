import 'package:flutter/material.dart';

/// Four stable preview URLs for an order id (matches home mock style).
List<String> chatOrderPreviewImageUrls(String orderId) {
  return List<String>.generate(
    4,
    (int i) => 'https://picsum.photos/seed/${orderId}_$i/120/120',
  );
}

class ChatThumbGrid extends StatelessWidget {
  const ChatThumbGrid({super.key, required this.orderId, this.size = 56});

  final String orderId;
  final double size;

  @override
  Widget build(BuildContext context) {
    final List<String> urls = chatOrderPreviewImageUrls(orderId);
    final double cell = size / 2;
    return SizedBox(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          padding: EdgeInsets.zero,
          children: List<Widget>.generate(4, (int i) {
            return Image.network(
              urls[i],
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => ColoredBox(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: cell * 0.45,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
