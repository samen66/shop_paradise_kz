import 'package:flutter/foundation.dart';

import '../../orders/domain/entities/order_entities.dart';
import '../../profile/domain/entities/profile_entities.dart';

/// Arguments for [customerCareChatControllerProvider] (family).
@immutable
class CustomerCareChatArgs {
  const CustomerCareChatArgs({
    required this.displayName,
    required this.welcomeMessage,
  });

  final String displayName;
  final String welcomeMessage;

  @override
  bool operator ==(Object other) {
    return other is CustomerCareChatArgs &&
        other.displayName == displayName &&
        other.welcomeMessage == welcomeMessage;
  }

  @override
  int get hashCode => Object.hash(displayName, welcomeMessage);
}

/// High-level issue category (first bottom sheet).
enum IssueCategory {
  order,
  itemQuality,
  payment,
  technical,
  other,
}

/// Which sheet the UI should present next, if any.
enum CustomerCareSheetStep {
  /// No automatic sheet; conversation or rating handled separately.
  none,

  /// Pick main category.
  category,

  /// Pick sub-issue for the selected category.
  subIssue,

  /// Pick an order for context (when [IssueFlowConfig.requiresOrderContext]).
  order,
}

enum CustomerCareHeaderKind {
  chatBot,
  agent,
}

@immutable
class IssueFlowConfig {
  const IssueFlowConfig({
    required this.subIssueIds,
    required this.requiresOrderContext,
  });

  final List<String> subIssueIds;
  final bool requiresOrderContext;
}

@immutable
sealed class ChatListItem {
  const ChatListItem();
}

/// Initial bot welcome (lavender bubble).
@immutable
class ChatBotTextItem extends ChatListItem {
  const ChatBotTextItem(this.text);

  final String text;
}

/// User’s pill-shaped selection (right side).
@immutable
class ChatUserChipItem extends ChatListItem {
  const ChatUserChipItem(this.text);

  final String text;
}

/// Order summary card on the user side.
@immutable
class ChatUserOrderCardItem extends ChatListItem {
  const ChatUserOrderCardItem(this.order);

  final OrderSummaryEntity order;
}

/// Agent message (blue bubble).
@immutable
class ChatAgentTextItem extends ChatListItem {
  const ChatAgentTextItem(this.text);

  final String text;
}

/// “Connecting you with an agent” row.
@immutable
class ChatConnectingItem extends ChatListItem {
  const ChatConnectingItem();
}

/// Embedded voucher card.
@immutable
class ChatVoucherItem extends ChatListItem {
  const ChatVoucherItem(this.voucher);

  final VoucherEntity voucher;
}

@immutable
class CustomerCareChatState {
  const CustomerCareChatState({
    required this.displayName,
    required this.items,
    required this.sheetStep,
    required this.selectedCategory,
    required this.selectedSubIssueId,
    required this.selectedOrder,
    required this.headerKind,
    required this.orders,
    required this.ordersLoading,
    required this.showRatingSheet,
  });

  final String displayName;
  final List<ChatListItem> items;
  final CustomerCareSheetStep sheetStep;
  final IssueCategory? selectedCategory;
  final String? selectedSubIssueId;
  final OrderSummaryEntity? selectedOrder;
  final CustomerCareHeaderKind headerKind;
  final List<OrderSummaryEntity> orders;
  final bool ordersLoading;
  final bool showRatingSheet;

  CustomerCareChatState copyWith({
    String? displayName,
    List<ChatListItem>? items,
    CustomerCareSheetStep? sheetStep,
    IssueCategory? selectedCategory,
    String? selectedSubIssueId,
    OrderSummaryEntity? selectedOrder,
    bool clearSelectedOrder = false,
    CustomerCareHeaderKind? headerKind,
    List<OrderSummaryEntity>? orders,
    bool? ordersLoading,
    bool? showRatingSheet,
  }) {
    return CustomerCareChatState(
      displayName: displayName ?? this.displayName,
      items: items ?? this.items,
      sheetStep: sheetStep ?? this.sheetStep,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedSubIssueId: selectedSubIssueId ?? this.selectedSubIssueId,
      selectedOrder: clearSelectedOrder
          ? null
          : (selectedOrder ?? this.selectedOrder),
      headerKind: headerKind ?? this.headerKind,
      orders: orders ?? this.orders,
      ordersLoading: ordersLoading ?? this.ordersLoading,
      showRatingSheet: showRatingSheet ?? this.showRatingSheet,
    );
  }
}
