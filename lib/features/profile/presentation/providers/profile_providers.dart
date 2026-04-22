import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mock_profile_repository.dart';
import '../../domain/entities/profile_entities.dart';
import '../../domain/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>(
  (Ref ref) => MockProfileRepository(),
);

final profileHubProvider = FutureProvider<ProfileHubEntity>((Ref ref) {
  return ref.watch(profileRepositoryProvider).getProfileHub();
});

final shippingAddressProvider = FutureProvider<ShippingAddressEntity>((
  Ref ref,
) {
  return ref.watch(profileRepositoryProvider).getShippingAddress();
});

/// True when the user should see a Profile tab / header reminder for vouchers.
final profileVoucherReminderProvider = Provider<bool>((Ref ref) {
  final AsyncValue<ProfileHubEntity> hub = ref.watch(profileHubProvider);
  return hub.maybeWhen(
    data: (ProfileHubEntity d) => d.voucherSummary.showReminder,
    orElse: () => false,
  );
});

final vouchersHubProvider = FutureProvider<VouchersHubEntity>((Ref ref) {
  return ref.watch(profileRepositoryProvider).getVouchersHub();
});

final profileShipmentsProvider = FutureProvider<List<ShipmentCardEntity>>((
  Ref ref,
) {
  return ref.watch(profileRepositoryProvider).getShipments();
});

final profileTabShipmentsProvider =
    FutureProvider.family<List<ShipmentCardEntity>, ProfileOrdersTab>((
      Ref ref,
      ProfileOrdersTab tab,
    ) {
      return ref.watch(profileRepositoryProvider).getShipmentsForTab(tab);
    });

final profileTrackingProvider =
    FutureProvider.family<TrackingOverviewEntity, String>((
      Ref ref,
      String shipmentId,
    ) {
      return ref.watch(profileRepositoryProvider).getTracking(shipmentId);
    });

final profileHistoryProvider = FutureProvider<List<HistoryLineEntity>>((
  Ref ref,
) {
  return ref.watch(profileRepositoryProvider).getHistory();
});

final profileActivityProvider =
    FutureProvider.family<ActivityMonthEntity, String>((
      Ref ref,
      String monthKey,
    ) {
      return ref.watch(profileRepositoryProvider).getActivity(monthKey);
    });

final profileReviewableItemsProvider =
    FutureProvider.family<List<ReviewableItemEntity>, String>((
      Ref ref,
      String shipmentId,
    ) {
      return ref.watch(profileRepositoryProvider).getReviewableItems(shipmentId);
    });
