// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBrandTitle => 'Paradise';

  @override
  String get welcomeTaglineLine1 => 'Furniture and decor for your home';

  @override
  String get welcomeTaglineLine2 =>
      'Living room, bedroom, kitchen — all in one place';

  @override
  String get welcomePrimaryCta => 'Browse catalog';

  @override
  String get welcomeSecondaryCta => 'I already have an account';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginCloseAction => 'Close';

  @override
  String get loginContinueWithGoogle => 'Continue with Google';

  @override
  String loginGoogleSignInFailed(String message) {
    return 'Google sign-in failed: $message';
  }

  @override
  String get webHeaderCatalog => 'Catalog';

  @override
  String get webHeaderSearchPlaceholder => 'Enter query';

  @override
  String get webHeaderLinkPromotions => 'Promotions';

  @override
  String get webHeaderLinkMagazine => 'Magazine';

  @override
  String get webHeaderLinkShowrooms => 'Showrooms';

  @override
  String customerCareWelcomeMessage(String name) {
    return 'Hello, $name! Welcome to Customer Care Service. We will be happy to help you. Please provide more details about your issue before we can start.';
  }

  @override
  String get customerCareHeaderChatBotTitle => 'Chat Bot';

  @override
  String get customerCareHeaderAgentName => 'Maggy Lee';

  @override
  String get customerCareHeaderSubtitle => 'Customer Care Service';

  @override
  String get customerCareSheetWhatsYourIssue => 'What\'s your issue?';

  @override
  String get customerCareSheetSelectOrder => 'Select one of your orders';

  @override
  String get customerCareNext => 'Next';

  @override
  String get customerCareMessageHint => 'Message';

  @override
  String get customerCareConnecting => 'Connecting you with an agent';

  @override
  String get customerCareStandardDelivery => 'Standard Delivery';

  @override
  String customerCareItemsCount(int count) {
    return '$count items';
  }

  @override
  String get customerCareOrderSelect => 'Select';

  @override
  String get customerCareOrderSelected => 'Selected';

  @override
  String get customerCareRateTitle => 'Rate Our Service';

  @override
  String get customerCareRateCommentHint => 'Your comment';

  @override
  String get customerCareRatingThanks => 'Thank you for your feedback.';

  @override
  String get customerCareSettingsRow => 'Customer care';

  @override
  String get customerCareSnackbarAttach =>
      'Attachments are not available in this demo.';

  @override
  String get customerCareSnackbarMenu =>
      'More options are not available in this demo.';

  @override
  String get customerCareCategoryOrder => 'Order Issues';

  @override
  String get customerCareCategoryItemQuality => 'Item Quality';

  @override
  String get customerCareCategoryPayment => 'Payment Issues';

  @override
  String get customerCareCategoryTechnical => 'Technical Assistance';

  @override
  String get customerCareCategoryOther => 'Other';

  @override
  String get customerCareSubOrderNotReceived => 'I didn\'t receive my parcel';

  @override
  String get customerCareSubOrderCancel => 'I want to cancel my order';

  @override
  String get customerCareSubOrderReturn => 'I want to return my order';

  @override
  String get customerCareSubOrderDamaged => 'Package was damaged';

  @override
  String get customerCareSubOrderOther => 'Other';

  @override
  String get customerCareSubQualityDefective => 'Item is defective or broken';

  @override
  String get customerCareSubQualityWrongItem => 'Wrong item was sent';

  @override
  String get customerCareSubQualityNotAsDescribed => 'Not as described online';

  @override
  String get customerCareSubQualityPackaging => 'Poor packaging';

  @override
  String get customerCareSubQualityOther => 'Other';

  @override
  String get customerCareSubPaymentDouble => 'I was charged twice';

  @override
  String get customerCareSubPaymentRefund => 'Refund is delayed';

  @override
  String get customerCareSubPaymentFailed => 'Payment failed at checkout';

  @override
  String get customerCareSubPaymentWrongAmount => 'Wrong amount charged';

  @override
  String get customerCareSubPaymentOther => 'Other';

  @override
  String get customerCareSubTechCrash => 'The app crashes or freezes';

  @override
  String get customerCareSubTechLogin => 'I can\'t sign in';

  @override
  String get customerCareSubTechSlow => 'Pages load slowly';

  @override
  String get customerCareSubTechNotifications =>
      'Notifications are not working';

  @override
  String get customerCareSubTechOther => 'Other';

  @override
  String get customerCareSubOtherFeedback => 'General feedback';

  @override
  String get customerCareSubOtherComplaint => 'Complaint about service';

  @override
  String get customerCareSubOtherPartner => 'Partnership or B2B';

  @override
  String get customerCareSubOtherPress => 'Press or media';

  @override
  String get customerCareSubOtherMisc => 'Something else';

  @override
  String get customerCareVoucherCollect => 'Collect';

  @override
  String get customerCareVoucherSaved => 'Offer saved to your account.';

  @override
  String get createAccountTitle => 'Create Account';

  @override
  String get createAccountEmailHint => 'Email';

  @override
  String get createAccountPasswordHint => 'Password';

  @override
  String get createAccountPhoneHint => 'Your number';

  @override
  String get createAccountDone => 'Done';

  @override
  String get createAccountCancel => 'Cancel';

  @override
  String get createAccountEmailInvalid => 'Enter a valid email address.';

  @override
  String get createAccountPasswordTooShort =>
      'Password must be at least 8 characters.';

  @override
  String get createAccountPhoneInvalid => 'Enter a valid phone number.';

  @override
  String get createAccountSuccess =>
      'Account details look good. Sign-in will be wired next.';

  @override
  String get createAccountAvatarSemanticLabel => 'Add profile photo';

  @override
  String get createAccountAvatarUnavailable =>
      'Photo upload is not available in this build.';

  @override
  String get loginCreateAccountLink => 'Create account';
}
