import '../../domain/entities/profile_entities.dart';
import '../../domain/repositories/profile_repository.dart';

class MockProfileRepository implements ProfileRepository {
  static const String _loremShort =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';

  static const List<String> _monthKeys = <String>['2026-04', '2026-03'];

  /// Anchored dates so "expiring" voucher stays consistent in tests and UI.
  static final DateTime _voucherExpiringSoon = DateTime(2026, 4, 25);
  static final DateTime _voucherLater = DateTime(2026, 6, 20);

  List<VoucherEntity> get _mockActiveVouchers => <VoucherEntity>[
        VoucherEntity(
          id: 'v_1',
          title: 'First Purchase',
          subtitle: '5% off for your next order',
          validUntil: _voucherExpiringSoon,
          status: VoucherStatus.collected,
          kind: VoucherVisualKind.shoppingBag,
          expiringWithinDays: 7,
        ),
        VoucherEntity(
          id: 'v_2',
          title: 'Gift From Customer Care',
          subtitle: '15% off for your next purchase',
          validUntil: _voucherLater,
          status: VoucherStatus.collected,
          kind: VoucherVisualKind.gift,
          expiringWithinDays: 7,
        ),
        VoucherEntity(
          id: 'v_3',
          title: 'Loyal Customer',
          subtitle: '10% off your next purchase',
          validUntil: _voucherLater,
          status: VoucherStatus.collected,
          kind: VoucherVisualKind.heart,
          expiringWithinDays: 7,
        ),
      ];

  List<RewardMilestoneEntity> get _mockMilestones => <RewardMilestoneEntity>[
        const RewardMilestoneEntity(
          id: 'm_1',
          title: 'First Purchase',
          description: _loremShort,
          progress: 1,
          kind: VoucherVisualKind.shoppingBag,
          isCompleted: true,
        ),
        const RewardMilestoneEntity(
          id: 'm_2',
          title: 'Loyal Customer',
          description: _loremShort,
          progress: 0.75,
          kind: VoucherVisualKind.heart,
        ),
        const RewardMilestoneEntity(
          id: 'm_3',
          title: 'Review Maker',
          description: _loremShort,
          progress: 0.25,
          kind: VoucherVisualKind.star,
        ),
        const RewardMilestoneEntity(
          id: 'm_4',
          title: 'Big Soul',
          description: _loremShort,
          progress: 0,
          kind: VoucherVisualKind.cloud,
        ),
        const RewardMilestoneEntity(
          id: 'm_5',
          title: 'T-Shirt Collector',
          description: _loremShort,
          progress: 0,
          kind: VoucherVisualKind.apparel,
        ),
        const RewardMilestoneEntity(
          id: 'm_6',
          title: '10+ Orders',
          description: _loremShort,
          progress: 0.2,
          kind: VoucherVisualKind.smile,
        ),
      ];

  static const ProfileVoucherSummaryEntity _voucherSummary =
      ProfileVoucherSummaryEntity(
    overallRewardsProgress: 0.75,
    body:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do '
        'eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    showReminder: true,
    expiringHeadline: 'Your voucher will expire in 3 days',
    centerKind: VoucherVisualKind.shoppingBag,
  );

  String _userDisplayName = 'Amanda';
  String _userEmail = 'amanda@example.com';
  String _userAvatarUrl = 'https://picsum.photos/seed/profile_amanda/200/200';

  ShippingAddressEntity _shippingAddress = const ShippingAddressEntity(
    countryName: '',
    addressLine: '',
    townCity: '',
    postcode: '',
    phone: '',
  );

