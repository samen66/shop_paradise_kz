import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../orders/domain/entities/order_entities.dart';
import '../../../orders/domain/usecases/get_orders_use_case.dart';
import '../../../orders/presentation/providers/orders_providers.dart';
import '../../../profile/domain/entities/profile_entities.dart';
import '../../domain/chat_models.dart';
import '../../domain/issue_catalog.dart';

final customerCareChatControllerProvider = StateNotifierProvider.autoDispose
    .family<CustomerCareChatController, CustomerCareChatState,
        CustomerCareChatArgs>(
  (Ref ref, CustomerCareChatArgs args) {
    final GetOrdersUseCase orders = ref.watch(getOrdersUseCaseProvider);
    return CustomerCareChatController(
      args: args,
      getOrdersUseCase: orders,
    );
  },
);

class CustomerCareChatController extends StateNotifier<CustomerCareChatState> {
  CustomerCareChatController({
    required CustomerCareChatArgs args,
    required GetOrdersUseCase getOrdersUseCase,
  })  : _getOrdersUseCase = getOrdersUseCase,
        super(
          CustomerCareChatState(
            displayName: args.displayName,
            items: <ChatListItem>[ChatBotTextItem(args.welcomeMessage)],
            sheetStep: CustomerCareSheetStep.category,
            selectedCategory: null,
            selectedSubIssueId: null,
            selectedOrder: null,
            headerKind: CustomerCareHeaderKind.chatBot,
            orders: const <OrderSummaryEntity>[],
            ordersLoading: false,
            showRatingSheet: false,
          ),
        );

  final GetOrdersUseCase _getOrdersUseCase;
  bool _scriptStarted = false;
  bool _disposed = false;

  /// First name for agent script (fallback to full string).
  String get _firstName {
    final String trimmed = state.displayName.trim();
    if (trimmed.isEmpty) {
      return 'there';
    }
    final List<String> parts = trimmed.split(RegExp(r'\s+'));
    return parts.first;
  }

  void dismissRatingSheet() {
    state = state.copyWith(showRatingSheet: false);
  }

  void submitRating() {
    state = state.copyWith(showRatingSheet: false);
  }

  void setSheetStep(CustomerCareSheetStep step) {
    state = state.copyWith(sheetStep: step);
  }

  Future<void> submitCategory(IssueCategory category) async {
    state = state.copyWith(
      selectedCategory: category,
      sheetStep: CustomerCareSheetStep.subIssue,
    );
  }

  Future<void> submitSubIssue(
    String subIssueId,
    String localizedSubIssueLabel,
    String localizedCategoryLabel,
  ) async {
    final IssueCategory? category = state.selectedCategory;
    if (category == null) {
      return;
    }
    final IssueFlowConfig? config = IssueCatalog.configFor(category);
    state = state.copyWith(selectedSubIssueId: subIssueId);

    if (config?.requiresOrderContext ?? false) {
      state = state.copyWith(ordersLoading: true, sheetStep: CustomerCareSheetStep.none);
      try {
        final List<OrderSummaryEntity> list = await _getOrdersUseCase();
        if (_disposed) {
          return;
        }
        if (list.isEmpty) {
          state = state.copyWith(
            orders: const <OrderSummaryEntity>[],
            ordersLoading: false,
          );
          _appendUserChipsAndConnect(
            localizedCategoryLabel,
            localizedSubIssueLabel,
            null,
          );
        } else {
          state = state.copyWith(
            orders: list,
            ordersLoading: false,
            sheetStep: CustomerCareSheetStep.order,
          );
        }
      } catch (_) {
        if (_disposed) {
          return;
        }
        state = state.copyWith(
          orders: const <OrderSummaryEntity>[],
          ordersLoading: false,
        );
        _appendUserChipsAndConnect(
          localizedCategoryLabel,
          localizedSubIssueLabel,
          null,
        );
      }
    } else {
      _appendUserChipsAndConnect(
        localizedCategoryLabel,
        localizedSubIssueLabel,
        null,
      );
    }
  }

  void submitOrderSelection(
    OrderSummaryEntity order,
    String localizedCategoryLabel,
    String localizedSubIssueLabel,
  ) {
    state = state.copyWith(selectedOrder: order, sheetStep: CustomerCareSheetStep.none);
    _appendUserChipsAndConnect(
      localizedCategoryLabel,
      localizedSubIssueLabel,
      order,
    );
  }

  void _appendUserChipsAndConnect(
    String categoryLabel,
    String subIssueLabel,
    OrderSummaryEntity? order,
  ) {
    final List<ChatListItem> next = List<ChatListItem>.from(state.items)
      ..add(ChatUserChipItem(categoryLabel))
      ..add(ChatUserChipItem(subIssueLabel));
    if (order != null) {
      next.add(ChatUserOrderCardItem(order));
    }
    next.add(const ChatConnectingItem());
    state = state.copyWith(
      items: next,
      sheetStep: CustomerCareSheetStep.none,
    );
    _runAgentScript(order);
  }

  Future<void> _runAgentScript(OrderSummaryEntity? order) async {
    if (_scriptStarted) {
      return;
    }
    _scriptStarted = true;
    await Future<void>.delayed(const Duration(milliseconds: 1600));
    if (_disposed) {
      return;
    }
    _removeConnecting();
    state = state.copyWith(headerKind: CustomerCareHeaderKind.agent);
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (_disposed) {
      return;
    }
    _appendAgent(
      'Hello, $_firstName! I’m Maggy, your personal assistant from Customer '
      'Care Service. Let me go through your request and check what we can do. '
      'Wait a moment please.',
    );
    await Future<void>.delayed(const Duration(milliseconds: 2200));
    if (_disposed) {
      return;
    }
    final String orderBit = order != null
        ? 'I just checked your order ${order.reference} and '
        : 'I reviewed your case and ';
    _appendAgent(
      '$orderBit'
      'it looks like there was a problem on our end. We are really sorry '
      'about that. You should receive an update within two business days.',
    );
    await Future<void>.delayed(const Duration(milliseconds: 2000));
    if (_disposed) {
      return;
    }
    _appendAgent(
      'We would like to give you a small gift: 15% off your next purchase.',
    );
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (_disposed) {
      return;
    }
    final List<ChatListItem> withVoucher = List<ChatListItem>.from(state.items)
      ..add(
        ChatVoucherItem(
          VoucherEntity(
            id: 'care_chat_promo',
            title: '15% off your next purchase',
            subtitle: 'Applied at checkout on eligible items.',
            validUntil: DateTime.now().add(const Duration(days: 30)),
            status: VoucherStatus.collected,
            kind: VoucherVisualKind.gift,
            expiringWithinDays: 14,
          ),
        ),
      );
    state = state.copyWith(items: withVoucher);
    await Future<void>.delayed(const Duration(milliseconds: 1400));
    if (_disposed) {
      return;
    }
    state = state.copyWith(showRatingSheet: true);
  }

  void _removeConnecting() {
    final List<ChatListItem> filtered = state.items
        .where((ChatListItem e) => e is! ChatConnectingItem)
        .toList(growable: false);
    state = state.copyWith(items: filtered);
  }

  void _appendAgent(String text) {
    state = state.copyWith(
      items: List<ChatListItem>.from(state.items)..add(ChatAgentTextItem(text)),
    );
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
