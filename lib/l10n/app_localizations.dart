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

  /// No description provided for @loginContinueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get loginContinueWithGoogle;

  /// No description provided for @loginGoogleSignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in failed: {message}'**
  String loginGoogleSignInFailed(String message);

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

  /// No description provided for @settingsThemeSection.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsThemeSection;

  /// No description provided for @themeModeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeModeSystem;

  /// No description provided for @themeModeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeModeLight;

  /// No description provided for @themeModeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeModeDark;

  /// No description provided for @settingsDailyReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily shopping-notes reminder'**
  String get settingsDailyReminderTitle;

  /// No description provided for @settingsDailyReminderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Once per day at 8:00 PM (device time)'**
  String get settingsDailyReminderSubtitle;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onboardingStart;

  /// No description provided for @onboardingPage1Title.
  ///
  /// In en, this message translates to:
  /// **'Browse with confidence'**
  String get onboardingPage1Title;

  /// No description provided for @onboardingPage1Body.
  ///
  /// In en, this message translates to:
  /// **'Explore furniture and decor in one place, tailored for your home.'**
  String get onboardingPage1Body;

  /// No description provided for @onboardingPage2Title.
  ///
  /// In en, this message translates to:
  /// **'Track what you spend'**
  String get onboardingPage2Title;

  /// No description provided for @onboardingPage2Body.
  ///
  /// In en, this message translates to:
  /// **'Use offline shopping notes to log prices and categories anytime.'**
  String get onboardingPage2Body;

  /// No description provided for @onboardingPage3Title.
  ///
  /// In en, this message translates to:
  /// **'Your data stays with you'**
  String get onboardingPage3Title;

  /// No description provided for @onboardingPage3Body.
  ///
  /// In en, this message translates to:
  /// **'Notes are stored on this device; sign in when you want cloud features.'**
  String get onboardingPage3Body;

  /// No description provided for @exportShoppingNotesCsv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get exportShoppingNotesCsv;

  /// No description provided for @exportShoppingNotesPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get exportShoppingNotesPdf;

  /// No description provided for @exportShoppingNotesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notes to export.'**
  String get exportShoppingNotesEmpty;

  /// No description provided for @exportShoppingNotesFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed: {message}'**
  String exportShoppingNotesFailed(String message);

  /// No description provided for @shoppingNotesCsvHeaderId.
  ///
  /// In en, this message translates to:
  /// **'id'**
  String get shoppingNotesCsvHeaderId;

  /// No description provided for @shoppingNotesCsvHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'title'**
  String get shoppingNotesCsvHeaderTitle;

  /// No description provided for @shoppingNotesCsvHeaderBody.
  ///
  /// In en, this message translates to:
  /// **'body'**
  String get shoppingNotesCsvHeaderBody;

  /// No description provided for @shoppingNotesCsvHeaderCategory.
  ///
  /// In en, this message translates to:
  /// **'category'**
  String get shoppingNotesCsvHeaderCategory;

  /// No description provided for @shoppingNotesCsvHeaderCategoryId.
  ///
  /// In en, this message translates to:
  /// **'category_id'**
  String get shoppingNotesCsvHeaderCategoryId;

  /// No description provided for @shoppingNotesCsvHeaderAmount.
  ///
  /// In en, this message translates to:
  /// **'amount'**
  String get shoppingNotesCsvHeaderAmount;

  /// No description provided for @shoppingNotesCsvHeaderSynced.
  ///
  /// In en, this message translates to:
  /// **'synced_to_remote'**
  String get shoppingNotesCsvHeaderSynced;

  /// No description provided for @shoppingNotesCsvHeaderCreated.
  ///
  /// In en, this message translates to:
  /// **'created_at_utc'**
  String get shoppingNotesCsvHeaderCreated;

  /// No description provided for @shoppingNotesCsvHeaderUpdated.
  ///
  /// In en, this message translates to:
  /// **'updated_at_utc'**
  String get shoppingNotesCsvHeaderUpdated;

  /// No description provided for @shoppingNotesPdfTitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping notes'**
  String get shoppingNotesPdfTitle;

  /// No description provided for @shoppingNotesPdfHeaderId.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get shoppingNotesPdfHeaderId;

  /// No description provided for @shoppingNotesPdfHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get shoppingNotesPdfHeaderTitle;

  /// No description provided for @shoppingNotesPdfHeaderCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get shoppingNotesPdfHeaderCategory;

  /// No description provided for @shoppingNotesPdfHeaderAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get shoppingNotesPdfHeaderAmount;

  /// Header title for the Settings hub page
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSectionPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get settingsSectionPersonal;

  /// No description provided for @settingsSectionShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get settingsSectionShop;

  /// No description provided for @settingsSectionAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsSectionAccount;

  /// No description provided for @settingsRowProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get settingsRowProfile;

  /// No description provided for @settingsRowShippingAddress.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get settingsRowShippingAddress;

  /// No description provided for @settingsRowPaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment methods'**
  String get settingsRowPaymentMethods;

  /// No description provided for @settingsRowShoppingNotes.
  ///
  /// In en, this message translates to:
  /// **'Shopping notes (offline)'**
  String get settingsRowShoppingNotes;

  /// No description provided for @settingsRowSpendingChart.
  ///
  /// In en, this message translates to:
  /// **'Spending chart'**
  String get settingsRowSpendingChart;

  /// No description provided for @settingsRowCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get settingsRowCountry;

  /// No description provided for @settingsRowCurrency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get settingsRowCurrency;

  /// No description provided for @settingsRowSizes.
  ///
  /// In en, this message translates to:
  /// **'Sizes'**
  String get settingsRowSizes;

  /// No description provided for @settingsRowTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get settingsRowTerms;

  /// No description provided for @settingsRowLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsRowLanguage;

  /// No description provided for @settingsRowLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get settingsRowLogout;

  /// Settings row that opens the About page
  ///
  /// In en, this message translates to:
  /// **'About {appName}'**
  String settingsRowAbout(String appName);

  /// No description provided for @settingsDeleteAccountAction.
  ///
  /// In en, this message translates to:
  /// **'Delete My Account'**
  String get settingsDeleteAccountAction;

  /// Version + build date footer on Settings
  ///
  /// In en, this message translates to:
  /// **'Version {version} · {buildDate}'**
  String settingsVersionLabel(String version, String buildDate);

  /// No description provided for @settingsLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get settingsLogoutTitle;

  /// No description provided for @settingsLogoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Log out of your account?'**
  String get settingsLogoutMessage;

  /// No description provided for @settingsDeleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account?'**
  String get settingsDeleteAccountTitle;

  /// No description provided for @settingsDeleteAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'You will not be able to restore your data. This is a demo only.'**
  String get settingsDeleteAccountMessage;

  /// No description provided for @settingsDeleteAccountDemoMessage.
  ///
  /// In en, this message translates to:
  /// **'Account deletion is not available in demo'**
  String get settingsDeleteAccountDemoMessage;

  /// Snackbar shown when tapping a settings row that is not implemented yet
  ///
  /// In en, this message translates to:
  /// **'{feature} — coming soon'**
  String settingsComingSoonMessage(String feature);

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get commonLogout;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @languagePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languagePageTitle;

  /// No description provided for @languageFollowSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system'**
  String get languageFollowSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageKazakh.
  ///
  /// In en, this message translates to:
  /// **'Kazakh'**
  String get languageKazakh;

  /// No description provided for @languageRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get languageRussian;

  /// OS task switcher / window title
  ///
  /// In en, this message translates to:
  /// **'Shop Paradise'**
  String get appWindowTitle;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get commonSeeAll;

  /// No description provided for @homeJustForYouRetryLoadingMore.
  ///
  /// In en, this message translates to:
  /// **'Retry loading more'**
  String get homeJustForYouRetryLoadingMore;

  /// No description provided for @commonTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get commonTryAgain;

  /// No description provided for @commonApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get commonApply;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get commonChange;

  /// No description provided for @commonClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get commonClear;

  /// No description provided for @commonCloseTooltip.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonCloseTooltip;

  /// No description provided for @commonSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get commonSelectAll;

  /// No description provided for @errorMessageWithDetails.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorMessageWithDetails(String message);

  /// No description provided for @loginSubtitleWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Good to see you back!  🖤'**
  String get loginSubtitleWelcomeBack;

  /// No description provided for @loginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get loginForgotPassword;

  /// No description provided for @loginChangeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change email'**
  String get loginChangeEmail;

  /// No description provided for @loginPasswordResetSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent.'**
  String get loginPasswordResetSent;

  /// No description provided for @loginEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get loginEnterEmail;

  /// No description provided for @loginEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get loginEnterPassword;

  /// No description provided for @loginEnterValidEmailFirst.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email first'**
  String get loginEnterValidEmailFirst;

  /// No description provided for @shopHomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shopHomeTitle;

  /// No description provided for @cartTitle.
  ///
  /// In en, this message translates to:
  /// **'My cart'**
  String get cartTitle;

  /// No description provided for @cartFailedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load cart'**
  String get cartFailedToLoad;

  /// No description provided for @cartRemovedSelected.
  ///
  /// In en, this message translates to:
  /// **'Removed selected items'**
  String get cartRemovedSelected;

  /// No description provided for @cartBrowseHomeSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Open the Home tab to browse products.'**
  String get cartBrowseHomeSnackbar;

  /// No description provided for @cartItemRemoved.
  ///
  /// In en, this message translates to:
  /// **'{title} removed'**
  String cartItemRemoved(String title);

  /// No description provided for @cartTooltipDeleteSelected.
  ///
  /// In en, this message translates to:
  /// **'Delete selected'**
  String get cartTooltipDeleteSelected;

  /// No description provided for @cartTooltipSelectItems.
  ///
  /// In en, this message translates to:
  /// **'Select items'**
  String get cartTooltipSelectItems;

  /// No description provided for @cartCheckout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get cartCheckout;

  /// No description provided for @cartSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get cartSubtotal;

  /// No description provided for @cartDiscountRow.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get cartDiscountRow;

  /// No description provided for @cartTax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get cartTax;

  /// No description provided for @cartFreeLabel.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get cartFreeLabel;

  /// No description provided for @cartTotalRow.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get cartTotalRow;

  /// No description provided for @cartStartShopping.
  ///
  /// In en, this message translates to:
  /// **'Start shopping'**
  String get cartStartShopping;

  /// No description provided for @wishlistFailedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load wishlist'**
  String get wishlistFailedToLoad;

  /// No description provided for @wishlistSavedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} saved items'**
  String wishlistSavedCount(int count);

  /// No description provided for @wishlistTitle.
  ///
  /// In en, this message translates to:
  /// **'My Wishlist'**
  String get wishlistTitle;

  /// No description provided for @wishlistItemRemoved.
  ///
  /// In en, this message translates to:
  /// **'{title} removed'**
  String wishlistItemRemoved(String title);

  /// No description provided for @wishlistItemAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'{title} added to cart'**
  String wishlistItemAddedToCart(String title);

  /// No description provided for @wishlistRestoreDemo.
  ///
  /// In en, this message translates to:
  /// **'Restore demo items'**
  String get wishlistRestoreDemo;

  /// No description provided for @ordersFailedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load orders'**
  String get ordersFailedToLoad;

  /// No description provided for @ordersPlacedOn.
  ///
  /// In en, this message translates to:
  /// **'Placed {when}'**
  String ordersPlacedOn(String when);

  /// No description provided for @ordersSheetSummaryLine.
  ///
  /// In en, this message translates to:
  /// **'{itemCount} items · {total}'**
  String ordersSheetSummaryLine(int itemCount, String total);

  /// No description provided for @ordersSheetTrackingPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Full order tracking will appear here once connected to your store backend.'**
  String get ordersSheetTrackingPlaceholder;

  /// No description provided for @ordersCountHeader.
  ///
  /// In en, this message translates to:
  /// **'{count} orders'**
  String ordersCountHeader(int count);

  /// No description provided for @ordersTitle.
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get ordersTitle;

  /// No description provided for @ordersRestoreDemo.
  ///
  /// In en, this message translates to:
  /// **'Restore demo orders'**
  String get ordersRestoreDemo;

  /// No description provided for @orderStatusProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get orderStatusProcessing;

  /// No description provided for @orderStatusShipped.
  ///
  /// In en, this message translates to:
  /// **'Shipped'**
  String get orderStatusShipped;

  /// No description provided for @orderStatusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get orderStatusDelivered;

  /// No description provided for @orderStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get orderStatusCancelled;

  /// No description provided for @orderItemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String orderItemsCount(int count);

  /// No description provided for @homeMarketplaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Home Marketplace'**
  String get homeMarketplaceTitle;

  /// No description provided for @homeMarketSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search products, brands, supplies...'**
  String get homeMarketSearchHint;

  /// No description provided for @homeMarketSearchPlaceholderShort.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get homeMarketSearchPlaceholderShort;

  /// No description provided for @homeMarketCategoryFiltersTooltip.
  ///
  /// In en, this message translates to:
  /// **'Category filters'**
  String get homeMarketCategoryFiltersTooltip;

  /// No description provided for @homeAppBarAiDesignTooltip.
  ///
  /// In en, this message translates to:
  /// **'AI Design'**
  String get homeAppBarAiDesignTooltip;

  /// No description provided for @homeAppBarServiceHubTooltip.
  ///
  /// In en, this message translates to:
  /// **'Service Hub'**
  String get homeAppBarServiceHubTooltip;

  /// No description provided for @homeMarketCategoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get homeMarketCategoryAll;

  /// No description provided for @homeMarketCategoryGroceries.
  ///
  /// In en, this message translates to:
  /// **'Groceries'**
  String get homeMarketCategoryGroceries;

  /// No description provided for @homeMarketCategoryHomeGoods.
  ///
  /// In en, this message translates to:
  /// **'Home Goods'**
  String get homeMarketCategoryHomeGoods;

  /// No description provided for @homeMarketCategoryDecor.
  ///
  /// In en, this message translates to:
  /// **'Decor'**
  String get homeMarketCategoryDecor;

  /// No description provided for @homeMarketProductFreshFruitBasket.
  ///
  /// In en, this message translates to:
  /// **'Fresh Fruit Basket'**
  String get homeMarketProductFreshFruitBasket;

  /// No description provided for @homeMarketProductKitchenStorageSet.
  ///
  /// In en, this message translates to:
  /// **'Kitchen Storage Set'**
  String get homeMarketProductKitchenStorageSet;

  /// No description provided for @homeMarketProductScentedCandleTrio.
  ///
  /// In en, this message translates to:
  /// **'Scented Candle Trio'**
  String get homeMarketProductScentedCandleTrio;

  /// No description provided for @homeMarketProductLaundryOrganizer.
  ///
  /// In en, this message translates to:
  /// **'Laundry Organizer'**
  String get homeMarketProductLaundryOrganizer;

  /// No description provided for @homeMarketProductIndoorPlantKit.
  ///
  /// In en, this message translates to:
  /// **'Indoor Plant Kit'**
  String get homeMarketProductIndoorPlantKit;

  /// No description provided for @homeMarketProductOrganicDairyBundle.
  ///
  /// In en, this message translates to:
  /// **'Organic Dairy Bundle'**
  String get homeMarketProductOrganicDairyBundle;

  /// No description provided for @cartPromoCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter code'**
  String get cartPromoCodeHint;

  /// No description provided for @productAddToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get productAddToCart;

  /// No description provided for @productAddToCartShort.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get productAddToCartShort;

  /// No description provided for @productBuyNow.
  ///
  /// In en, this message translates to:
  /// **'Buy now'**
  String get productBuyNow;

  /// No description provided for @productViewAllReviews.
  ///
  /// In en, this message translates to:
  /// **'View All Reviews'**
  String get productViewAllReviews;

  /// No description provided for @productSectionVariations.
  ///
  /// In en, this message translates to:
  /// **'Variations'**
  String get productSectionVariations;

  /// No description provided for @productSectionSpecifications.
  ///
  /// In en, this message translates to:
  /// **'Specifications'**
  String get productSectionSpecifications;

  /// No description provided for @productOrigin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get productOrigin;

  /// No description provided for @productDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get productDelivery;

  /// No description provided for @productRatingReviews.
  ///
  /// In en, this message translates to:
  /// **'Rating & Reviews'**
  String get productRatingReviews;

  /// No description provided for @productMostPopular.
  ///
  /// In en, this message translates to:
  /// **'Most Popular'**
  String get productMostPopular;

  /// No description provided for @productYouMightLike.
  ///
  /// In en, this message translates to:
  /// **'You Might Like'**
  String get productYouMightLike;

  /// No description provided for @productSizeGuideFallback.
  ///
  /// In en, this message translates to:
  /// **'Size guide'**
  String get productSizeGuideFallback;

  /// No description provided for @productNoReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet.'**
  String get productNoReviewsYet;

  /// No description provided for @productOriginFallbackEu.
  ///
  /// In en, this message translates to:
  /// **'EU'**
  String get productOriginFallbackEu;

  /// No description provided for @productSpecLine.
  ///
  /// In en, this message translates to:
  /// **'{label}  {value}'**
  String productSpecLine(String label, String value);

  /// No description provided for @categoryFilterAllCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get categoryFilterAllCategoriesTitle;

  /// No description provided for @categoryFilterSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search categories'**
  String get categoryFilterSearchHint;

  /// No description provided for @categoryFilterEmpty.
  ///
  /// In en, this message translates to:
  /// **'No categories'**
  String get categoryFilterEmpty;

  /// No description provided for @categoryFilterClearAllFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear all filters'**
  String get categoryFilterClearAllFilters;

  /// No description provided for @categoryFilterApplyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply filters'**
  String get categoryFilterApplyFilters;

  /// No description provided for @paymentPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get paymentPageTitle;

  /// No description provided for @paymentShippingAddressCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get paymentShippingAddressCardTitle;

  /// No description provided for @paymentContactInformationTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get paymentContactInformationTitle;

  /// No description provided for @paymentItemsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get paymentItemsSectionTitle;

  /// No description provided for @paymentShippingOptionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Shipping Options'**
  String get paymentShippingOptionsTitle;

  /// No description provided for @paymentShippingStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get paymentShippingStandard;

  /// No description provided for @paymentShippingStandardEta.
  ///
  /// In en, this message translates to:
  /// **'5-7 days'**
  String get paymentShippingStandardEta;

  /// No description provided for @paymentShippingFree.
  ///
  /// In en, this message translates to:
  /// **'FREE'**
  String get paymentShippingFree;

  /// No description provided for @paymentShippingExpress.
  ///
  /// In en, this message translates to:
  /// **'Express'**
  String get paymentShippingExpress;

  /// No description provided for @paymentShippingExpressEta.
  ///
  /// In en, this message translates to:
  /// **'1-2 days'**
  String get paymentShippingExpressEta;

  /// No description provided for @paymentDeliverySampleNote.
  ///
  /// In en, this message translates to:
  /// **'Delivered on or before Thursday, 23 April 2020'**
  String get paymentDeliverySampleNote;

  /// No description provided for @paymentMethodSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethodSectionTitle;

  /// No description provided for @paymentAddVoucher.
  ///
  /// In en, this message translates to:
  /// **'Add Voucher'**
  String get paymentAddVoucher;

  /// No description provided for @paymentProcessingTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment is in progress'**
  String get paymentProcessingTitle;

  /// No description provided for @paymentProcessingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please, wait a few moments'**
  String get paymentProcessingSubtitle;

  /// No description provided for @paymentErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t proceed your payment'**
  String get paymentErrorTitle;

  /// No description provided for @paymentErrorBody.
  ///
  /// In en, this message translates to:
  /// **'Please, change your payment method or try again'**
  String get paymentErrorBody;

  /// No description provided for @paymentTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get paymentTryAgain;

  /// No description provided for @paymentChangeMethod.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get paymentChangeMethod;

  /// No description provided for @paymentSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Done!'**
  String get paymentSuccessTitle;

  /// No description provided for @paymentSuccessBody.
  ///
  /// In en, this message translates to:
  /// **'Your card has been successfully charged'**
  String get paymentSuccessBody;

  /// No description provided for @paymentTrackOrder.
  ///
  /// In en, this message translates to:
  /// **'Track My Order'**
  String get paymentTrackOrder;

  /// No description provided for @paymentPercentDiscount.
  ///
  /// In en, this message translates to:
  /// **'{percent}% discount'**
  String paymentPercentDiscount(int percent);

  /// No description provided for @paymentNamedDiscount.
  ///
  /// In en, this message translates to:
  /// **'{name} discount'**
  String paymentNamedDiscount(String name);

  /// No description provided for @paymentTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get paymentTotalLabel;

  /// No description provided for @paymentPayButton.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get paymentPayButton;

  /// No description provided for @paymentCountryLabel.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get paymentCountryLabel;

  /// No description provided for @paymentSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get paymentSaveChanges;

  /// No description provided for @paymentAddressLineLabel.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get paymentAddressLineLabel;

  /// No description provided for @paymentTownCityLabel.
  ///
  /// In en, this message translates to:
  /// **'Town / City'**
  String get paymentTownCityLabel;

  /// No description provided for @paymentPostcodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Postcode'**
  String get paymentPostcodeLabel;

  /// No description provided for @paymentPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get paymentPhoneLabel;

  /// No description provided for @paymentEmailLabelField.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get paymentEmailLabelField;

  /// No description provided for @paymentMethodsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a card for this order. You can add new cards or update saved ones.'**
  String get paymentMethodsSubtitle;

  /// No description provided for @paymentEditTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get paymentEditTooltip;

  /// No description provided for @paymentAddPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Add payment method'**
  String get paymentAddPaymentMethod;

  /// No description provided for @paymentUseThisCard.
  ///
  /// In en, this message translates to:
  /// **'Use this card'**
  String get paymentUseThisCard;

  /// No description provided for @paymentEditCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit card'**
  String get paymentEditCardTitle;

  /// No description provided for @paymentAddCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Add card'**
  String get paymentAddCardTitle;

  /// No description provided for @paymentCardIntroEdit.
  ///
  /// In en, this message translates to:
  /// **'Change the name or expiry anytime. Enter a full card number only if you want to replace this card.'**
  String get paymentCardIntroEdit;

  /// No description provided for @paymentCardIntroAdd.
  ///
  /// In en, this message translates to:
  /// **'Enter your card details. This is a demo — nothing is charged.'**
  String get paymentCardIntroAdd;

  /// No description provided for @paymentCardCurrentMasked.
  ///
  /// In en, this message translates to:
  /// **'Current: {masked}'**
  String paymentCardCurrentMasked(String masked);

  /// No description provided for @paymentCardNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Card number'**
  String get paymentCardNumberLabel;

  /// No description provided for @paymentCardNumberHintKeep.
  ///
  /// In en, this message translates to:
  /// **'Leave blank to keep current'**
  String get paymentCardNumberHintKeep;

  /// No description provided for @paymentCardNumberError.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid card number'**
  String get paymentCardNumberError;

  /// No description provided for @paymentCardHolderLabel.
  ///
  /// In en, this message translates to:
  /// **'Name on card'**
  String get paymentCardHolderLabel;

  /// No description provided for @paymentCardHolderError.
  ///
  /// In en, this message translates to:
  /// **'Enter the cardholder name'**
  String get paymentCardHolderError;

  /// No description provided for @paymentCardExpiryLabel.
  ///
  /// In en, this message translates to:
  /// **'Expiry (MM/YY)'**
  String get paymentCardExpiryLabel;

  /// No description provided for @paymentCardExpiryFormatError.
  ///
  /// In en, this message translates to:
  /// **'Use MM/YY'**
  String get paymentCardExpiryFormatError;

  /// No description provided for @paymentCardExpiryMonthError.
  ///
  /// In en, this message translates to:
  /// **'Invalid month'**
  String get paymentCardExpiryMonthError;

  /// No description provided for @paymentCardCvvLabel.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get paymentCardCvvLabel;

  /// No description provided for @paymentCardCvvError.
  ///
  /// In en, this message translates to:
  /// **'Enter CVV'**
  String get paymentCardCvvError;

  /// No description provided for @paymentBrandVisa.
  ///
  /// In en, this message translates to:
  /// **'Visa'**
  String get paymentBrandVisa;

  /// No description provided for @paymentBrandMastercard.
  ///
  /// In en, this message translates to:
  /// **'Mastercard'**
  String get paymentBrandMastercard;

  /// No description provided for @paymentVouchersActiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Active Vouchers'**
  String get paymentVouchersActiveTitle;

  /// No description provided for @paymentVoucherLabel.
  ///
  /// In en, this message translates to:
  /// **'Voucher'**
  String get paymentVoucherLabel;

  /// No description provided for @paymentVoucherValid.
  ///
  /// In en, this message translates to:
  /// **'Valid'**
  String get paymentVoucherValid;

  /// No description provided for @serviceHubTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Hub'**
  String get serviceHubTitle;

  /// No description provided for @serviceHubPostSuccess.
  ///
  /// In en, this message translates to:
  /// **'Project posted successfully.'**
  String get serviceHubPostSuccess;

  /// No description provided for @serviceHubPostProject.
  ///
  /// In en, this message translates to:
  /// **'Post Project'**
  String get serviceHubPostProject;

  /// No description provided for @serviceHubBidApply.
  ///
  /// In en, this message translates to:
  /// **'Bid / Apply'**
  String get serviceHubBidApply;

  /// No description provided for @serviceHubTabPostJob.
  ///
  /// In en, this message translates to:
  /// **'Post a Job'**
  String get serviceHubTabPostJob;

  /// No description provided for @serviceHubTabBrowseRequests.
  ///
  /// In en, this message translates to:
  /// **'Browse Requests'**
  String get serviceHubTabBrowseRequests;

  /// No description provided for @serviceHubFormHeading.
  ///
  /// In en, this message translates to:
  /// **'Post a New Project'**
  String get serviceHubFormHeading;

  /// No description provided for @serviceHubFormSubheading.
  ///
  /// In en, this message translates to:
  /// **'Describe your requirements and receive bids from pros.'**
  String get serviceHubFormSubheading;

  /// No description provided for @serviceHubFieldProjectTitle.
  ///
  /// In en, this message translates to:
  /// **'Project Title'**
  String get serviceHubFieldProjectTitle;

  /// No description provided for @serviceHubFieldProjectTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Kitchen plumbing repair'**
  String get serviceHubFieldProjectTitleHint;

  /// No description provided for @serviceHubFieldProjectTitleError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a project title'**
  String get serviceHubFieldProjectTitleError;

  /// No description provided for @serviceHubFieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Detailed Description'**
  String get serviceHubFieldDescription;

  /// No description provided for @serviceHubFieldDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Explain scope, timing, and special requests...'**
  String get serviceHubFieldDescriptionHint;

  /// No description provided for @serviceHubFieldDescriptionError.
  ///
  /// In en, this message translates to:
  /// **'Please add at least 12 characters'**
  String get serviceHubFieldDescriptionError;

  /// No description provided for @serviceHubSampleJob1Customer.
  ///
  /// In en, this message translates to:
  /// **'Lera'**
  String get serviceHubSampleJob1Customer;

  /// No description provided for @serviceHubSampleJob1Title.
  ///
  /// In en, this message translates to:
  /// **'Apartment Renovation'**
  String get serviceHubSampleJob1Title;

  /// No description provided for @serviceHubSampleJob1Snippet.
  ///
  /// In en, this message translates to:
  /// **'Need painting, flooring refresh, and kitchen cabinet updates.'**
  String get serviceHubSampleJob1Snippet;

  /// No description provided for @serviceHubSampleJob2Customer.
  ///
  /// In en, this message translates to:
  /// **'Askar'**
  String get serviceHubSampleJob2Customer;

  /// No description provided for @serviceHubSampleJob2Title.
  ///
  /// In en, this message translates to:
  /// **'Deep Home Cleaning'**
  String get serviceHubSampleJob2Title;

  /// No description provided for @serviceHubSampleJob2Snippet.
  ///
  /// In en, this message translates to:
  /// **'Move-out cleanup for a 2-bedroom apartment this weekend.'**
  String get serviceHubSampleJob2Snippet;

  /// No description provided for @serviceHubSampleJob3Customer.
  ///
  /// In en, this message translates to:
  /// **'Dana'**
  String get serviceHubSampleJob3Customer;

  /// No description provided for @serviceHubSampleJob3Title.
  ///
  /// In en, this message translates to:
  /// **'Furniture Assembly'**
  String get serviceHubSampleJob3Title;

  /// No description provided for @serviceHubSampleJob3Snippet.
  ///
  /// In en, this message translates to:
  /// **'Assemble wardrobe, desk, and two side tables.'**
  String get serviceHubSampleJob3Snippet;

  /// No description provided for @profilePayNow.
  ///
  /// In en, this message translates to:
  /// **'Pay now'**
  String get profilePayNow;

  /// No description provided for @profileTrack.
  ///
  /// In en, this message translates to:
  /// **'Track'**
  String get profileTrack;

  /// No description provided for @profileReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get profileReview;

  /// No description provided for @profileOrderHistory.
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get profileOrderHistory;

  /// No description provided for @profileHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get profileHistoryTitle;

  /// No description provided for @profileTabToPay.
  ///
  /// In en, this message translates to:
  /// **'To Pay'**
  String get profileTabToPay;

  /// No description provided for @profileTabToReceive.
  ///
  /// In en, this message translates to:
  /// **'To Receive'**
  String get profileTabToReceive;

  /// No description provided for @profileTabToReview.
  ///
  /// In en, this message translates to:
  /// **'To Review'**
  String get profileTabToReview;

  /// No description provided for @profileMyOrdersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get profileMyOrdersSubtitle;

  /// No description provided for @profileNothingHereYet.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get profileNothingHereYet;

  /// No description provided for @profilePaymentFlowSoon.
  ///
  /// In en, this message translates to:
  /// **'Payment flow coming soon'**
  String get profilePaymentFlowSoon;

  /// No description provided for @profileFailedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile'**
  String get profileFailedToLoad;

  /// No description provided for @profileGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}!'**
  String profileGreeting(String name);

  /// No description provided for @profileRecentlyViewed.
  ///
  /// In en, this message translates to:
  /// **'Recently viewed'**
  String get profileRecentlyViewed;

  /// No description provided for @profileMyOrdersSection.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get profileMyOrdersSection;

  /// No description provided for @profileStoriesSection.
  ///
  /// In en, this message translates to:
  /// **'Stories'**
  String get profileStoriesSection;

  /// No description provided for @profileMyActivity.
  ///
  /// In en, this message translates to:
  /// **'My Activity'**
  String get profileMyActivity;

  /// No description provided for @profileScannerSoon.
  ///
  /// In en, this message translates to:
  /// **'Scanner coming soon'**
  String get profileScannerSoon;

  /// No description provided for @profileFiltersSoon.
  ///
  /// In en, this message translates to:
  /// **'Filters coming soon'**
  String get profileFiltersSoon;

  /// No description provided for @orderTrackingPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track Your Order'**
  String get orderTrackingPageSubtitle;

  /// No description provided for @orderTrackingNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Tracking Number'**
  String get orderTrackingNumberLabel;

  /// No description provided for @orderTrackingCopiedNumber.
  ///
  /// In en, this message translates to:
  /// **'Copied tracking number'**
  String get orderTrackingCopiedNumber;

  /// No description provided for @vouchersPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Vouchers'**
  String get vouchersPageTitle;

  /// No description provided for @vouchersTabActiveRewards.
  ///
  /// In en, this message translates to:
  /// **'Active Rewards'**
  String get vouchersTabActiveRewards;

  /// No description provided for @vouchersTabProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get vouchersTabProgress;

  /// No description provided for @settingsYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Your Profile'**
  String get settingsYourProfile;

  /// No description provided for @settingsChooseCountryPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Choose your country'**
  String get settingsChooseCountryPlaceholder;

  /// No description provided for @validationFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get validationFieldRequired;

  /// No description provided for @settingsProfileDisplayNameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Display name cannot be empty.'**
  String get settingsProfileDisplayNameEmpty;

  /// No description provided for @settingsProfileEmailConfirmSent.
  ///
  /// In en, this message translates to:
  /// **'We sent a confirmation link to {email}. Open it to complete the email change.'**
  String settingsProfileEmailConfirmSent(String email);

  /// No description provided for @settingsProfileNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get settingsProfileNameLabel;

  /// No description provided for @profileStatOrdered.
  ///
  /// In en, this message translates to:
  /// **'Ordered'**
  String get profileStatOrdered;

  /// No description provided for @profileStatReceived.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get profileStatReceived;

  /// No description provided for @profileStatToReceive.
  ///
  /// In en, this message translates to:
  /// **'To Receive'**
  String get profileStatToReceive;

  /// No description provided for @profileChatNow.
  ///
  /// In en, this message translates to:
  /// **'Chat Now'**
  String get profileChatNow;

  /// No description provided for @profileSayIt.
  ///
  /// In en, this message translates to:
  /// **'Say it!'**
  String get profileSayIt;

  /// No description provided for @profileReviewThankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your review'**
  String get profileReviewThankYou;

  /// No description provided for @profileNoItemsToReview.
  ///
  /// In en, this message translates to:
  /// **'No items to review'**
  String get profileNoItemsToReview;

  /// No description provided for @profileReviewWhichItem.
  ///
  /// In en, this message translates to:
  /// **'Which item do you want to review?'**
  String get profileReviewWhichItem;

  /// No description provided for @profileDeliveryNotSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Delivery was not successful'**
  String get profileDeliveryNotSuccessful;

  /// No description provided for @profileDeliveryWhatToDo.
  ///
  /// In en, this message translates to:
  /// **'What should I do?'**
  String get profileDeliveryWhatToDo;

  /// No description provided for @profileDeliveryFailureBody.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry, we will shortly contact you to arrange a more suitable time for the delivery. You can also contact us at +00 000 000 000 or chat with customer care.'**
  String get profileDeliveryFailureBody;

  /// No description provided for @voucherCollected.
  ///
  /// In en, this message translates to:
  /// **'Collected'**
  String get voucherCollected;

  /// No description provided for @validationChooseCountry.
  ///
  /// In en, this message translates to:
  /// **'Please choose a country'**
  String get validationChooseCountry;

  /// No description provided for @settingsSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get settingsSaveChanges;

  /// No description provided for @profilePhotoEditorSoon.
  ///
  /// In en, this message translates to:
  /// **'Photo editor coming soon'**
  String get profilePhotoEditorSoon;

  /// No description provided for @aiInteriorTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Design & Quote'**
  String get aiInteriorTitle;

  /// No description provided for @aiInteriorRoomInput.
  ///
  /// In en, this message translates to:
  /// **'Room Input'**
  String get aiInteriorRoomInput;

  /// No description provided for @aiInteriorRecommendedFurniture.
  ///
  /// In en, this message translates to:
  /// **'Recommended Furniture'**
  String get aiInteriorRecommendedFurniture;

  /// No description provided for @aiInteriorSummaryReport.
  ///
  /// In en, this message translates to:
  /// **'Summary Report'**
  String get aiInteriorSummaryReport;

  /// No description provided for @aiInteriorStopScanning.
  ///
  /// In en, this message translates to:
  /// **'Stop Scanning'**
  String get aiInteriorStopScanning;

  /// No description provided for @aiInteriorStartAiScan.
  ///
  /// In en, this message translates to:
  /// **'Start AI Scan'**
  String get aiInteriorStartAiScan;

  /// No description provided for @aiInteriorUploadImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get aiInteriorUploadImage;

  /// No description provided for @aiInteriorUploadFormats.
  ///
  /// In en, this message translates to:
  /// **'PNG, JPG up to 10 MB'**
  String get aiInteriorUploadFormats;

  /// No description provided for @aiInteriorScanning.
  ///
  /// In en, this message translates to:
  /// **'Scanning...'**
  String get aiInteriorScanning;

  /// No description provided for @aiInteriorShopMarketplace.
  ///
  /// In en, this message translates to:
  /// **'Shop in Marketplace'**
  String get aiInteriorShopMarketplace;

  /// No description provided for @aiInteriorMaterialsEstimate.
  ///
  /// In en, this message translates to:
  /// **'Materials Estimate'**
  String get aiInteriorMaterialsEstimate;

  /// No description provided for @aiInteriorLaborEstimate.
  ///
  /// In en, this message translates to:
  /// **'Labor Estimate'**
  String get aiInteriorLaborEstimate;

  /// No description provided for @aiInteriorTotalEstimatedCost.
  ///
  /// In en, this message translates to:
  /// **'Total Estimated Cost'**
  String get aiInteriorTotalEstimatedCost;

  /// No description provided for @shoppingNotesTitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping notes'**
  String get shoppingNotesTitle;

  /// No description provided for @shoppingNotesChart.
  ///
  /// In en, this message translates to:
  /// **'Chart'**
  String get shoppingNotesChart;

  /// No description provided for @shoppingNotesAllCategoriesSegment.
  ///
  /// In en, this message translates to:
  /// **'All categories'**
  String get shoppingNotesAllCategoriesSegment;

  /// No description provided for @shoppingNotesAddCategoryFirst.
  ///
  /// In en, this message translates to:
  /// **'Add a category first'**
  String get shoppingNotesAddCategoryFirst;

  /// No description provided for @shoppingNotesNewCategory.
  ///
  /// In en, this message translates to:
  /// **'New category'**
  String get shoppingNotesNewCategory;

  /// No description provided for @shoppingNotesRenameCategory.
  ///
  /// In en, this message translates to:
  /// **'Rename category'**
  String get shoppingNotesRenameCategory;

  /// No description provided for @shoppingNotesAddCategory.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get shoppingNotesAddCategory;

  /// No description provided for @shoppingNotesCannotDelete.
  ///
  /// In en, this message translates to:
  /// **'Cannot delete'**
  String get shoppingNotesCannotDelete;

  /// No description provided for @shoppingNotesCategoryError.
  ///
  /// In en, this message translates to:
  /// **'Category error'**
  String get shoppingNotesCategoryError;

  /// No description provided for @shoppingNotesExportTooltip.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get shoppingNotesExportTooltip;

  /// No description provided for @shoppingNotesManageCategoriesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Manage categories'**
  String get shoppingNotesManageCategoriesTooltip;

  /// No description provided for @shoppingNotesOnlineBanner.
  ///
  /// In en, this message translates to:
  /// **'Online: changes will try to sync (demo HTTP).'**
  String get shoppingNotesOnlineBanner;

  /// No description provided for @shoppingNotesOfflineBanner.
  ///
  /// In en, this message translates to:
  /// **'Offline: data stays on this device.'**
  String get shoppingNotesOfflineBanner;

  /// No description provided for @shoppingNotesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Filter by title, details, or category'**
  String get shoppingNotesSearchHint;

  /// No description provided for @shoppingNotesCouldNotLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load notes.\n'**
  String get shoppingNotesCouldNotLoad;

  /// No description provided for @shoppingNotesNoNotesYet.
  ///
  /// In en, this message translates to:
  /// **'No notes yet. Tap + to add one.'**
  String get shoppingNotesNoNotesYet;

  /// No description provided for @shoppingNotesNoMatchFilter.
  ///
  /// In en, this message translates to:
  /// **'No notes match the current filter.'**
  String get shoppingNotesNoMatchFilter;

  /// No description provided for @shoppingNotesSyncStatusSynced.
  ///
  /// In en, this message translates to:
  /// **'synced'**
  String get shoppingNotesSyncStatusSynced;

  /// No description provided for @shoppingNotesSyncStatusLocal.
  ///
  /// In en, this message translates to:
  /// **'local'**
  String get shoppingNotesSyncStatusLocal;

  /// No description provided for @shoppingNotesNeedCategoryBody.
  ///
  /// In en, this message translates to:
  /// **'Notes require a category. Open \"Manage categories\" and create at least one.'**
  String get shoppingNotesNeedCategoryBody;

  /// No description provided for @shoppingNotesNewNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'New note'**
  String get shoppingNotesNewNoteTitle;

  /// No description provided for @shoppingNotesEditNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit note'**
  String get shoppingNotesEditNoteTitle;

  /// No description provided for @shoppingNotesFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get shoppingNotesFieldTitle;

  /// No description provided for @shoppingNotesFieldDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get shoppingNotesFieldDetails;

  /// No description provided for @shoppingNotesFieldCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get shoppingNotesFieldCategory;

  /// No description provided for @shoppingNotesFieldAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get shoppingNotesFieldAmount;

  /// No description provided for @shoppingNotesCategoriesSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get shoppingNotesCategoriesSheetTitle;

  /// No description provided for @shoppingNotesCouldNotLoadCategories.
  ///
  /// In en, this message translates to:
  /// **'Could not load categories.\n'**
  String get shoppingNotesCouldNotLoadCategories;

  /// No description provided for @shoppingNotesNoCategoriesYet.
  ///
  /// In en, this message translates to:
  /// **'No categories. Tap + to add one.'**
  String get shoppingNotesNoCategoriesYet;

  /// No description provided for @shoppingNotesCategoryRowMeta.
  ///
  /// In en, this message translates to:
  /// **'id {id} · updated {date}'**
  String shoppingNotesCategoryRowMeta(int id, String date);

  /// No description provided for @shoppingNotesCannotDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'Remove or reassign notes that use this category first.\n'**
  String get shoppingNotesCannotDeleteBody;

  /// No description provided for @spendingByCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Spending by category'**
  String get spendingByCategoryTitle;

  /// No description provided for @spendingAnalyticsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load chart data.\n'**
  String get spendingAnalyticsLoadError;

  /// No description provided for @spendingAnalyticsEmptyPrompt.
  ///
  /// In en, this message translates to:
  /// **'Add shopping notes with categories and amounts to see the chart.'**
  String get spendingAnalyticsEmptyPrompt;

  /// No description provided for @spendingAnalyticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Totals from your local notes (works offline).'**
  String get spendingAnalyticsSubtitle;
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