  @override
  Future<void> saveProfileUser({
    required String displayName,
    required String email,
    String? avatarUrl,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    _userDisplayName = displayName.trim();
    _userEmail = email.trim();
    if (avatarUrl != null && avatarUrl.trim().isNotEmpty) {
      _userAvatarUrl = avatarUrl.trim();
    }
  }

  @override
  Future<ProfileHubEntity> getProfileHub() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return ProfileHubEntity(
      user: ProfileUserEntity(
        displayName: _userDisplayName,
        email: _userEmail,
        avatarUrl: _userAvatarUrl,
      ),
      announcement: const AnnouncementEntity(
        title: 'Announcement',
        body:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do '
            'eiusmod tempor incididunt ut labore.',
      ),
      voucherSummary: _voucherSummary,
      recentlyViewedImageUrls: List<String>.generate(
        5,
        (int i) => 'https://picsum.photos/seed/rv$i/160/160',
      ),
      stories: <StoryEntity>[
        StoryEntity(
          id: 'st_1',
          imageUrl: 'https://picsum.photos/seed/story1/200/280',
          isLive: true,
        ),
        StoryEntity(
          id: 'st_2',
          imageUrl: 'https://picsum.photos/seed/story2/200/280',
        ),
        StoryEntity(
          id: 'st_3',
          imageUrl: 'https://picsum.photos/seed/story3/200/280',
        ),
        StoryEntity(
          id: 'st_4',
          imageUrl: 'https://picsum.photos/seed/story4/200/280',
        ),
      ],
      funnelCounts: const OrderFunnelCountsEntity(
        toPay: 2,
        toReceive: 3,
        toReview: 1,
        toReceiveHasBadge: true,
      ),
    );
  }

  @override
  Future<ShippingAddressEntity> getShippingAddress() async {
    await Future<void>.delayed(const Duration(milliseconds: 60));
    return _shippingAddress;
  }

  @override
  Future<void> saveShippingAddress(ShippingAddressEntity address) async {
    await Future<void>.delayed(const Duration(milliseconds: 60));
    _shippingAddress = address;
  }

  @override
  Future<VouchersHubEntity> getVouchersHub() async {
    await Future<void>.delayed(const Duration(milliseconds: 90));
    return VouchersHubEntity(
      activeVouchers: _mockActiveVouchers,
      milestones: _mockMilestones,
      filterActionHasBadge: _voucherSummary.showReminder,
    );
  }

  List<ShipmentCardEntity> get _toReceiveShipments => <ShipmentCardEntity>[
      ShipmentCardEntity(
        id: 'shp_1',
        orderReference: 'Order #92287157',
        deliveryLabel: 'Standard Delivery',
        status: ShipmentUiStatus.packed,
        thumbnailUrls: <String>[
          'https://picsum.photos/seed/o1a/120/120',
          'https://picsum.photos/seed/o1b/120/120',
          'https://picsum.photos/seed/o1c/120/120',
        ],
        itemCount: 3,
      ),
      ShipmentCardEntity(
        id: 'shp_2',
        orderReference: 'Order #88210432',
        deliveryLabel: 'Standard Delivery',
        status: ShipmentUiStatus.shipped,
        thumbnailUrls: <String>[
          'https://picsum.photos/seed/o2a/120/120',
          'https://picsum.photos/seed/o2b/120/120',
          'https://picsum.photos/seed/o2c/120/120',
          'https://picsum.photos/seed/o2d/120/120',
        ],
        itemCount: 4,
      ),
      ShipmentCardEntity(
        id: 'shp_3',
        orderReference: 'Order #77190211',
        deliveryLabel: 'Standard Delivery',
        status: ShipmentUiStatus.delivered,
        thumbnailUrls: <String>['https://picsum.photos/seed/o3a/120/120'],
        itemCount: 1,
      ),
    ];

