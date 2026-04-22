import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/profile_entities.dart';
import '../providers/profile_providers.dart';
import '../widgets/profile_icon_actions.dart';
import '../widgets/profile_review_flow.dart';
import 'settings_page.dart';

class OrderTrackingPage extends ConsumerWidget {
  const OrderTrackingPage({super.key, required this.shipmentId});

  final String shipmentId;

  void _snack(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ProfileHubEntity> hub = ref.watch(profileHubProvider);
    final AsyncValue<TrackingOverviewEntity> tracking = ref.watch(
      profileTrackingProvider(shipmentId),
    );

    return Scaffold(
      body: SafeArea(
        child: hub.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object e, _) => Center(child: Text('$e')),
          data: (ProfileHubEntity hubData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 8, 12, 8),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.arrow_back_rounded),
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(hubData.user.avatarUrl),
                        onBackgroundImageError: (_, __) {},
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'To Receive',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            Text(
                              'Track Your Order',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      ProfileIconActions(
                        onScan: () => _snack(context, 'Scanner coming soon'),
                        onFilter: () => _snack(context, 'Filters coming soon'),
                        onSettings: () => openAppSettings(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: tracking.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (Object e, _) => Center(child: Text('$e')),
                    data: (TrackingOverviewEntity data) {
                      return ListView(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                        children: <Widget>[
                          _OrderProgressBar(
                            currentIndex: data.currentProgressIndex,
                          ),
                          const SizedBox(height: 20),
                          _TrackingNumberCard(
                            trackingNumber: data.trackingNumber,
                            onCopy: () async {
                              await Clipboard.setData(
                                ClipboardData(text: data.trackingNumber),
                              );
                              if (!context.mounted) {
                                return;
                              }
                              _snack(context, 'Copied tracking number');
                            },
                          ),
                          const SizedBox(height: 24),
                          ...data.steps.map((TimelineStepEntity step) {
                            return _TimelineTile(
                              step: step,
                              onAlertTap: step.opensDeliveryFailureSheet
                                  ? () => showDeliveryFailureSheet(context)
                                  : null,
                            );
                          }),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OrderProgressBar extends StatelessWidget {
  const _OrderProgressBar({required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final double progress = ((currentIndex + 1) / 3).clamp(0.0, 1.0);
    return SizedBox(
      height: 36,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints c) {
            final double trackWidth = c.maxWidth;
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      Container(
                        width: trackWidth,
                        height: 6,
                        decoration: BoxDecoration(
                          color: AppColors.blobLightBlue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Container(
                        width: trackWidth * progress,
                        height: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: const LinearGradient(
                            colors: <Color>[
                              AppColors.primary,
                              Color(0xFF00C9A7),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List<Widget>.generate(3, (int i) {
                    final bool done = i <= currentIndex;
                    return Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: done ? AppColors.primary : scheme.surface,
                        border: Border.all(
                          color: done
                              ? AppColors.primary
                              : AppColors.blobLightBlue,
                          width: 3,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TrackingNumberCard extends StatelessWidget {
  const _TrackingNumberCard({
    required this.trackingNumber,
    required this.onCopy,
  });

  final String trackingNumber;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    return Material(
      color: scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Tracking Number',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    key: const Key('profile_tracking_number_value'),
                    trackingNumber,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onCopy,
              icon: Icon(Icons.copy_outlined, color: scheme.primary),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  const _TimelineTile({required this.step, this.onAlertTap});

  final TimelineStepEntity step;
  final VoidCallback? onAlertTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final bool muted = step.style == TimelineStepStyle.upcoming;
    final bool alert = step.style == TimelineStepStyle.alert;

    final TextStyle titleStyle = theme.textTheme.titleSmall!.copyWith(
      fontWeight: FontWeight.w800,
      color: alert
          ? scheme.primary
          : muted
          ? scheme.onSurfaceVariant.withValues(alpha: 0.55)
          : scheme.onSurface,
    );

    final Widget titleRow = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: alert
              ? InkWell(
                  onTap: onAlertTap,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(step.title, style: titleStyle),
                      ),
                      Icon(Icons.chevron_right, color: scheme.primary),
                    ],
                  ),
                )
              : Text(step.title, style: titleStyle),
        ),
        if (step.timestampLabel != null)
          _TimeChip(
            label: step.timestampLabel!,
            emphasizeError: alert,
          )
        else if (step.expectedLabel != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.blobLightBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              step.expectedLabel!,
              style: theme.textTheme.labelSmall?.copyWith(
                color: scheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          titleRow,
          const SizedBox(height: 8),
          Text(
            step.body,
            style: theme.textTheme.bodySmall?.copyWith(
              color: muted
                  ? scheme.onSurfaceVariant.withValues(alpha: 0.5)
                  : scheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeChip extends StatelessWidget {
  const _TimeChip({required this.label, this.emphasizeError = false});

  final String label;
  final bool emphasizeError;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: emphasizeError
            ? AppColors.error.withValues(alpha: 0.12)
            : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: emphasizeError ? AppColors.error : theme.colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
