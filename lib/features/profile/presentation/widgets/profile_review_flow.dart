import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../customer_care_chat/presentation/pages/customer_care_chat_page.dart';
import '../../domain/entities/profile_entities.dart';
import '../providers/profile_providers.dart';

/// Opens item picker → review form → success dialog.
Future<void> showProfileReviewFlow(
  BuildContext context,
  WidgetRef ref,
  String shipmentId,
) async {
  final List<ReviewableItemEntity> items = await ref.read(
    profileReviewableItemsProvider(shipmentId).future,
  );
  if (!context.mounted) {
    return;
  }
  if (items.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.profileNoItemsToReview)),
    );
    return;
  }
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (BuildContext sheetContext) {
      final AppLocalizations l10n = sheetContext.l10n;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                l10n.profileReviewWhichItem,
                style: Theme.of(sheetContext).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (BuildContext context, int index) {
                    final ReviewableItemEntity item = items[index];
                    return _ReviewPickerRow(
                      item: item,
                      onReview: () async {
                        Navigator.of(sheetContext).pop();
                        if (!context.mounted) {
                          return;
                        }
                        await _showReviewFormSheet(context, item);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> showDeliveryFailureSheet(
  BuildContext context,
  WidgetRef ref,
) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (BuildContext ctx) {
      final AppLocalizations l10n = ctx.l10n;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                l10n.profileDeliveryNotSuccessful,
                style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.profileDeliveryWhatToDo,
                style: Theme.of(ctx).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.profileDeliveryFailureBody,
                style: Theme.of(ctx).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    Navigator.of(ctx).pop();
                    final ProfileHubEntity hub =
                        await ref.read(profileHubProvider.future);
                    if (!context.mounted) {
                      return;
                    }
                    await Navigator.of(context).push<void>(
                      MaterialPageRoute<void>(
                        builder: (_) => CustomerCareChatPage(
                          displayName: hub.user.displayName,
                        ),
                      ),
                    );
                  },
                  child: Text(l10n.profileChatNow),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> _showReviewFormSheet(
  BuildContext context,
  ReviewableItemEntity item,
) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (BuildContext ctx) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(ctx).bottom,
        ),
        child: _ReviewFormContent(
          item: item,
          onSubmit: (int stars) async {
            Navigator.of(ctx).pop();
            if (!context.mounted) {
              return;
            }
            await _showReviewSuccessDialog(context, stars);
          },
        ),
      );
    },
  );
}

Future<void> _showReviewSuccessDialog(
  BuildContext context,
  int stars,
) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext ctx) {
      final AppLocalizations l10n = ctx.l10n;
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.blobLightBlue,
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: AppColors.onPrimary),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.paymentSuccessTitle,
              style: Theme.of(ctx).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.profileReviewThankYou,
              style: Theme.of(ctx).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(5, (int i) {
                return Icon(
                  i < stars ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: Colors.amber.shade700,
                  size: 32,
                );
              }),
            ),
          ],
        ),
      );
    },
  );
}

class _ReviewPickerRow extends StatelessWidget {
  const _ReviewPickerRow({required this.item, required this.onReview});

  final ReviewableItemEntity item;
  final VoidCallback onReview;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations l10n = context.l10n;
    return Material(
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 56,
                height: 56,
                child: Image.network(
                  item.thumbnailUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => ColoredBox(
                    color: theme.colorScheme.surfaceContainerHighest,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.orderReference,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item.dateLabel,
                      style: theme.textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: onReview,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              child: Text(l10n.profileReview),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewFormContent extends StatefulWidget {
  const _ReviewFormContent({required this.item, required this.onSubmit});

  final ReviewableItemEntity item;
  final void Function(int stars) onSubmit;

  @override
  State<_ReviewFormContent> createState() => _ReviewFormContentState();
}

class _ReviewFormContentState extends State<_ReviewFormContent> {
  int _stars = 0;
  final TextEditingController _comment = TextEditingController();

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final AppLocalizations l10n = context.l10n;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              l10n.profileReview,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(widget.item.thumbnailUrl),
                  onBackgroundImageError: (_, __) {},
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.item.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.item.orderReference,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: List<Widget>.generate(5, (int i) {
                final bool filled = i < _stars;
                return IconButton(
                  iconSize: 36,
                  onPressed: () => setState(() => _stars = i + 1),
                  icon: Icon(
                    filled ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: filled ? Colors.amber.shade700 : scheme.onSurfaceVariant,
                  ),
                );
              }),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _comment,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: l10n.customerCareRateCommentHint,
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _stars == 0
                    ? null
                    : () => widget.onSubmit(_stars),
                child: Text(l10n.profileSayIt),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
