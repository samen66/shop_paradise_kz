import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../orders/domain/entities/order_entities.dart';
import '../../domain/chat_models.dart';
import '../../domain/issue_catalog.dart';
import '../customer_care_l10n.dart';
import '../providers/customer_care_chat_controller.dart';
import '../widgets/chat_composer_bar.dart';
import '../widgets/chat_header.dart';
import '../widgets/chat_order_summary_card.dart';
import '../widgets/chat_selection_option.dart';
import '../widgets/chat_sheet_shell.dart';
import '../widgets/chat_timeline.dart';
import '../widgets/rate_service_sheet.dart';

/// Customer care chat (scripted demo). Pass [displayName] from profile hub.
class CustomerCareChatPage extends ConsumerStatefulWidget {
  const CustomerCareChatPage({super.key, required this.displayName});

  final String displayName;

  @override
  ConsumerState<CustomerCareChatPage> createState() =>
      _CustomerCareChatPageState();
}

class _CustomerCareChatPageState extends ConsumerState<CustomerCareChatPage> {
  bool _scheduledCategorySheet = false;

  String _firstName(String raw) {
    final String t = raw.trim();
    if (t.isEmpty) {
      return 'there';
    }
    return t.split(RegExp(r'\s+')).first;
  }

  CustomerCareChatArgs _args(AppLocalizations l10n) {
    return CustomerCareChatArgs(
      displayName: widget.displayName.trim(),
      welcomeMessage: l10n.customerCareWelcomeMessage(
        _firstName(widget.displayName),
      ),
    );
  }

