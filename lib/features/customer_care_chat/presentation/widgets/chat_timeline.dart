import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../orders/domain/entities/order_entities.dart';
import '../../../profile/presentation/widgets/voucher_ticket_card.dart';
import '../../domain/chat_models.dart';
import 'chat_order_summary_card.dart';

class ChatTimeline extends StatelessWidget {
  const ChatTimeline({
    super.key,
    required this.items,
    required this.connectingLabel,
    required this.collectLabel,
    required this.formatItemCount,
    required this.standardDeliveryLabel,
    this.onCollectVoucher,
  });

  final List<ChatListItem> items;
  final String connectingLabel;
  final String collectLabel;
  final String Function(int count) formatItemCount;
  final String standardDeliveryLabel;
  final VoidCallback? onCollectVoucher;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final ChatListItem item = items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _ChatItemView(
            item: item,
            connectingLabel: connectingLabel,
            collectLabel: collectLabel,
            formatItemCount: formatItemCount,
            standardDeliveryLabel: standardDeliveryLabel,
            onCollectVoucher: onCollectVoucher,
          ),
        );
      },
    );
  }
}

class _ChatItemView extends StatelessWidget {
  const _ChatItemView({
    required this.item,
    required this.connectingLabel,
    required this.collectLabel,
    required this.formatItemCount,
    required this.standardDeliveryLabel,
    this.onCollectVoucher,
  });

  final ChatListItem item;
  final String connectingLabel;
  final String collectLabel;
  final String Function(int count) formatItemCount;
  final String standardDeliveryLabel;
  final VoidCallback? onCollectVoucher;

  @override
  Widget build(BuildContext context) {
    return switch (item) {
      ChatBotTextItem(:final String text) => _AlignBubble(
        align: Alignment.centerLeft,
        child: _BotBubble(text: text),
      ),
      ChatAgentTextItem(:final String text) => _AlignBubble(
        align: Alignment.centerLeft,
        child: _AgentBubble(text: text),
      ),
      ChatUserChipItem(:final String text) => _AlignBubble(
        align: Alignment.centerRight,
        child: _UserChip(text: text),
      ),
      ChatUserOrderCardItem(:final OrderSummaryEntity order) => Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 340),
          child: ChatOrderSummaryCard(
            order: order,
            itemCountLabel: formatItemCount(order.itemCount),
            deliveryLabel: standardDeliveryLabel,
          ),
        ),
      ),
      ChatConnectingItem() => _ConnectingRow(label: connectingLabel),
      ChatVoucherItem(:final voucher) => Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: VoucherTicketCard(
            voucher: voucher,
            collectLabel: collectLabel,
            onCollectPressed: onCollectVoucher,
          ),
        ),
      ),
    };
  }
}

class _AlignBubble extends StatelessWidget {
  const _AlignBubble({required this.align, required this.child});

  final Alignment align;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.86,
        ),
        child: child,
      ),
    );
  }
}

class _BotBubble extends StatelessWidget {
  const _BotBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.blobLightBlue,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.onSurface,
            height: 1.35,
          ),
        ),
      ),
    );
  }
}

class _AgentBubble extends StatelessWidget {
  const _AgentBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.onPrimary,
            height: 1.35,
          ),
        ),
      ),
    );
  }
}

class _UserChip extends StatelessWidget {
  const _UserChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.check_circle, color: AppColors.onPrimary, size: 18),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConnectingRow extends StatefulWidget {
  const _ConnectingRow({required this.label});

  final String label;

  @override
  State<_ConnectingRow> createState() => _ConnectingRowState();
}

class _ConnectingRowState extends State<_ConnectingRow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 36,
          height: 12,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List<Widget>.generate(3, (int i) {
                  final double t = (_controller.value + i * 0.2) % 1.0;
                  final double opacity = 0.3 + 0.7 * (1 - (t - 0.5).abs() * 2).clamp(0.0, 1.0);
                  return Opacity(
                    opacity: opacity,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
