import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/profile_entities.dart';
import '../providers/profile_providers.dart';
import '../widgets/profile_icon_actions.dart';
import '../widgets/profile_review_flow.dart';
import 'settings_page.dart';

class ProfileHistoryPage extends ConsumerWidget {
  const ProfileHistoryPage({super.key});

  void _snack(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ProfileHubEntity> hub = ref.watch(profileHubProvider);
    final AsyncValue<List<HistoryLineEntity>> history = ref.watch(
      profileHistoryProvider,
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
                        child: Text(
                          'History',
                          key: const Key('profile_history_title'),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
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
                  child: history.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (Object e, _) => Center(child: Text('$e')),
                    data: (List<HistoryLineEntity> lines) {
                      return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                        itemCount: lines.length,
                        itemBuilder: (BuildContext context, int index) {
                          final HistoryLineEntity line = lines[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 14),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: SizedBox(
                                      width: 72,
                                      height: 72,
                                      child: Image.network(
                                        line.thumbnailUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            ColoredBox(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surfaceContainerHighest,
                                            ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          line.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          line.orderReference,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
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
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surfaceContainerHighest,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(line.dateLabel),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: OutlinedButton(
                                      onPressed: () => showProfileReviewFlow(
                                        context,
                                        ref,
                                        line.shipmentId,
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: AppColors.primary,
                                        side: const BorderSide(
                                          color: AppColors.primary,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            22,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                      ),
                                      child: const Text('Review'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