  Future<void> _showCategorySheet(
    BuildContext context,
    CustomerCareChatArgs args,
  ) async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    IssueCategory? selected;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setM) {
            return ChatSheetShell(
              title: l10n.customerCareSheetWhatsYourIssue,
              nextLabel: l10n.customerCareNext,
              nextEnabled: selected != null,
              onClose: () {
                Navigator.of(sheetContext).pop();
                if (mounted) {
                  Navigator.of(this.context).pop();
                }
              },
              onNext: () {
                if (selected == null) {
                  return;
                }
                Navigator.of(sheetContext).pop();
                Future<void>.microtask(() {
                  if (!mounted) {
                    return;
                  }
                  ref
                      .read(customerCareChatControllerProvider(args).notifier)
                      .submitCategory(selected!);
                });
              },
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: IssueCategory.values.map((IssueCategory c) {
                  return ChatSelectionOption(
                    label: l10n.customerCareCategoryLabel(c),
                    selected: selected == c,
                    onTap: () => setM(() => selected = c),
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showSubIssueSheet(
    BuildContext context,
    CustomerCareChatArgs args,
  ) async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final IssueCategory? category =
        ref.read(customerCareChatControllerProvider(args)).selectedCategory;
    if (category == null) {
      return;
    }
    final IssueFlowConfig? config = IssueCatalog.configFor(category);
    if (config == null) {
      return;
    }
    String? selectedId;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setM) {
            return ChatSheetShell(
              title: l10n.customerCareCategoryLabel(category),
              nextLabel: l10n.customerCareNext,
              nextEnabled: selectedId != null,
              onClose: () {
                Navigator.of(sheetContext).pop();
                if (mounted) {
                  Navigator.of(this.context).pop();
                }
              },
              onNext: () {
                if (selectedId == null) {
                  return;
                }
                Navigator.of(sheetContext).pop();
                Future<void>.microtask(() {
                  if (!mounted) {
                    return;
                  }
                  ref
                      .read(customerCareChatControllerProvider(args).notifier)
                      .submitSubIssue(
                        selectedId!,
                        l10n.customerCareSubIssueLabel(selectedId!),
                        l10n.customerCareCategoryLabel(category),
                      );
                });
              },
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: config.subIssueIds.map((String id) {
                  return ChatSelectionOption(
                    label: l10n.customerCareSubIssueLabel(id),
                    selected: selectedId == id,
                    onTap: () => setM(() => selectedId = id),
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showOrderSheet(
    BuildContext context,
    CustomerCareChatArgs args,
  ) async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final CustomerCareChatState chatState =
        ref.read(customerCareChatControllerProvider(args));
    final IssueCategory? category = chatState.selectedCategory;
    if (category == null) {
      return;
    }
    String? selectedId;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setM) {
            final CustomerCareChatState s =
                ref.watch(customerCareChatControllerProvider(args));
            if (s.ordersLoading) {
              return const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return ChatSheetShell(
              title: l10n.customerCareSheetSelectOrder,
              nextLabel: l10n.customerCareNext,
              nextEnabled: selectedId != null,
              onClose: () {
                Navigator.of(sheetContext).pop();
                if (mounted) {
                  Navigator.of(this.context).pop();
                }
              },
              onNext: () {
                if (selectedId == null) {
                  return;
                }
                final OrderSummaryEntity order = s.orders.firstWhere(
                  (OrderSummaryEntity o) => o.id == selectedId,
                );
                Navigator.of(sheetContext).pop();
                Future<void>.microtask(() {
                  if (!mounted) {
                    return;
                  }
                  ref
                      .read(customerCareChatControllerProvider(args).notifier)
                      .submitOrderSelection(
                        order,
                        l10n.customerCareCategoryLabel(category),
                        l10n.customerCareSubIssueLabel(
                          s.selectedSubIssueId ?? '',
                        ),
                      );
                });
              },
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: s.orders.map((OrderSummaryEntity o) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ChatOrderSummaryCard(
                      order: o,
                      itemCountLabel: l10n.customerCareItemsCount(o.itemCount),
                      deliveryLabel: l10n.customerCareStandardDelivery,
                      selected: selectedId == o.id,
                      selectLabel: l10n.customerCareOrderSelect,
                      selectedLabel: l10n.customerCareOrderSelected,
                      showSelectButton: true,
                      onSelect: () => setM(() => selectedId = o.id),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showRatingSheet(
    BuildContext context,
    CustomerCareChatArgs args,
  ) async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      isDismissible: false,
      builder: (BuildContext sheetContext) {
        return RateServiceSheet(
          title: l10n.customerCareRateTitle,
          agentName: l10n.customerCareHeaderAgentName,
          subtitle: l10n.customerCareHeaderSubtitle,
          commentHint: l10n.customerCareRateCommentHint,
          nextLabel: l10n.customerCareNext,
          onClose: () {
            Navigator.of(sheetContext).pop();
            ref
                .read(customerCareChatControllerProvider(args).notifier)
                .dismissRatingSheet();
          },
          onSubmit: (int stars, String comment) {
            ref
                .read(customerCareChatControllerProvider(args).notifier)
                .submitRating();
            Navigator.of(sheetContext).pop();
            if (mounted) {
              ScaffoldMessenger.of(this.context).showSnackBar(
                SnackBar(content: Text(l10n.customerCareRatingThanks)),
              );
              Navigator.of(this.context).pop();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? l10n = tryAppLocalizations(context);
    if (l10n == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'Missing localizations',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      );
    }
    final CustomerCareChatArgs args = _args(l10n);
    final CustomerCareChatState state =
        ref.watch(customerCareChatControllerProvider(args));

    if (!_scheduledCategorySheet &&
        state.sheetStep == CustomerCareSheetStep.category) {
      _scheduledCategorySheet = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        _showCategorySheet(context, args);
      });
    }

    ref.listen<CustomerCareSheetStep>(
      customerCareChatControllerProvider(args).select((CustomerCareChatState s) {
        return s.sheetStep;
      }),
      (CustomerCareSheetStep? previous, CustomerCareSheetStep next) {
        if (next == CustomerCareSheetStep.subIssue && previous != next) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _showSubIssueSheet(context, args);
            }
          });
        }
        if (next == CustomerCareSheetStep.order && previous != next) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _showOrderSheet(context, args);
            }
          });
        }
      },
    );

    ref.listen<bool>(
      customerCareChatControllerProvider(args).select(
        (CustomerCareChatState s) => s.showRatingSheet,
      ),
      (bool? previous, bool next) {
        if (next && previous != true) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _showRatingSheet(context, args);
            }
          });
        }
      },
    );

    final bool showComposer =
        state.headerKind == CustomerCareHeaderKind.agent;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest
          .withValues(alpha: 0.35),
      appBar: AppBar(
        title: Text(l10n.customerCareSettingsRow),
      ),
      body: Column(
        children: <Widget>[
          ChatHeader(
            kind: state.headerKind,
            chatBotTitle: l10n.customerCareHeaderChatBotTitle,
            agentName: l10n.customerCareHeaderAgentName,
            subtitle: l10n.customerCareHeaderSubtitle,
          ),
          Expanded(
            child: ChatTimeline(
              items: state.items,
              connectingLabel: l10n.customerCareConnecting,
              collectLabel: l10n.customerCareVoucherCollect,
              formatItemCount: l10n.customerCareItemsCount,
              standardDeliveryLabel: l10n.customerCareStandardDelivery,
              onCollectVoucher: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.customerCareVoucherSaved)),
                );
              },
            ),
          ),
          if (showComposer)
            ChatComposerBar(
              hint: l10n.customerCareMessageHint,
              onAttach: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.customerCareSnackbarAttach)),
                );
              },
              onMenu: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.customerCareSnackbarMenu)),
                );
              },
            ),
        ],
      ),
    );
  }
}
