import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/profile_entities.dart';
import '../../domain/repositories/profile_repository.dart';
import '../providers/profile_providers.dart';
import '../widgets/profile_icon_actions.dart';
import '../widgets/profile_story_card.dart';
import '../widgets/profile_voucher_summary_card.dart';
import 'profile_activity_page.dart';
import 'profile_orders_tab_page.dart';
import 'profile_to_receive_page.dart';
import 'vouchers_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  void _snack(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ProfileHubEntity> hub = ref.watch(profileHubProvider);
    return hub.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object e, StackTrace st) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 12),
              Text(
                'Failed to load profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(e.toString(), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
      data: (ProfileHubEntity data) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _Avatar(url: data.user.avatarUrl),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: FilledButton(
                              key: const Key('profile_my_activity_button'),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) =>
                                        const ProfileActivityPage(),
                                  ),
                                );
                              },
                              style: FilledButton.styleFrom(
                                minimumSize: const Size(0, 44),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                              child: const Text(
                                'My Activity',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ProfileIconActions(
                            onScan: () =>
                                _snack(context, 'Scanner coming soon'),
                            onFilter: () =>
                                _snack(context, 'Filters coming soon'),
                            onSettings: () =>
                                _snack(context, 'Settings coming soon'),
                            filterHasBadge: data.voucherSummary.showReminder,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Text(
                  key: const Key('profile_greeting'),
                  'Hello, ${data.user.displayName}!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: ProfileVoucherSummaryCard(
                  summary: data.voucherSummary,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const VouchersPage(),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  'Recently viewed',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 88,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: data.recentlyViewedImageUrls.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (BuildContext context, int index) {
                    final String url = data.recentlyViewedImageUrls[index];
                    return _RecentCircle(url: url);
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Text(
                  key: const Key('profile_my_orders_section'),
                  'My Orders',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Row(
                  children: <Widget>[
                    _OrderFunnelChip(
                      key: const Key('profile_chip_to_pay'),
                      label: 'To Pay',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const ProfileOrdersTabPage(
                              tab: ProfileOrdersTab.toPay,
                              title: 'To Pay',
                              subtitle: 'My Orders',
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    _OrderFunnelChip(
                      key: const Key('profile_chip_to_receive'),
                      label: 'To Receive',
                      showDot: data.funnelCounts.toReceiveHasBadge,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const ProfileToReceivePage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    _OrderFunnelChip(
                      key: const Key('profile_chip_to_review'),
                      label: 'To Review',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const ProfileOrdersTabPage(
                              tab: ProfileOrdersTab.toReview,
                              title: 'To Review',
                              subtitle: 'My Orders',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              key: const Key('profile_stories_section'),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Stories',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 156,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  itemCount: data.stories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (BuildContext context, int index) {
                    final StoryEntity s = data.stories[index];
                    return ProfileStoryCard(
                      imageUrl: s.imageUrl,
                      isLive: s.isLive,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.pink.shade200,
          width: 2,
        ),
      ),
      child: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(url),
        onBackgroundImageError: (_, __) {},
        child: const SizedBox.shrink(),
      ),
    );
  }
}

class _RecentCircle extends StatelessWidget {
  const _RecentCircle({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.9),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(url),
        onBackgroundImageError: (_, __) {},
      ),
    );
  }
}

class _OrderFunnelChip extends StatelessWidget {
  const _OrderFunnelChip({
    super.key,
    required this.label,
    required this.onTap,
    this.showDot = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Material(
            color: AppColors.blobLightBlue.withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(24),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (showDot)
            Positioned(
              right: 6,
              top: 4,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