  @override
  Future<List<ShipmentCardEntity>> getShipments() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return _toReceiveShipments;
  }

  @override
  Future<List<ShipmentCardEntity>> getShipmentsForTab(
    ProfileOrdersTab tab,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 90));
    switch (tab) {
      case ProfileOrdersTab.toPay:
        return <ShipmentCardEntity>[
          ShipmentCardEntity(
            id: 'pay_1',
            orderReference: 'Order #66120098',
            deliveryLabel: 'Awaiting payment',
            status: ShipmentUiStatus.awaitingPayment,
            thumbnailUrls: <String>[
              'https://picsum.photos/seed/p1/120/120',
              'https://picsum.photos/seed/p2/120/120',
            ],
            itemCount: 2,
          ),
          ShipmentCardEntity(
            id: 'pay_2',
            orderReference: 'Order #55100987',
            deliveryLabel: 'Awaiting payment',
            status: ShipmentUiStatus.awaitingPayment,
            thumbnailUrls: <String>['https://picsum.photos/seed/p3/120/120'],
            itemCount: 1,
          ),
        ];
      case ProfileOrdersTab.toReceive:
        return _toReceiveShipments;
      case ProfileOrdersTab.toReview:
        return _toReceiveShipments
            .where((ShipmentCardEntity s) => s.status == ShipmentUiStatus.delivered)
            .toList(growable: false);
    }
  }

  @override
  Future<TrackingOverviewEntity> getTracking(String shipmentId) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    if (shipmentId == 'shp_2') {
      return TrackingOverviewEntity(
        shipmentId: shipmentId,
        currentProgressIndex: 1,
        trackingNumber: 'LGS-i92927839300763731',
        steps: <TimelineStepEntity>[
          const TimelineStepEntity(
            title: 'Packed',
            body:
                'Your parcel is packed and will be handed over to our delivery partner.',
            timestampLabel: 'April, 19 12:31',
            style: TimelineStepStyle.completed,
          ),
          const TimelineStepEntity(
            title: 'On the Way to Logistic Facility',
            body: _loremShort,
            timestampLabel: 'April, 19 16:20',
            style: TimelineStepStyle.completed,
          ),
          const TimelineStepEntity(
            title: 'Arrived at Logistic Facility',
            body: _loremShort,
            timestampLabel: 'April, 19 19:07',
            style: TimelineStepStyle.current,
          ),
          const TimelineStepEntity(
            title: 'Shipped',
            body: _loremShort,
            expectedLabel: 'Expected on April, 20',
            style: TimelineStepStyle.upcoming,
          ),
          const TimelineStepEntity(
            title: 'Attempt to deliver your parcel was not successful',
            body:
                'The courier could not complete delivery. Tap for next steps.',
            timestampLabel: 'April, 21 09:15',
            style: TimelineStepStyle.alert,
            opensDeliveryFailureSheet: true,
          ),
        ],
      );
    }
    if (shipmentId == 'shp_3') {
      return TrackingOverviewEntity(
        shipmentId: shipmentId,
        currentProgressIndex: 2,
        trackingNumber: 'LGS-i92927839300763731',
        steps: <TimelineStepEntity>[
          const TimelineStepEntity(
            title: 'Packed',
            body:
                'Your parcel is packed and will be handed over to our delivery partner.',
            timestampLabel: 'April, 19 12:31',
            style: TimelineStepStyle.completed,
          ),
          const TimelineStepEntity(
            title: 'Shipped',
            body: _loremShort,
            timestampLabel: 'April, 20 08:02',
            style: TimelineStepStyle.completed,
          ),
          const TimelineStepEntity(
            title: 'Delivered',
            body: 'Your order was delivered successfully.',
            timestampLabel: 'April, 21 14:40',
            style: TimelineStepStyle.completed,
          ),
        ],
      );
    }
    return TrackingOverviewEntity(
      shipmentId: shipmentId,
      currentProgressIndex: 0,
      trackingNumber: 'LGS-i92927839300763731',
      steps: <TimelineStepEntity>[
        const TimelineStepEntity(
          title: 'Packed',
          body:
              'Your parcel is packed and will be handed over to our delivery partner.',
          timestampLabel: 'April, 19 12:31',
          style: TimelineStepStyle.completed,
        ),
        const TimelineStepEntity(
          title: 'On the Way to Logistic Facility',
          body: _loremShort,
          timestampLabel: 'April, 19 16:20',
          style: TimelineStepStyle.current,
        ),
        const TimelineStepEntity(
          title: 'Arrived at Logistic Facility',
          body: _loremShort,
          style: TimelineStepStyle.upcoming,
        ),
        const TimelineStepEntity(
          title: 'Shipped',
          body: _loremShort,
          expectedLabel: 'Expected on April, 20',
          style: TimelineStepStyle.upcoming,
        ),
      ],
    );
  }

  @override
  Future<List<HistoryLineEntity>> getHistory() async {
    await Future<void>.delayed(const Duration(milliseconds: 110));
    return <HistoryLineEntity>[
      HistoryLineEntity(
        id: 'hist_1',
        thumbnailUrl: 'https://picsum.photos/seed/h1/120/120',
        title: _loremShort,
        orderReference: 'Order #92287157',
        dateLabel: 'April, 06',
        shipmentId: 'shp_3',
      ),
      HistoryLineEntity(
        id: 'hist_2',
        thumbnailUrl: 'https://picsum.photos/seed/h2/120/120',
        title: _loremShort,
        orderReference: 'Order #88210432',
        dateLabel: 'April, 06',
        shipmentId: 'shp_3',
      ),
    ];
  }

  @override
  Future<ActivityMonthEntity> getActivity(String monthKey) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final int index = _monthKeys.indexOf(monthKey);
    final String key = index >= 0 ? monthKey : _monthKeys.first;
    if (key == '2026-03') {
      return ActivityMonthEntity(
        monthKey: key,
        monthLabel: 'March',
        segments: <ActivitySegmentEntity>[
          ActivitySegmentEntity(
            label: 'Clothing',
            amount: 120,
            swatchArgb: 0xFF0055FF,
          ),
          ActivitySegmentEntity(
            label: 'Lingerie',
            amount: 40,
            swatchArgb: 0xFF4CAF50,
          ),
          ActivitySegmentEntity(
            label: 'Shoes',
            amount: 30,
            swatchArgb: 0xFFFF9800,
          ),
          ActivitySegmentEntity(
            label: 'Bags',
            amount: 25,
            swatchArgb: 0xFFE91E63,
          ),
        ],
        totalAmount: 215,
        orderedCount: 8,
        receivedCount: 5,
        toReceiveCount: 3,
      );
    }
    return ActivityMonthEntity(
      monthKey: key,
      monthLabel: 'April',
      segments: <ActivitySegmentEntity>[
        ActivitySegmentEntity(
          label: 'Clothing',
          amount: 183,
          swatchArgb: 0xFF0055FF,
        ),
        ActivitySegmentEntity(
          label: 'Lingerie',
          amount: 92,
          swatchArgb: 0xFF4CAF50,
        ),
        ActivitySegmentEntity(
          label: 'Shoes',
          amount: 47,
          swatchArgb: 0xFFFF9800,
        ),
        ActivitySegmentEntity(
          label: 'Bags',
          amount: 43,
          swatchArgb: 0xFFE91E63,
        ),
      ],
      totalAmount: 365,
      orderedCount: 12,
      receivedCount: 7,
      toReceiveCount: 5,
    );
  }

  @override
  Future<List<ReviewableItemEntity>> getReviewableItems(
    String shipmentId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return <ReviewableItemEntity>[
      ReviewableItemEntity(
        id: '${shipmentId}_line_1',
        thumbnailUrl: 'https://picsum.photos/seed/rev1/120/120',
        description: _loremShort,
        orderReference: 'Order #92287157',
        dateLabel: 'April, 06',
        shipmentId: shipmentId,
      ),
      ReviewableItemEntity(
        id: '${shipmentId}_line_2',
        thumbnailUrl: 'https://picsum.photos/seed/rev2/120/120',
        description: _loremShort,
        orderReference: 'Order #92287157',
        dateLabel: 'April, 06',
        shipmentId: shipmentId,
      ),
    ];
  }
}
