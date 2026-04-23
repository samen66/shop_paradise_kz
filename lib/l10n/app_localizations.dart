import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('kk'),
    Locale('ru'),
  ];

  /// App brand name shown on welcome screen
  ///
  /// In en, this message translates to:
  /// **'Paradise'**
  String get appBrandTitle;

  /// No description provided for @welcomeTaglineLine1.
  ///
  /// In en, this message translates to:
  /// **'Furniture and decor for your home'**
  String get welcomeTaglineLine1;

  /// No description provided for @welcomeTaglineLine2.
  ///
  /// In en, this message translates to:
  /// **'Living room, bedroom, kitchen — all in one place'**
  String get welcomeTaglineLine2;

  /// No description provided for @welcomePrimaryCta.
  ///
  /// In en, this message translates to:
  /// **'Browse catalog'**
  String get welcomePrimaryCta;

  /// No description provided for @welcomeSecondaryCta.
  ///
  /// In en, this message translates to:
  /// **'I already have an account'**
  String get welcomeSecondaryCta;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginTitle;

  /// No description provided for @loginEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmailLabel;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// No description provided for @loginCloseAction.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get loginCloseAction;

  /// No description provided for @webHeaderCatalog.
  ///
  /// In en, this message translates to:
  /// **'Catalog'**
  String get webHeaderCatalog;

  /// No description provided for @webHeaderSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter query'**
  String get webHeaderSearchPlaceholder;

  /// No description provided for @webHeaderLinkPromotions.
  ///
  /// In en, this message translates to:
  /// **'Promotions'**
  String get webHeaderLinkPromotions;

  /// No description provided for @webHeaderLinkMagazine.
  ///
  /// In en, this message translates to:
  /// **'Magazine'**
  String get webHeaderLinkMagazine;

  /// No description provided for @webHeaderLinkShowrooms.
  ///
  /// In en, this message translates to:
  /// **'Showrooms'**
  String get webHeaderLinkShowrooms;

  /// No description provided for @customerCareWelcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}! Welcome to Customer Care Service. We will be happy to help you. Please provide more details about your issue before we can start.'**
  String customerCareWelcomeMessage(String name);

  /// No description provided for @customerCareHeaderChatBotTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat Bot'**
  String get customerCareHeaderChatBotTitle;

  /// No description provided for @customerCareHeaderAgentName.
  ///
  /// In en, this message translates to:
  /// **'Maggy Lee'**
  String get customerCareHeaderAgentName;

  /// No description provided for @customerCareHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Care Service'**
  String get customerCareHeaderSubtitle;

  /// No description provided for @customerCareSheetWhatsYourIssue.
  ///
  /// In en, this message translates to:
  /// **'What\'s your issue?'**
  String get customerCareSheetWhatsYourIssue;

  /// No description provided for @customerCareSheetSelectOrder.
  ///
  /// In en, this message translates to:
  /// **'Select one of your orders'**
  String get customerCareSheetSelectOrder;

  /// No description provided for @customerCareNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get customerCareNext;

  /// No description provided for @customerCareMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get customerCareMessageHint;

  /// No description provided for @customerCareConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting you with an agent'**
  String get customerCareConnecting;

  /// No description provided for @customerCareStandardDelivery.
  ///
  /// In en, this message translates to:
  /// **'Standard Delivery'**
  String get customerCareStandardDelivery;

  /// No description provided for @customerCareItemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String customerCareItemsCount(int count);

  /// No description provided for @customerCareOrderSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get customerCareOrderSelect;

  /// No description provided for @customerCareOrderSelected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get customerCareOrderSelected;

  /// No description provided for @customerCareRateTitle.
  ///
  /// In en, this message translates to:
  /// **'Rate Our Service'**
  String get customerCareRateTitle;

  /// No description provided for @customerCareRateCommentHint.
  ///
  /// In en, this message translates to:
  /// **'Your comment'**
  String get customerCareRateCommentHint;

  /// No description provided for @customerCareRatingThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your feedback.'**
  String get customerCareRatingThanks;

  /// No description provided for @customerCareSettingsRow.
  ///
  /// In en, this message translates to:
  /// **'Customer care'**
  String get customerCareSettingsRow;

  /// No description provided for @customerCareSnackbarAttach.
  ///
  /// In en, this message translates to:
  /// **'Attachments are not available in this demo.'**
  String get customerCareSnackbarAttach;

  /// No description provided for @customerCareSnackbarMenu.
  ///
  /// In en, this message translates to:
  /// **'More options are not available in this demo.'**
  String get customerCareSnackbarMenu;

  /// No description provided for @customerCareCategoryOrder.
  ///
  /// In en, this message translates to:
  /// **'Order Issues'**
  String get customerCareCategoryOrder;

  /// No description provided for @customerCareCategoryItemQuality.
  ///
  /// In en, this message translates to:
  /// **'Item Quality'**
  String get customerCareCategoryItemQuality;

  /// No description provided for @customerCareCategoryPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment Issues'**
  String get customerCareCategoryPayment;

  /// No description provided for @customerCareCategoryTechnical.
  ///
  /// In en, this message translates to:
  /// **'Technical Assistance'**
  String get customerCareCategoryTechnical;

  /// No description provided for @customerCareCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get customerCareCategoryOther;

  /// No description provided for @customerCareSubOrderNotReceived.
  ///
  /// In en, this message translates to:
  /// **'I didn\'t receive my parcel'**
  String get customerCareSubOrderNotReceived;

  /// No description provided for @customerCareSubOrderCancel.
  ///
  /// In en, this message translates to:
  /// **'I want to cancel my order'**
  String get customerCareSubOrderCancel;

  /// No description provided for @customerCareSubOrderReturn.
  ///
  /// In en, this message translates to:
  /// **'I want to return my order'**
  String get customerCareSubOrderReturn;

  /// No description provided for @customerCareSubOrderDamaged.
  ///
  /// In en, this message translates to:
  /// **'Package was damaged'**
  String get customerCareSubOrderDamaged;

  /// No description provided for @customerCareSubOrderOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get customerCareSubOrderOther;

  /// No description provided for @customerCareSubQualityDefective.
  ///
  /// In en, this message translates to:
  /// **'Item is defective or broken'**
  String get customerCareSubQualityDefective;

  /// No description provided for @customerCareSubQualityWrongItem.
  ///
  /// In en, this message translates to:
  /// **'Wrong item was sent'**
  String get customerCareSubQualityWrongItem;

  /// No description provided for @customerCareSubQualityNotAsDescribed.
  ///
  /// In en, this message translates to:
  /// **'Not as described online'**
  String get customerCareSubQualityNotAsDescribed;

  /// No description provided for @customerCareSubQualityPackaging.
  ///
  /// In en, this message translates to:
  /// **'Poor packaging'**
  String get customerCareSubQualityPackaging;

  /// No description provided for @customerCareSubQualityOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get customerCareSubQualityOther;

  /// No description provided for @customerCareSubPaymentDouble.
  ///
  /// In en, this message translates to:
  /// **'I was charged twice'**
  String get customerCareSubPaymentDouble;

  /// No description provided for @customerCareSubPaymentRefund.
  ///
  /// In en, this message translates to:
  /// **'Refund is delayed'**
  String get customerCareSubPaymentRefund;

  /// No description provided for @customerCareSubPaymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment failed at checkout'**
  String get customerCareSubPaymentFailed;

  /// No description provided for @customerCareSubPaymentWrongAmount.
  ///
  /// In en, this message translates to:
  /// **'Wrong amount charged'**
  String get customerCareSubPaymentWrongAmount;

  /// No description provided for @customerCareSubPaymentOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get customerCareSubPaymentOther;

  /// No description provided for @customerCareSubTechCrash.
  ///
  /// In en, this message translates to:
  /// **'The app crashes or freezes'**
  String get customerCareSubTechCrash;

  /// No description provided for @customerCareSubTechLogin.
  ///
  /// In en, this message translates to:
  /// **'I can\'t sign in'**
  String get customerCareSubTechLogin;

  /// No description provided for @customerCareSubTechSlow.
  ///
  /// In en, this message translates to:
  /// **'Pages load slowly'**
  String get customerCareSubTechSlow;

  /// No description provided for @customerCareSubTechNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications are not working'**
  String get customerCareSubTechNotifications;

  /// No description provided for @customerCareSubTechOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get customerCareSubTechOther;

  /// No description provided for @customerCareSubOtherFeedback.
  ///
  /// In en, this message translates to:
  /// **'General feedback'**
  String get customerCareSubOtherFeedback;

  /// No description provided for @customerCareSubOtherComplaint.
  ///
  /// In en, this message translates to:
  /// **'Complaint about service'**
  String get customerCareSubOtherComplaint;

  /// No description provided for @customerCareSubOtherPartner.
  ///
  /// In en, this message translates to:
  /// **'Partnership or B2B'**
  String get customerCareSubOtherPartner;

  /// No description provided for @customerCareSubOtherPress.
  ///
  /// In en, this message translates to:
  /// **'Press or media'**
  String get customerCareSubOtherPress;

  /// No description provided for @customerCareSubOtherMisc.
  ///
  /// In en, this message translates to:
  /// **'Something else'**
  String get customerCareSubOtherMisc;

  /// No description provided for @customerCareVoucherCollect.
  ///
  /// In en, this message translates to:
  /// **'Collect'**
  String get customerCareVoucherCollect;

  /// No description provided for @customerCareVoucherSaved.
  ///
  /// In en, this message translates to:
  /// **'Offer saved to your account.'**
  String get customerCareVoucherSaved;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountTitle;

  /// No description provided for @createAccountEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get createAccountEmailHint;

  /// No description provided for @createAccountPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get createAccountPasswordHint;

  /// No description provided for @createAccountPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Your number'**
  String get createAccountPhoneHint;

  /// No description provided for @createAccountDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get createAccountDone;

  /// No description provided for @createAccountCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get createAccountCancel;

  /// No description provided for @createAccountEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get createAccountEmailInvalid;

  /// No description provided for @createAccountPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters.'**
  String get createAccountPasswordTooShort;

  /// No description provided for @createAccountPhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number.'**
  String get createAccountPhoneInvalid;

  /// No description provided for @createAccountSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account details look good. Sign-in will be wired next.'**
  String get createAccountSuccess;

  /// No description provided for @createAccountAvatarSemanticLabel.
  ///
  /// In en, this message translates to:
  /// **'Add profile photo'**
  String get createAccountAvatarSemanticLabel;

  /// No description provided for @createAccountAvatarUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Photo upload is not available in this build.'**
  String get createAccountAvatarUnavailable;

  /// No description provided for @loginCreateAccountLink.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get loginCreateAccountLink;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'kk':
      return AppLocalizationsKk();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
