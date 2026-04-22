import 'package:flutter/foundation.dart';

@immutable
class ProfileUserEntity {
  const ProfileUserEntity({
    required this.displayName,
    required this.email,
    required this.avatarUrl,
  });

  final String displayName;
  final String email;
  final String avatarUrl;
}

@immutable
class ShippingAddressEntity {
  const ShippingAddressEntity({
    required this.countryName,
    required this.addressLine,
    required this.townCity,
    required this.postcode,
    required this.phone,
  });

  /// Empty [countryName] shows “Choose your country” on the form.
  final String countryName;
  final String addressLine;
  final String townCity;
  final String postcode;
  final String phone;

  bool get hasCountry => countryName.trim().isNotEmpty;
}

@immutable
class AnnouncementEntity {
  const AnnouncementEntity({required this.title, required this.body});

  final String title;
  final String body;
}

@immutable
class StoryEntity {
  const StoryEntity({
    required this.id,
    required this.imageUrl,
    this.isLive = false,
  });

  final String id;
  final String imageUrl;
  final bool isLive;
}

@immutable
class OrderFunnelCountsEntity {
  const OrderFunnelCountsEntity({
    required this.toPay,
    required this.toReceive,
    required this.toReview,
    this.toReceiveHasBadge = false,
  });

  final int toPay;
  final int toReceive;
  final int toReview;
  final bool toReceiveHasBadge;
}

enum VoucherVisualKind { shoppingBag, gift, heart, star, cloud, apparel, smile }

enum VoucherStatus { collected }

@immutable
class VoucherEntity {
  const VoucherEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.validUntil,
    required this.status,
    required this.kind,
    this.expiringWithinDays = 7,
  });

  final String id;
  final String title;
  final String subtitle;
  final DateTime validUntil;
  final VoucherStatus status;
  final VoucherVisualKind kind;
  /// Vouchers with validity ending within this many days from [validUntil]
  /// comparison use urgent styling when `daysUntil(validUntil) <= expiringWithinDays`.
  final int expiringWithinDays;
}

@immutable
class RewardMilestoneEntity {
  const RewardMilestoneEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.kind,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final String description;
  final double progress;
  final VoucherVisualKind kind;
  final bool isCompleted;
}

@immutable
class ProfileVoucherSummaryEntity {
  const ProfileVoucherSummaryEntity({
    required this.overallRewardsProgress,
    required this.body,
    required this.showReminder,
    this.expiringHeadline,
    this.centerKind = VoucherVisualKind.shoppingBag,
  });

  final double overallRewardsProgress;
  final String body;
  final bool showReminder;
  final String? expiringHeadline;
  final VoucherVisualKind centerKind;
}

@immutable
class VouchersHubEntity {
  const VouchersHubEntity({
    required this.activeVouchers,
    required this.milestones,
    required this.filterActionHasBadge,
  });

  final List<VoucherEntity> activeVouchers;
  final List<RewardMilestoneEntity> milestones;
  final bool filterActionHasBadge;
}

@immutable
class ProfileHubEntity {
  const ProfileHubEntity({
    required this.user,
    required this.announcement,
    required this.voucherSummary,
    required this.recentlyViewedImageUrls,
    required this.stories,
    required this.funnelCounts,
  });

  final ProfileUserEntity user;
  final AnnouncementEntity announcement;
  final ProfileVoucherSummaryEntity voucherSummary;
  final List<String> recentlyViewedImageUrls;
  final List<StoryEntity> stories;
  final OrderFunnelCountsEntity funnelCounts;
}

enum ShipmentUiStatus { awaitingPayment, packed, shipped, delivered }

@immutable
class ShipmentCardEntity {
  const ShipmentCardEntity({
    required this.id,
    required this.orderReference,
    required this.deliveryLabel,
    required this.status,
    required this.thumbnailUrls,
    required this.itemCount,
  });

  final String id;
  final String orderReference;
  final String deliveryLabel;
  final ShipmentUiStatus status;
  final List<String> thumbnailUrls;
  final int itemCount;
}

enum TimelineStepStyle { completed, current, upcoming, alert }

@immutable
class TimelineStepEntity {
  const TimelineStepEntity({
    required this.title,
    required this.body,
    this.timestampLabel,
    this.expectedLabel,
    required this.style,
    this.opensDeliveryFailureSheet = false,
  });

  final String title;
  final String body;
  final String? timestampLabel;
  final String? expectedLabel;
  final TimelineStepStyle style;
  final bool opensDeliveryFailureSheet;
}

@immutable
class TrackingOverviewEntity {
  const TrackingOverviewEntity({
    required this.shipmentId,
    required this.currentProgressIndex,
    required this.trackingNumber,
    required this.steps,
  });

  final String shipmentId;
  final int currentProgressIndex;
  final String trackingNumber;
  final List<TimelineStepEntity> steps;
}

@immutable
class HistoryLineEntity {
  const HistoryLineEntity({
    required this.id,
    required this.thumbnailUrl,
    required this.title,
    required this.orderReference,
    required this.dateLabel,
    required this.shipmentId,
  });

  final String id;
  final String thumbnailUrl;
  final String title;
  final String orderReference;
  final String dateLabel;
  final String shipmentId;
}

@immutable
class ReviewableItemEntity {
  const ReviewableItemEntity({
    required this.id,
    required this.thumbnailUrl,
    required this.description,
    required this.orderReference,
    required this.dateLabel,
    required this.shipmentId,
  });

  final String id;
  final String thumbnailUrl;
  final String description;
  final String orderReference;
  final String dateLabel;
  final String shipmentId;
}

@immutable
class ActivitySegmentEntity {
  const ActivitySegmentEntity({
    required this.label,
    required this.amount,
    required this.swatchArgb,
  });

  final String label;
  final double amount;
  final int swatchArgb;
}

@immutable
class ActivityMonthEntity {
  const ActivityMonthEntity({
    required this.monthKey,
    required this.monthLabel,
    required this.segments,
    required this.totalAmount,
    required this.orderedCount,
    required this.receivedCount,
    required this.toReceiveCount,
  });

  final String monthKey;
  final String monthLabel;
  final List<ActivitySegmentEntity> segments;
  final double totalAmount;
  final int orderedCount;
  final int receivedCount;
  final int toReceiveCount;
}
