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

  @override
  String get settingsThemeSection => 'Appearance';

  @override
  String get themeModeSystem => 'System';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get settingsDailyReminderTitle => 'Daily shopping-notes reminder';

  @override
  String get settingsDailyReminderSubtitle =>
      'Once per day at 8:00 PM (device time)';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingStart => 'Get started';

  @override
  String get onboardingPage1Title => 'Browse with confidence';

  @override
  String get onboardingPage1Body =>
      'Explore furniture and decor in one place, tailored for your home.';

  @override
  String get onboardingPage2Title => 'Track what you spend';

  @override
  String get onboardingPage2Body =>
      'Use offline shopping notes to log prices and categories anytime.';

  @override
  String get onboardingPage3Title => 'Your data stays with you';

  @override
  String get onboardingPage3Body =>
      'Notes are stored on this device; sign in when you want cloud features.';

  @override
  String get exportShoppingNotesCsv => 'Export CSV';

  @override
  String get exportShoppingNotesPdf => 'Export PDF';

  @override
  String get exportShoppingNotesEmpty => 'No notes to export.';

  @override
  String exportShoppingNotesFailed(String message) {
    return 'Export failed: $message';
  }

  @override
  String get shoppingNotesCsvHeaderId => 'id';

  @override
  String get shoppingNotesCsvHeaderTitle => 'title';

  @override
  String get shoppingNotesCsvHeaderBody => 'body';

  @override
  String get shoppingNotesCsvHeaderCategory => 'category';

  @override
  String get shoppingNotesCsvHeaderCategoryId => 'category_id';

  @override
  String get shoppingNotesCsvHeaderAmount => 'amount';

  @override
  String get shoppingNotesCsvHeaderSynced => 'synced_to_remote';

  @override
  String get shoppingNotesCsvHeaderCreated => 'created_at_utc';

  @override
  String get shoppingNotesCsvHeaderUpdated => 'updated_at_utc';

  @override
  String get shoppingNotesPdfTitle => 'Shopping notes';

  @override
  String get shoppingNotesPdfHeaderId => 'ID';

  @override
  String get shoppingNotesPdfHeaderTitle => 'Title';

  @override
  String get shoppingNotesPdfHeaderCategory => 'Category';

  @override
  String get shoppingNotesPdfHeaderAmount => 'Amount';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSectionPersonal => 'Personal';

  @override
  String get settingsSectionShop => 'Shop';

  @override
  String get settingsSectionAccount => 'Account';

  @override
  String get settingsRowProfile => 'Profile';

  @override
  String get settingsRowShippingAddress => 'Shipping Address';

  @override
  String get settingsRowPaymentMethods => 'Payment methods';

  @override
  String get settingsRowShoppingNotes => 'Shopping notes (offline)';

  @override
  String get settingsRowSpendingChart => 'Spending chart';

  @override
  String get settingsRowCountry => 'Country';

  @override
  String get settingsRowCurrency => 'Currency';

  @override
  String get settingsRowSizes => 'Sizes';

  @override
  String get settingsRowTerms => 'Terms and Conditions';

  @override
  String get settingsRowLanguage => 'Language';

  @override
  String get settingsRowLogout => 'Log out';

  @override
  String settingsRowAbout(String appName) {
    return 'About $appName';
  }

  @override
  String get settingsDeleteAccountAction => 'Delete My Account';

  @override
  String settingsVersionLabel(String version, String buildDate) {
    return 'Version $version · $buildDate';
  }

  @override
  String get settingsLogoutTitle => 'Log out';

  @override
  String get settingsLogoutMessage => 'Log out of your account?';

  @override
  String get settingsDeleteAccountTitle => 'Delete account?';

  @override
  String get settingsDeleteAccountMessage =>
      'You will not be able to restore your data. This is a demo only.';

  @override
  String get settingsDeleteAccountDemoMessage =>
      'Account deletion is not available in demo';

  @override
  String settingsComingSoonMessage(String feature) {
    return '$feature — coming soon';
  }

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonLogout => 'Log out';

  @override
  String get commonDelete => 'Delete';

  @override
  String get languagePageTitle => 'Language';

  @override
  String get languageFollowSystem => 'Follow system';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageKazakh => 'Kazakh';

  @override
  String get languageRussian => 'Russian';

  @override
  String get appWindowTitle => 'Shop Paradise';

  @override
  String get commonOk => 'OK';

  @override
  String get commonSave => 'Save';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonSeeAll => 'See all';

  @override
  String get homeJustForYouRetryLoadingMore => 'Retry loading more';

  @override
  String get commonTryAgain => 'Try again';

  @override
  String get commonApply => 'Apply';

  @override
  String get commonDone => 'Done';

  @override
  String get commonChange => 'Change';

  @override
  String get commonClear => 'Clear';

  @override
  String get commonCloseTooltip => 'Close';

  @override
  String get commonSelectAll => 'Select all';

  @override
  String errorMessageWithDetails(String message) {
    return 'Error: $message';
  }

  @override
  String get loginSubtitleWelcomeBack => 'Good to see you back!  🖤';

  @override
  String get loginForgotPassword => 'Forgot password?';

  @override
  String get loginChangeEmail => 'Change email';

  @override
  String get loginPasswordResetSent => 'Password reset email sent.';

  @override
  String get loginEnterEmail => 'Enter your email';

  @override
  String get loginEnterPassword => 'Enter password';

  @override
  String get loginEnterValidEmailFirst => 'Enter a valid email first';

  @override
  String get shopHomeTitle => 'Shop';

  @override
  String get cartTitle => 'My cart';

  @override
  String get cartFailedToLoad => 'Failed to load cart';

  @override
  String get cartRemovedSelected => 'Removed selected items';

  @override
  String get cartBrowseHomeSnackbar => 'Open the Home tab to browse products.';

  @override
  String cartItemRemoved(String title) {
    return '$title removed';
  }

  @override
  String get cartTooltipDeleteSelected => 'Delete selected';

  @override
  String get cartTooltipSelectItems => 'Select items';

  @override
  String get cartCheckout => 'Checkout';

  @override
  String get cartSubtotal => 'Subtotal';

  @override
  String get cartDiscountRow => 'Discount';

  @override
  String get cartTax => 'Tax';

  @override
  String get cartFreeLabel => 'Free';

  @override
  String get cartTotalRow => 'Total';

  @override
  String get cartStartShopping => 'Start shopping';

  @override
  String get wishlistFailedToLoad => 'Failed to load wishlist';

  @override
  String wishlistSavedCount(int count) {
    return '$count saved items';
  }

  @override
  String get wishlistTitle => 'My Wishlist';

  @override
  String wishlistItemRemoved(String title) {
    return '$title removed';
  }

  @override
  String wishlistItemAddedToCart(String title) {
    return '$title added to cart';
  }

  @override
  String get wishlistRestoreDemo => 'Restore demo items';

  @override
  String get ordersFailedToLoad => 'Failed to load orders';

  @override
  String ordersPlacedOn(String when) {
    return 'Placed $when';
  }

  @override
  String ordersSheetSummaryLine(int itemCount, String total) {
    return '$itemCount items · $total';
  }

  @override
  String get ordersSheetTrackingPlaceholder =>
      'Full order tracking will appear here once connected to your store backend.';

  @override
  String ordersCountHeader(int count) {
    return '$count orders';
  }

  @override
  String get ordersTitle => 'My orders';

  @override
  String get ordersRestoreDemo => 'Restore demo orders';

  @override
  String get orderStatusProcessing => 'Processing';

  @override
  String get orderStatusShipped => 'Shipped';

  @override
  String get orderStatusDelivered => 'Delivered';

  @override
  String get orderStatusCancelled => 'Cancelled';

  @override
  String orderItemsCount(int count) {
    return '$count items';
  }

  @override
  String get homeMarketplaceTitle => 'Home Marketplace';

  @override
  String get homeMarketSearchHint => 'Search products, brands, supplies...';

  @override
  String get homeMarketSearchPlaceholderShort => 'Search';

  @override
  String get homeMarketCategoryFiltersTooltip => 'Category filters';

  @override
  String get homeAppBarAiDesignTooltip => 'AI Design';

  @override
  String get homeAppBarServiceHubTooltip => 'Service Hub';

  @override
  String get homeMarketCategoryAll => 'All';

  @override
  String get homeMarketCategoryGroceries => 'Groceries';

  @override
  String get homeMarketCategoryHomeGoods => 'Home Goods';

  @override
  String get homeMarketCategoryDecor => 'Decor';

  @override
  String get homeMarketProductFreshFruitBasket => 'Fresh Fruit Basket';

  @override
  String get homeMarketProductKitchenStorageSet => 'Kitchen Storage Set';

  @override
  String get homeMarketProductScentedCandleTrio => 'Scented Candle Trio';

  @override
  String get homeMarketProductLaundryOrganizer => 'Laundry Organizer';

  @override
  String get homeMarketProductIndoorPlantKit => 'Indoor Plant Kit';

  @override
  String get homeMarketProductOrganicDairyBundle => 'Organic Dairy Bundle';

  @override
  String get cartPromoCodeHint => 'Enter code';

  @override
  String get productAddToCart => 'Add to cart';

  @override
  String get productAddToCartShort => 'Add to Cart';

  @override
  String get productBuyNow => 'Buy now';

  @override
  String get productViewAllReviews => 'View All Reviews';

  @override
  String get productSectionVariations => 'Variations';

  @override
  String get productSectionSpecifications => 'Specifications';

  @override
  String get productOrigin => 'Origin';

  @override
  String get productDelivery => 'Delivery';

  @override
  String get productRatingReviews => 'Rating & Reviews';

  @override
  String get productMostPopular => 'Most Popular';

  @override
  String get productYouMightLike => 'You Might Like';

  @override
  String get productSizeGuideFallback => 'Size guide';

  @override
  String get productNoReviewsYet => 'No reviews yet.';

  @override
  String get productOriginFallbackEu => 'EU';

  @override
  String productSpecLine(String label, String value) {
    return '$label  $value';
  }

  @override
  String get categoryFilterAllCategoriesTitle => 'All Categories';

  @override
  String get categoryFilterSearchHint => 'Search categories';

  @override
  String get categoryFilterEmpty => 'No categories';

  @override
  String get categoryFilterClearAllFilters => 'Clear all filters';

  @override
  String get categoryFilterApplyFilters => 'Apply filters';

  @override
  String get paymentPageTitle => 'Payment';

  @override
  String get paymentShippingAddressCardTitle => 'Shipping Address';

  @override
  String get paymentContactInformationTitle => 'Contact Information';

  @override
  String get paymentItemsSectionTitle => 'Items';

  @override
  String get paymentShippingOptionsTitle => 'Shipping Options';

  @override
  String get paymentShippingStandard => 'Standard';

  @override
  String get paymentShippingStandardEta => '5-7 days';

  @override
  String get paymentShippingFree => 'FREE';

  @override
  String get paymentShippingExpress => 'Express';

  @override
  String get paymentShippingExpressEta => '1-2 days';

  @override
  String get paymentDeliverySampleNote =>
      'Delivered on or before Thursday, 23 April 2020';

  @override
  String get paymentMethodSectionTitle => 'Payment method';

  @override
  String get paymentAddVoucher => 'Add Voucher';

  @override
  String get paymentProcessingTitle => 'Payment is in progress';

  @override
  String get paymentProcessingSubtitle => 'Please, wait a few moments';

  @override
  String get paymentErrorTitle => 'We couldn\'t proceed your payment';

  @override
  String get paymentErrorBody =>
      'Please, change your payment method or try again';

  @override
  String get paymentTryAgain => 'Try Again';

  @override
  String get paymentChangeMethod => 'Change';

  @override
  String get paymentSuccessTitle => 'Done!';

  @override
  String get paymentSuccessBody => 'Your card has been successfully charged';

  @override
  String get paymentTrackOrder => 'Track My Order';

  @override
  String paymentPercentDiscount(int percent) {
    return '$percent% discount';
  }

  @override
  String paymentNamedDiscount(String name) {
    return '$name discount';
  }

  @override
  String get paymentTotalLabel => 'Total';

  @override
  String get paymentPayButton => 'Pay';

  @override
  String get paymentCountryLabel => 'Country';

  @override
  String get paymentSaveChanges => 'Save Changes';

  @override
  String get paymentAddressLineLabel => 'Address';

  @override
  String get paymentTownCityLabel => 'Town / City';

  @override
  String get paymentPostcodeLabel => 'Postcode';

  @override
  String get paymentPhoneLabel => 'Phone';

  @override
  String get paymentEmailLabelField => 'Email';

  @override
  String get paymentMethodsSubtitle =>
      'Choose a card for this order. You can add new cards or update saved ones.';

  @override
  String get paymentEditTooltip => 'Edit';

  @override
  String get paymentAddPaymentMethod => 'Add payment method';

  @override
  String get paymentUseThisCard => 'Use this card';

  @override
  String get paymentEditCardTitle => 'Edit card';

  @override
  String get paymentAddCardTitle => 'Add card';

  @override
  String get paymentCardIntroEdit =>
      'Change the name or expiry anytime. Enter a full card number only if you want to replace this card.';

  @override
  String get paymentCardIntroAdd =>
      'Enter your card details. This is a demo — nothing is charged.';

  @override
  String paymentCardCurrentMasked(String masked) {
    return 'Current: $masked';
  }

  @override
  String get paymentCardNumberLabel => 'Card number';

  @override
  String get paymentCardNumberHintKeep => 'Leave blank to keep current';

  @override
  String get paymentCardNumberError => 'Enter a valid card number';

  @override
  String get paymentCardHolderLabel => 'Name on card';

  @override
  String get paymentCardHolderError => 'Enter the cardholder name';

  @override
  String get paymentCardExpiryLabel => 'Expiry (MM/YY)';

  @override
  String get paymentCardExpiryFormatError => 'Use MM/YY';

  @override
  String get paymentCardExpiryMonthError => 'Invalid month';

  @override
  String get paymentCardCvvLabel => 'CVV';

  @override
  String get paymentCardCvvError => 'Enter CVV';

  @override
  String get paymentBrandVisa => 'Visa';

  @override
  String get paymentBrandMastercard => 'Mastercard';

  @override
  String get paymentVouchersActiveTitle => 'Active Vouchers';

  @override
  String get paymentVoucherLabel => 'Voucher';

  @override
  String get paymentVoucherValid => 'Valid';

  @override
  String get serviceHubTitle => 'Service Hub';

  @override
  String get serviceHubPostSuccess => 'Project posted successfully.';

  @override
  String get serviceHubPostProject => 'Post Project';

  @override
  String get serviceHubBidApply => 'Bid / Apply';

  @override
  String get serviceHubTabPostJob => 'Post a Job';

  @override
  String get serviceHubTabBrowseRequests => 'Browse Requests';

  @override
  String get serviceHubFormHeading => 'Post a New Project';

  @override
  String get serviceHubFormSubheading =>
      'Describe your requirements and receive bids from pros.';

  @override
  String get serviceHubFieldProjectTitle => 'Project Title';

  @override
  String get serviceHubFieldProjectTitleHint => 'Kitchen plumbing repair';

  @override
  String get serviceHubFieldProjectTitleError => 'Please enter a project title';

  @override
  String get serviceHubFieldDescription => 'Detailed Description';

  @override
  String get serviceHubFieldDescriptionHint =>
      'Explain scope, timing, and special requests...';

  @override
  String get serviceHubFieldDescriptionError =>
      'Please add at least 12 characters';

  @override
  String get serviceHubSampleJob1Customer => 'Lera';

  @override
  String get serviceHubSampleJob1Title => 'Apartment Renovation';

  @override
  String get serviceHubSampleJob1Snippet =>
      'Need painting, flooring refresh, and kitchen cabinet updates.';

  @override
  String get serviceHubSampleJob2Customer => 'Askar';

  @override
  String get serviceHubSampleJob2Title => 'Deep Home Cleaning';

  @override
  String get serviceHubSampleJob2Snippet =>
      'Move-out cleanup for a 2-bedroom apartment this weekend.';

  @override
  String get serviceHubSampleJob3Customer => 'Dana';

  @override
  String get serviceHubSampleJob3Title => 'Furniture Assembly';

  @override
  String get serviceHubSampleJob3Snippet =>
      'Assemble wardrobe, desk, and two side tables.';

  @override
  String get profilePayNow => 'Pay now';

  @override
  String get profileTrack => 'Track';

  @override
  String get profileReview => 'Review';

  @override
  String get profileOrderHistory => 'Order History';

  @override
  String get profileHistoryTitle => 'History';

  @override
  String get profileTabToPay => 'To Pay';

  @override
  String get profileTabToReceive => 'To Receive';

  @override
  String get profileTabToReview => 'To Review';

  @override
  String get profileMyOrdersSubtitle => 'My Orders';

  @override
  String get profileNothingHereYet => 'Nothing here yet';

  @override
  String get profilePaymentFlowSoon => 'Payment flow coming soon';

  @override
  String get profileFailedToLoad => 'Failed to load profile';

  @override
  String profileGreeting(String name) {
    return 'Hello, $name!';
  }

  @override
  String get profileRecentlyViewed => 'Recently viewed';

  @override
  String get profileMyOrdersSection => 'My Orders';

  @override
  String get profileStoriesSection => 'Stories';

  @override
  String get profileMyActivity => 'My Activity';

  @override
  String get profileScannerSoon => 'Scanner coming soon';

  @override
  String get profileFiltersSoon => 'Filters coming soon';

  @override
  String get orderTrackingPageSubtitle => 'Track Your Order';

  @override
  String get orderTrackingNumberLabel => 'Tracking Number';

  @override
  String get orderTrackingCopiedNumber => 'Copied tracking number';

  @override
  String get vouchersPageTitle => 'Vouchers';

  @override
  String get vouchersTabActiveRewards => 'Active Rewards';

  @override
  String get vouchersTabProgress => 'Progress';

  @override
  String get settingsYourProfile => 'Your Profile';

  @override
  String get settingsChooseCountryPlaceholder => 'Choose your country';

  @override
  String get validationFieldRequired => 'Required';

  @override
  String get settingsProfileDisplayNameEmpty => 'Display name cannot be empty.';

  @override
  String settingsProfileEmailConfirmSent(String email) {
    return 'We sent a confirmation link to $email. Open it to complete the email change.';
  }

  @override
  String get settingsProfileNameLabel => 'Name';

  @override
  String get profileStatOrdered => 'Ordered';

  @override
  String get profileStatReceived => 'Received';

  @override
  String get profileStatToReceive => 'To Receive';

  @override
  String get profileChatNow => 'Chat Now';

  @override
  String get profileSayIt => 'Say it!';

  @override
  String get profileReviewThankYou => 'Thank you for your review';

  @override
  String get profileNoItemsToReview => 'No items to review';

  @override
  String get profileReviewWhichItem => 'Which item do you want to review?';

  @override
  String get profileDeliveryNotSuccessful => 'Delivery was not successful';

  @override
  String get profileDeliveryWhatToDo => 'What should I do?';

  @override
  String get profileDeliveryFailureBody =>
      'Don\'t worry, we will shortly contact you to arrange a more suitable time for the delivery. You can also contact us at +00 000 000 000 or chat with customer care.';

  @override
  String get voucherCollected => 'Collected';

  @override
  String get validationChooseCountry => 'Please choose a country';

  @override
  String get settingsSaveChanges => 'Save changes';

  @override
  String get profilePhotoEditorSoon => 'Photo editor coming soon';

  @override
  String get aiInteriorTitle => 'AI Design & Quote';

  @override
  String get aiInteriorRoomInput => 'Room Input';

  @override
  String get aiInteriorRecommendedFurniture => 'Recommended Furniture';

  @override
  String get aiInteriorSummaryReport => 'Summary Report';

  @override
  String get aiInteriorStopScanning => 'Stop Scanning';

  @override
  String get aiInteriorStartAiScan => 'Start AI Scan';

  @override
  String get aiInteriorUploadImage => 'Upload Image';

  @override
  String get aiInteriorUploadFormats => 'PNG, JPG up to 10 MB';

  @override
  String get aiInteriorScanning => 'Scanning...';

  @override
  String get aiInteriorShopMarketplace => 'Shop in Marketplace';

  @override
  String get aiInteriorMaterialsEstimate => 'Materials Estimate';

  @override
  String get aiInteriorLaborEstimate => 'Labor Estimate';

  @override
  String get aiInteriorTotalEstimatedCost => 'Total Estimated Cost';

  @override
  String get shoppingNotesTitle => 'Shopping notes';

  @override
  String get shoppingNotesChart => 'Chart';

  @override
  String get shoppingNotesAllCategoriesSegment => 'All categories';

  @override
  String get shoppingNotesAddCategoryFirst => 'Add a category first';

  @override
  String get shoppingNotesNewCategory => 'New category';

  @override
  String get shoppingNotesRenameCategory => 'Rename category';

  @override
  String get shoppingNotesAddCategory => 'Add category';

  @override
  String get shoppingNotesCannotDelete => 'Cannot delete';

  @override
  String get shoppingNotesCategoryError => 'Category error';

  @override
  String get shoppingNotesExportTooltip => 'Export';

  @override
  String get shoppingNotesManageCategoriesTooltip => 'Manage categories';

  @override
  String get shoppingNotesOnlineBanner =>
      'Online: changes will try to sync (demo HTTP).';

  @override
  String get shoppingNotesOfflineBanner =>
      'Offline: data stays on this device.';

  @override
  String get shoppingNotesSearchHint => 'Filter by title, details, or category';

  @override
  String get shoppingNotesCouldNotLoad => 'Could not load notes.\n';

  @override
  String get shoppingNotesNoNotesYet => 'No notes yet. Tap + to add one.';

  @override
  String get shoppingNotesNoMatchFilter => 'No notes match the current filter.';

  @override
  String get shoppingNotesSyncStatusSynced => 'synced';

  @override
  String get shoppingNotesSyncStatusLocal => 'local';

  @override
  String get shoppingNotesNeedCategoryBody =>
      'Notes require a category. Open \"Manage categories\" and create at least one.';

  @override
  String get shoppingNotesNewNoteTitle => 'New note';

  @override
  String get shoppingNotesEditNoteTitle => 'Edit note';

  @override
  String get shoppingNotesFieldTitle => 'Title';

  @override
  String get shoppingNotesFieldDetails => 'Details';

  @override
  String get shoppingNotesFieldCategory => 'Category';

  @override
  String get shoppingNotesFieldAmount => 'Amount';

  @override
  String get shoppingNotesCategoriesSheetTitle => 'Categories';

  @override
  String get shoppingNotesCouldNotLoadCategories =>
      'Could not load categories.\n';

  @override
  String get shoppingNotesNoCategoriesYet => 'No categories. Tap + to add one.';

  @override
  String shoppingNotesCategoryRowMeta(int id, String date) {
    return 'id $id · updated $date';
  }

  @override
  String get shoppingNotesCannotDeleteBody =>
      'Remove or reassign notes that use this category first.\n';

  @override
  String get spendingByCategoryTitle => 'Spending by category';

  @override
  String get spendingAnalyticsLoadError => 'Failed to load chart data.\n';

  @override
  String get spendingAnalyticsEmptyPrompt =>
      'Add shopping notes with categories and amounts to see the chart.';

  @override
  String get spendingAnalyticsSubtitle =>
      'Totals from your local notes (works offline).';
}
