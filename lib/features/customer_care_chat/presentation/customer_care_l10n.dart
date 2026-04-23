import '../../../l10n/app_localizations.dart';
import '../domain/chat_models.dart';

extension CustomerCareChatL10n on AppLocalizations {
  String customerCareCategoryLabel(IssueCategory category) {
    return switch (category) {
      IssueCategory.order => customerCareCategoryOrder,
      IssueCategory.itemQuality => customerCareCategoryItemQuality,
      IssueCategory.payment => customerCareCategoryPayment,
      IssueCategory.technical => customerCareCategoryTechnical,
      IssueCategory.other => customerCareCategoryOther,
    };
  }

  String customerCareSubIssueLabel(String id) {
    return switch (id) {
      'order_not_received' => customerCareSubOrderNotReceived,
      'order_cancel' => customerCareSubOrderCancel,
      'order_return' => customerCareSubOrderReturn,
      'order_damaged' => customerCareSubOrderDamaged,
      'order_other' => customerCareSubOrderOther,
      'quality_defective' => customerCareSubQualityDefective,
      'quality_wrong_item' => customerCareSubQualityWrongItem,
      'quality_not_as_described' => customerCareSubQualityNotAsDescribed,
      'quality_packaging' => customerCareSubQualityPackaging,
      'quality_other' => customerCareSubQualityOther,
      'payment_double_charge' => customerCareSubPaymentDouble,
      'payment_refund_pending' => customerCareSubPaymentRefund,
      'payment_failed' => customerCareSubPaymentFailed,
      'payment_wrong_amount' => customerCareSubPaymentWrongAmount,
      'payment_other' => customerCareSubPaymentOther,
      'tech_app_crash' => customerCareSubTechCrash,
      'tech_cannot_login' => customerCareSubTechLogin,
      'tech_slow' => customerCareSubTechSlow,
      'tech_notifications' => customerCareSubTechNotifications,
      'tech_other' => customerCareSubTechOther,
      'other_feedback' => customerCareSubOtherFeedback,
      'other_complaint' => customerCareSubOtherComplaint,
      'other_partner' => customerCareSubOtherPartner,
      'other_press' => customerCareSubOtherPress,
      'other_misc' => customerCareSubOtherMisc,
      _ => id,
    };
  }
}
