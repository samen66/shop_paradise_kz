import 'chat_models.dart';

/// Static flow configuration: sub-issue ids and whether order picker runs.
abstract final class IssueCatalog {
  static const Map<IssueCategory, IssueFlowConfig> flows =
      <IssueCategory, IssueFlowConfig>{
        IssueCategory.order: IssueFlowConfig(
          subIssueIds: <String>[
            'order_not_received',
            'order_cancel',
            'order_return',
            'order_damaged',
            'order_other',
          ],
          requiresOrderContext: true,
        ),
        IssueCategory.itemQuality: IssueFlowConfig(
          subIssueIds: <String>[
            'quality_defective',
            'quality_wrong_item',
            'quality_not_as_described',
            'quality_packaging',
            'quality_other',
          ],
          requiresOrderContext: true,
        ),
        IssueCategory.payment: IssueFlowConfig(
          subIssueIds: <String>[
            'payment_double_charge',
            'payment_refund_pending',
            'payment_failed',
            'payment_wrong_amount',
            'payment_other',
          ],
          requiresOrderContext: true,
        ),
        IssueCategory.technical: IssueFlowConfig(
          subIssueIds: <String>[
            'tech_app_crash',
            'tech_cannot_login',
            'tech_slow',
            'tech_notifications',
            'tech_other',
          ],
          requiresOrderContext: false,
        ),
        IssueCategory.other: IssueFlowConfig(
          subIssueIds: <String>[
            'other_feedback',
            'other_complaint',
            'other_partner',
            'other_press',
            'other_misc',
          ],
          requiresOrderContext: false,
        ),
      };

  static IssueFlowConfig? configFor(IssueCategory? category) {
    if (category == null) {
      return null;
    }
    return flows[category];
  }
}
