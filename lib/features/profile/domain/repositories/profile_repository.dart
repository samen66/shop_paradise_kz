import '../entities/profile_entities.dart';

enum ProfileOrdersTab { toPay, toReceive, toReview }

abstract class ProfileRepository {
  Future<ProfileHubEntity> getProfileHub();

  /// Persists profile fields for the signed-in user (mock: in-memory only).
  Future<void> saveProfileUser({
    required String displayName,
    required String email,
    String? avatarUrl,
  });

  Future<ShippingAddressEntity> getShippingAddress();

  Future<void> saveShippingAddress(ShippingAddressEntity address);

  Future<VouchersHubEntity> getVouchersHub();

  Future<List<ShipmentCardEntity>> getShipments();

  Future<List<ShipmentCardEntity>> getShipmentsForTab(ProfileOrdersTab tab);

  Future<TrackingOverviewEntity> getTracking(String shipmentId);

  Future<List<HistoryLineEntity>> getHistory();

  Future<ActivityMonthEntity> getActivity(String monthKey);

  Future<List<ReviewableItemEntity>> getReviewableItems(String shipmentId);
}
