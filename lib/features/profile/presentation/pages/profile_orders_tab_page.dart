import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../domain/entities/profile_entities.dart'
    show ProfileHubEntity, ShipmentCardEntity;
import '../../domain/repositories/profile_repository.dart';
import '../providers/profile_providers.dart';
import '../widgets/profile_icon_actions.dart';
import '../widgets/profile_review_flow.dart';
import '../widgets/profile_shipment_card.dart';
import 'order_tracking_page.dart';
import 'settings_page.dart';

class ProfileOrdersTabPage extends ConsumerWidget {
  const ProfileOrdersTabPage({
    super.key,
    required this.tab,
    required this.title,
    this.subtitle,
  });

  final ProfileOrdersTab tab;
  final String title;
  final String? subtitle;

  void _snack(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ProfileHubEntity> hub = ref.watch(profileHubProvider);
    final AsyncValue<List<ShipmentCardEntity>> shipments = ref.watch(
      profileTabShipmentsProvider(tab),
    );

    return Scaffold(
      body: SafeArea(
        child: hub.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object e, _) => Center(
            child: Text(context.l10n.errorMessageWithDetails(e.toString())),
          ),
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
                              title,
                              key: tab == ProfileOrdersTab.toReceive
                                  ? const Key('profile_to_receive_title')
                                  : null,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            if (subtitle != null)
                              Text(
                                subtitle!,
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
                        onScan: () =>
                            _snack(context, context.l10n.profileScannerSoon),
                        onFilter: () =>
                            _snack(context, context.l10n.profileFiltersSoon),
                        onSettings: () => openAppSettings(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: shipments.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (Object e, _) => Center(
                      child: Text(
                        context.l10n.errorMessageWithDetails(e.toString()),
                      ),
                    ),
                    data: (List<ShipmentCardEntity> list) {
                      if (list.isEmpty) {
                        return Center(
                          child: Text(
                            context.l10n.profileNothingHereYet,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          final ShipmentCardEntity s = list[index];
                          return ProfileShipmentCard(
                            key: ValueKey<String>(s.id),
                            shipment: s,
                            onPay: () => _snack(
                              context,
                              context.l10n.profilePaymentFlowSoon,
                            ),
                            onTrack: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => OrderTrackingPage(
                                    shipmentId: s.id,
                                  ),
                                ),
                              );
                            },
                            onReview: () => showProfileReviewFlow(
                              context,
                              ref,
                              s.id,
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
