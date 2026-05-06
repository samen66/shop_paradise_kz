// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get appBrandTitle => 'Paradise';

  @override
  String get welcomeTaglineLine1 => 'Үйге арналған жиһаз бен интерьер';

  @override
  String get welcomeTaglineLine2 => 'Бір жерден таңдаңыз';

  @override
  String get welcomePrimaryCta => 'Каталогты ашу';

  @override
  String get welcomeSecondaryCta => 'Менің аккаунтым бар';

  @override
  String get loginTitle => 'Кіру';

  @override
  String get loginEmailLabel => 'Электрондық пошта';

  @override
  String get loginPasswordLabel => 'Құпия сөз';

  @override
  String get loginCloseAction => 'Жабу';

  @override
  String get loginContinueWithGoogle => 'Google арқылы жалғастыру';

  @override
  String loginGoogleSignInFailed(String message) {
    return 'Google арқылы кіру сәтсіз аяқталды: $message';
  }

  @override
  String get webHeaderCatalog => 'Каталог';

  @override
  String get webHeaderSearchPlaceholder => 'Сұрау енгізіңіз';

  @override
  String get webHeaderLinkPromotions => 'Акциялар';

  @override
  String get webHeaderLinkMagazine => 'Журнал';

  @override
  String get webHeaderLinkShowrooms => 'Шоурумдар';

  @override
  String customerCareWelcomeMessage(String name) {
    return 'Сәлем, $name! Customer Care қызметіне қош келдіңіз. Сізге көмектесуге қуаныштымыз. Бастамас бұрын мәселеңіз туралы толығырақ айтыңыз.';
  }

  @override
  String get customerCareHeaderChatBotTitle => 'Чат-бот';

  @override
  String get customerCareHeaderAgentName => 'Мэгги Ли';

  @override
  String get customerCareHeaderSubtitle => 'Тұтынушыларға қызмет';

  @override
  String get customerCareSheetWhatsYourIssue => 'Мәселеңіз қандай?';

  @override
  String get customerCareSheetSelectOrder =>
      'Тапсырыстарыңыздың біреуін таңдаңыз';

  @override
  String get customerCareNext => 'Әрі қарай';

  @override
  String get customerCareMessageHint => 'Хабарлама';

  @override
  String get customerCareConnecting => 'Операторға қосылуда';

  @override
  String get customerCareStandardDelivery => 'Қалыпты жеткізу';

  @override
  String customerCareItemsCount(int count) {
    return '$count тауар';
  }

  @override
  String get customerCareOrderSelect => 'Таңдау';

  @override
  String get customerCareOrderSelected => 'Таңдалды';

  @override
  String get customerCareRateTitle => 'Қызметті бағалаңыз';

  @override
  String get customerCareRateCommentHint => 'Пікіріңіз';

  @override
  String get customerCareRatingThanks => 'Пікіріңіз үшін рахмет.';

  @override
  String get customerCareSettingsRow => 'Тұтынушыларға қызмет';

  @override
  String get customerCareSnackbarAttach => 'Бұл демода тіркемелер жоқ.';

  @override
  String get customerCareSnackbarMenu => 'Бұл демода қосымша опциялар жоқ.';

  @override
  String get customerCareCategoryOrder => 'Тапсырыс мәселелері';

  @override
  String get customerCareCategoryItemQuality => 'Сапа';

  @override
  String get customerCareCategoryPayment => 'Төлем мәселелері';

  @override
  String get customerCareCategoryTechnical => 'Техникалық көмек';

  @override
  String get customerCareCategoryOther => 'Басқа';

  @override
  String get customerCareSubOrderNotReceived => 'Посылкамды алмадым';

  @override
  String get customerCareSubOrderCancel => 'Тапсырыстан бас тартқым келеді';

  @override
  String get customerCareSubOrderReturn => 'Тапсырысты қайтарғым келеді';

  @override
  String get customerCareSubOrderDamaged => 'Бума зақымдалған';

  @override
  String get customerCareSubOrderOther => 'Басқа';

  @override
  String get customerCareSubQualityDefective => 'Зат зақымдалған немесе сынған';

  @override
  String get customerCareSubQualityWrongItem => 'Қате зат жіберілді';

  @override
  String get customerCareSubQualityNotAsDescribed => 'Сипаттамаға сай емес';

  @override
  String get customerCareSubQualityPackaging => 'Нашар орау';

  @override
  String get customerCareSubQualityOther => 'Басқа';

  @override
  String get customerCareSubPaymentDouble => 'Екі рет төледім';

  @override
  String get customerCareSubPaymentRefund => 'Қайтару кешігуі';

  @override
  String get customerCareSubPaymentFailed => 'Төлем сәтсіз аяқталды';

  @override
  String get customerCareSubPaymentWrongAmount => 'Қате сома алынды';

  @override
  String get customerCareSubPaymentOther => 'Басқа';

  @override
  String get customerCareSubTechCrash => 'Қосымша құлады немесе тоқтап қалады';

  @override
  String get customerCareSubTechLogin => 'Кіре алмаймын';

  @override
  String get customerCareSubTechSlow => 'Беттер баяу жүктеледі';

  @override
  String get customerCareSubTechNotifications =>
      'Хабарландырулар жұмыс істемейді';

  @override
  String get customerCareSubTechOther => 'Басқа';

  @override
  String get customerCareSubOtherFeedback => 'Жалпы пікір';

  @override
  String get customerCareSubOtherComplaint => 'Қызметке шағым';

  @override
  String get customerCareSubOtherPartner => 'Серіктестік немесе B2B';

  @override
  String get customerCareSubOtherPress => 'БАҚ';

  @override
  String get customerCareSubOtherMisc => 'Басқа нәрсе';

  @override
  String get customerCareVoucherCollect => 'Жинау';

  @override
  String get customerCareVoucherSaved => 'Ұсыныс аккаунтыңызға сақталды.';

  @override
  String get createAccountTitle => 'Аккаунт құру';

  @override
  String get createAccountEmailHint => 'Электрондық пошта';

  @override
  String get createAccountPasswordHint => 'Құпия сөз';

  @override
  String get createAccountPhoneHint => 'Нөміріңіз';

  @override
  String get createAccountDone => 'Дайын';

  @override
  String get createAccountCancel => 'Болдырмау';

  @override
  String get createAccountEmailInvalid =>
      'Жарамды электрондық пошта енгізіңіз.';

  @override
  String get createAccountPasswordTooShort =>
      'Құпия сөз кемінде 8 таңбадан тұруы керек.';

  @override
  String get createAccountPhoneInvalid => 'Жарамды телефон нөмірін енгізіңіз.';

  @override
  String get createAccountSuccess =>
      'Аккаунт деректері қабылданды. Кіру кейінірек қосылады.';

  @override
  String get createAccountAvatarSemanticLabel => 'Профиль фотосын қосу';

  @override
  String get createAccountAvatarUnavailable =>
      'Бұл нұсқада фото жүктеу қолжетімді емес.';

  @override
  String get loginCreateAccountLink => 'Аккаунт құру';

  @override
  String get settingsThemeSection => 'Сыртқы түрі';

  @override
  String get themeModeSystem => 'Жүйе бойынша';

  @override
  String get themeModeLight => 'Жарық';

  @override
  String get themeModeDark => 'Қараңғы';

  @override
  String get settingsDailyReminderTitle => 'Күнделікті еске салу';

  @override
  String get settingsDailyReminderSubtitle =>
      'Күніне бір рет 20:00-де (құрылғы уақыты)';

  @override
  String get onboardingSkip => 'Өткізу';

  @override
  String get onboardingNext => 'Келесі';

  @override
  String get onboardingStart => 'Бастау';

  @override
  String get onboardingPage1Title => 'Сенімді таңдаңыз';

  @override
  String get onboardingPage1Body => 'Жиһаз бен декорды бір жерден табыңыз.';

  @override
  String get onboardingPage2Title => 'Шығындарды есептеңіз';

  @override
  String get onboardingPage2Body =>
      'Офлайн жазбалар — баға мен санат кез келген уақытта.';

  @override
  String get onboardingPage3Title => 'Деректер сізде';

  @override
  String get onboardingPage3Body =>
      'Жазбалар құрылғыда; бұлт қажет болса — кіріңіз.';

  @override
  String get exportShoppingNotesCsv => 'CSV экспорт';

  @override
  String get exportShoppingNotesPdf => 'PDF экспорт';

  @override
  String get exportShoppingNotesEmpty => 'Экспорттауға жазба жоқ.';

  @override
  String exportShoppingNotesFailed(String message) {
    return 'Экспорт сәтсіз: $message';
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
  String get settingsTitle => 'Параметрлер';

  @override
  String get settingsSectionPersonal => 'Жеке';

  @override
  String get settingsSectionShop => 'Дүкен';

  @override
  String get settingsSectionAccount => 'Аккаунт';

  @override
  String get settingsRowProfile => 'Профиль';

  @override
  String get settingsRowShippingAddress => 'Жеткізу мекенжайы';

  @override
  String get settingsRowPaymentMethods => 'Төлем тәсілдері';

  @override
  String get settingsRowShoppingNotes => 'Сатып алу жазбалары (офлайн)';

  @override
  String get settingsRowSpendingChart => 'Шығын графигі';

  @override
  String get settingsRowCountry => 'Ел';

  @override
  String get settingsRowCurrency => 'Валюта';

  @override
  String get settingsRowSizes => 'Өлшемдер';

  @override
  String get settingsRowTerms => 'Шарттар мен ережелер';

  @override
  String get settingsRowLanguage => 'Тіл';

  @override
  String get settingsRowLogout => 'Шығу';

  @override
  String settingsRowAbout(String appName) {
    return '$appName туралы';
  }

  @override
  String get settingsDeleteAccountAction => 'Аккаунтымды жою';

  @override
  String settingsVersionLabel(String version, String buildDate) {
    return 'Нұсқа $version · $buildDate';
  }

  @override
  String get settingsLogoutTitle => 'Шығу';

  @override
  String get settingsLogoutMessage => 'Аккаунттан шыққыңыз келе ме?';

  @override
  String get settingsDeleteAccountTitle => 'Аккаунтты жою керек пе?';

  @override
  String get settingsDeleteAccountMessage =>
      'Деректерді қалпына келтіре алмайсыз. Бұл тек демо нұсқа.';

  @override
  String get settingsDeleteAccountDemoMessage =>
      'Демо нұсқада аккаунтты жою қолжетімді емес';

  @override
  String settingsComingSoonMessage(String feature) {
    return '$feature — жақында қолжетімді';
  }

  @override
  String get commonCancel => 'Болдырмау';

  @override
  String get commonLogout => 'Шығу';

  @override
  String get commonDelete => 'Жою';

  @override
  String get languagePageTitle => 'Тіл';

  @override
  String get languageFollowSystem => 'Жүйеге сәйкес';

  @override
  String get languageEnglish => 'Ағылшын';

  @override
  String get languageKazakh => 'Қазақ';

  @override
  String get languageRussian => 'Орыс';

  @override
  String get appWindowTitle => 'Shop Paradise';

  @override
  String get commonOk => 'ОК';

  @override
  String get commonSave => 'Сақтау';

  @override
  String get commonRetry => 'Қайталау';

  @override
  String get commonSeeAll => 'Барлығын көру';

  @override
  String get homeJustForYouRetryLoadingMore => 'Көбірек жүктеуді қайталау';

  @override
  String get commonTryAgain => 'Қайталау';

  @override
  String get commonApply => 'Қолдану';

  @override
  String get commonDone => 'Дайын';

  @override
  String get commonChange => 'Өзгерту';

  @override
  String get commonClear => 'Тазалау';

  @override
  String get commonCloseTooltip => 'Жабу';

  @override
  String get commonSelectAll => 'Барлығын таңдау';

  @override
  String errorMessageWithDetails(String message) {
    return 'Қате: $message';
  }

  @override
  String get loginSubtitleWelcomeBack => 'Қайта көргеніме қуаныштымын!  🖤';

  @override
  String get loginForgotPassword => 'Құпия сөзді ұмыттыңыз ба?';

  @override
  String get loginChangeEmail => 'Поштаны өзгерту';

  @override
  String get loginPasswordResetSent =>
      'Құпия сөзді қалпына келтіру хаты жіберілді.';

  @override
  String get loginEnterEmail => 'Электрондық поштаны енгізіңіз';

  @override
  String get loginEnterPassword => 'Құпия сөзді енгізіңіз';

  @override
  String get loginEnterValidEmailFirst => 'Алдымен жарамды пошта енгізіңіз';

  @override
  String get shopHomeTitle => 'Дүкен';

  @override
  String get cartTitle => 'Себетім';

  @override
  String get cartFailedToLoad => 'Себетті жүктеу сәтсіз';

  @override
  String get cartRemovedSelected => 'Таңдалғандар жойылды';

  @override
  String get cartBrowseHomeSnackbar =>
      'Тауарларды қарау үшін Басты бет қойындысын ашыңыз.';

  @override
  String cartItemRemoved(String title) {
    return '$title жойылды';
  }

  @override
  String get cartTooltipDeleteSelected => 'Таңдалғанды жою';

  @override
  String get cartTooltipSelectItems => 'Тауарларды таңдау';

  @override
  String get cartCheckout => 'Төлемге өту';

  @override
  String get cartSubtotal => 'Аралық сома';

  @override
  String get cartDiscountRow => 'Жеңілдік';

  @override
  String get cartTax => 'Салық';

  @override
  String get cartFreeLabel => 'Тегін';

  @override
  String get cartTotalRow => 'Барлығы';

  @override
  String get cartStartShopping => 'Сатып алуды бастау';

  @override
  String get wishlistFailedToLoad => 'Таңдаулыларды жүктеу сәтсіз';

  @override
  String wishlistSavedCount(int count) {
    return '$count сақталған тауар';
  }

  @override
  String get wishlistTitle => 'Таңдаулылар';

  @override
  String wishlistItemRemoved(String title) {
    return '$title жойылды';
  }

  @override
  String wishlistItemAddedToCart(String title) {
    return '$title себетке қосылды';
  }

  @override
  String get wishlistRestoreDemo => 'Демо элементтерді қалпына келтіру';

  @override
  String get ordersFailedToLoad => 'Тапсырыстарды жүктеу сәтсіз';

  @override
  String ordersPlacedOn(String when) {
    return 'Орналастырылды $when';
  }

  @override
  String ordersSheetSummaryLine(int itemCount, String total) {
    return '$itemCount тауар · $total';
  }

  @override
  String get ordersSheetTrackingPlaceholder =>
      'Толық бақылау дүкен бэкенді қосқаннан кейін осында көрінеді.';

  @override
  String ordersCountHeader(int count) {
    return '$count тапсырыс';
  }

  @override
  String get ordersTitle => 'Тапсырыстарым';

  @override
  String get ordersRestoreDemo => 'Демо тапсырыстарды қалпына келтіру';

  @override
  String get orderStatusProcessing => 'Өңделуде';

  @override
  String get orderStatusShipped => 'Жіберілді';

  @override
  String get orderStatusDelivered => 'Жеткізілді';

  @override
  String get orderStatusCancelled => 'Болдырылды';

  @override
  String orderItemsCount(int count) {
    return '$count тауар';
  }

  @override
  String get homeMarketplaceTitle => 'Үй маркетплейсі';

  @override
  String get homeMarketSearchHint =>
      'Тауарларды, брендтерді, заттарды іздеу...';

  @override
  String get homeMarketSearchPlaceholderShort => 'Іздеу';

  @override
  String get homeMarketCategoryFiltersTooltip => 'Санат сүзгілері';

  @override
  String get homeAppBarAiDesignTooltip => 'AI дизайн';

  @override
  String get homeAppBarServiceHubTooltip => 'Қызмет орталығы';

  @override
  String get homeMarketCategoryAll => 'Барлығы';

  @override
  String get homeMarketCategoryGroceries => 'Азық-түлік';

  @override
  String get homeMarketCategoryHomeGoods => 'Үй тауарлары';

  @override
  String get homeMarketCategoryDecor => 'Декор';

  @override
  String get homeMarketProductFreshFruitBasket => 'Жаңа жеміс себеті';

  @override
  String get homeMarketProductKitchenStorageSet => 'Ас үй сақтау жиынтығы';

  @override
  String get homeMarketProductScentedCandleTrio => 'Хош иісті шамдар (3 дана)';

  @override
  String get homeMarketProductLaundryOrganizer => 'Кір жуу ұйымдастырушысы';

  @override
  String get homeMarketProductIndoorPlantKit => 'Бөлме өсімдігі жиынтығы';

  @override
  String get homeMarketProductOrganicDairyBundle => 'Органикалық сүт өнімдері';

  @override
  String get cartPromoCodeHint => 'Кодты енгізіңіз';

  @override
  String get productAddToCart => 'Себетке қосу';

  @override
  String get productAddToCartShort => 'Себетке қосу';

  @override
  String get productBuyNow => 'Қазір сатып алу';

  @override
  String get productViewAllReviews => 'Барлық пікірлер';

  @override
  String get productSectionVariations => 'Нұсқалар';

  @override
  String get productSectionSpecifications => 'Сипаттамалары';

  @override
  String get productOrigin => 'Шыққан жері';

  @override
  String get productDelivery => 'Жеткізу';

  @override
  String get productRatingReviews => 'Рейтинг және пікірлер';

  @override
  String get productMostPopular => 'Ең танымал';

  @override
  String get productYouMightLike => 'Сізге ұнауы мүмкін';

  @override
  String get productSizeGuideFallback => 'Өлшем нұсқаулығы';

  @override
  String get productNoReviewsYet => 'Әлі пікір жоқ.';

  @override
  String get productOriginFallbackEu => 'ЕО';

  @override
  String productSpecLine(String label, String value) {
    return '$label  $value';
  }

  @override
  String get categoryFilterAllCategoriesTitle => 'Барлық санаттар';

  @override
  String get categoryFilterSearchHint => 'Санаттарды іздеу';

  @override
  String get categoryFilterEmpty => 'Санат жоқ';

  @override
  String get categoryFilterClearAllFilters => 'Сүзгілерді тазалау';

  @override
  String get categoryFilterApplyFilters => 'Сүзгілерді қолдану';

  @override
  String get paymentPageTitle => 'Төлем';

  @override
  String get paymentShippingAddressCardTitle => 'Жеткізу мекенжайы';

  @override
  String get paymentContactInformationTitle => 'Байланыс ақпараты';

  @override
  String get paymentItemsSectionTitle => 'Тауарлар';

  @override
  String get paymentShippingOptionsTitle => 'Жеткізу опциялары';

  @override
  String get paymentShippingStandard => 'Қалыпты';

  @override
  String get paymentShippingStandardEta => '5–7 күн';

  @override
  String get paymentShippingFree => 'ТЕГІН';

  @override
  String get paymentShippingExpress => 'Жедел';

  @override
  String get paymentShippingExpressEta => '1–2 күн';

  @override
  String get paymentDeliverySampleNote =>
      '2020 жылғы 23 сәуірден кешіктірмей жеткізу';

  @override
  String get paymentMethodSectionTitle => 'Төлем тәсілі';

  @override
  String get paymentAddVoucher => 'Ваучер қосу';

  @override
  String get paymentProcessingTitle => 'Төлем орындалуда';

  @override
  String get paymentProcessingSubtitle => 'Бірнеше секунд күтіңіз';

  @override
  String get paymentErrorTitle => 'Төлемді аяқтау мүмкін болмады';

  @override
  String get paymentErrorBody => 'Төлем тәсілін өзгертіп қайта көріңіз';

  @override
  String get paymentTryAgain => 'Қайталау';

  @override
  String get paymentChangeMethod => 'Өзгерту';

  @override
  String get paymentSuccessTitle => 'Дайын!';

  @override
  String get paymentSuccessBody => 'Картаңыздан сома алынды';

  @override
  String get paymentTrackOrder => 'Тапсырысты бақылау';

  @override
  String paymentPercentDiscount(int percent) {
    return '$percent% жеңілдік';
  }

  @override
  String paymentNamedDiscount(String name) {
    return '$name жеңілдік';
  }

  @override
  String get paymentTotalLabel => 'Барлығы';

  @override
  String get paymentPayButton => 'Төлеу';

  @override
  String get paymentCountryLabel => 'Ел';

  @override
  String get paymentSaveChanges => 'Өзгерістерді сақтау';

  @override
  String get paymentAddressLineLabel => 'Мекенжай';

  @override
  String get paymentTownCityLabel => 'Қала / ауыл';

  @override
  String get paymentPostcodeLabel => 'Пошта индексі';

  @override
  String get paymentPhoneLabel => 'Телефон';

  @override
  String get paymentEmailLabelField => 'Эл. пошта';

  @override
  String get paymentMethodsSubtitle =>
      'Осы тапсырыс үшін карта таңдаңыз. Жаңа карта қосуға немесе сақталғанын жаңартуға болады.';

  @override
  String get paymentEditTooltip => 'Өңдеу';

  @override
  String get paymentAddPaymentMethod => 'Төлем тәсілін қосу';

  @override
  String get paymentUseThisCard => 'Осы картаны қолдану';

  @override
  String get paymentEditCardTitle => 'Картаны өңдеу';

  @override
  String get paymentAddCardTitle => 'Карта қосу';

  @override
  String get paymentCardIntroEdit =>
      'Атын немесе мерзімін кез келген уақытта өзгертуге болады. Тек картаны ауыстырғыңыз келсе толық нөмірді енгізіңіз.';

  @override
  String get paymentCardIntroAdd =>
      'Карта деректерін енгізіңіз. Бұл демо — нақты төлем жоқ.';

  @override
  String paymentCardCurrentMasked(String masked) {
    return 'Ағымдағы: $masked';
  }

  @override
  String get paymentCardNumberLabel => 'Карта нөмірі';

  @override
  String get paymentCardNumberHintKeep =>
      'Ағымдағыны сақтау үшін бос қалдырыңыз';

  @override
  String get paymentCardNumberError => 'Жарамды карта нөмірін енгізіңіз';

  @override
  String get paymentCardHolderLabel => 'Карта иесінің аты';

  @override
  String get paymentCardHolderError => 'Карта иесінің атын енгізіңіз';

  @override
  String get paymentCardExpiryLabel => 'Мерзімі (АА/ЖЖ)';

  @override
  String get paymentCardExpiryFormatError => 'АА/ЖЖ пішімін қолданыңыз';

  @override
  String get paymentCardExpiryMonthError => 'Жарамсыз ай';

  @override
  String get paymentCardCvvLabel => 'CVV';

  @override
  String get paymentCardCvvError => 'CVV енгізіңіз';

  @override
  String get paymentBrandVisa => 'Visa';

  @override
  String get paymentBrandMastercard => 'Mastercard';

  @override
  String get paymentVouchersActiveTitle => 'Белсенді ваучерлер';

  @override
  String get paymentVoucherLabel => 'Ваучер';

  @override
  String get paymentVoucherValid => 'Жарамды';

  @override
  String get serviceHubTitle => 'Қызмет орталығы';

  @override
  String get serviceHubPostSuccess => 'Жоба сәтті жарияланды.';

  @override
  String get serviceHubPostProject => 'Жоба жариялау';

  @override
  String get serviceHubBidApply => 'Ұсыну / Қолдану';

  @override
  String get serviceHubTabPostJob => 'Жұмыс жариялау';

  @override
  String get serviceHubTabBrowseRequests => 'Сұраныстар';

  @override
  String get serviceHubFormHeading => 'Жаңа жоба';

  @override
  String get serviceHubFormSubheading =>
      'Талаптарыңызды сипаттаңыз да, мамандардан ұсыныс алыңыз.';

  @override
  String get serviceHubFieldProjectTitle => 'Жоба атауы';

  @override
  String get serviceHubFieldProjectTitleHint => 'Ас үй сантехникасын жөндеу';

  @override
  String get serviceHubFieldProjectTitleError => 'Жоба атауын енгізіңіз';

  @override
  String get serviceHubFieldDescription => 'Толық сипаттама';

  @override
  String get serviceHubFieldDescriptionHint =>
      'Көлемін, уақытын және ерекше талаптарды түсіндіріңіз...';

  @override
  String get serviceHubFieldDescriptionError => 'Кемінде 12 таңба енгізіңіз';

  @override
  String get serviceHubSampleJob1Customer => 'Лера';

  @override
  String get serviceHubSampleJob1Title => 'Пәтерді жөндеу';

  @override
  String get serviceHubSampleJob1Snippet =>
      'Бояу, еден жаңарту және ас үй жиһазын жаңарту керек.';

  @override
  String get serviceHubSampleJob2Customer => 'Асқар';

  @override
  String get serviceHubSampleJob2Title => 'Терең үй тазалауы';

  @override
  String get serviceHubSampleJob2Snippet =>
      '2 бөлмелі пәтерден көшу тазалауы осы демалыс.';

  @override
  String get serviceHubSampleJob3Customer => 'Дана';

  @override
  String get serviceHubSampleJob3Title => 'Жиһаз жинау';

  @override
  String get serviceHubSampleJob3Snippet =>
      'Шкаф, үстел және екі тумбаны жинау.';

  @override
  String get profilePayNow => 'Қазір төлеу';

  @override
  String get profileTrack => 'Бақылау';

  @override
  String get profileReview => 'Пікір';

  @override
  String get profileOrderHistory => 'Тапсырыс тарихы';

  @override
  String get profileHistoryTitle => 'Тарих';

  @override
  String get profileTabToPay => 'Төлеуге';

  @override
  String get profileTabToReceive => 'Қабылдауға';

  @override
  String get profileTabToReview => 'Пікірге';

  @override
  String get profileMyOrdersSubtitle => 'Тапсырыстарым';

  @override
  String get profileNothingHereYet => 'Әзірге бос';

  @override
  String get profilePaymentFlowSoon => 'Төлем ағыны жақында';

  @override
  String get profileFailedToLoad => 'Профильді жүктеу сәтсіз';

  @override
  String profileGreeting(String name) {
    return 'Сәлем, $name!';
  }

  @override
  String get profileRecentlyViewed => 'Жуырда көрілген';

  @override
  String get profileMyOrdersSection => 'Тапсырыстарым';

  @override
  String get profileStoriesSection => 'Оқиғалар';

  @override
  String get profileMyActivity => 'Менің белсенділігім';

  @override
  String get profileScannerSoon => 'Сканер жақында';

  @override
  String get profileFiltersSoon => 'Сүзгілер жақында';

  @override
  String get orderTrackingPageSubtitle => 'Тапсырысты бақылау';

  @override
  String get orderTrackingNumberLabel => 'Бақылау нөмірі';

  @override
  String get orderTrackingCopiedNumber => 'Бақылау нөмірі көшірілді';

  @override
  String get vouchersPageTitle => 'Ваучерлер';

  @override
  String get vouchersTabActiveRewards => 'Белсенді сыйлықтар';

  @override
  String get vouchersTabProgress => 'Прогресс';

  @override
  String get settingsYourProfile => 'Профиліңіз';

  @override
  String get settingsChooseCountryPlaceholder => 'Еліңізді таңдаңыз';

  @override
  String get validationFieldRequired => 'Міндетті';

  @override
  String get settingsProfileDisplayNameEmpty =>
      'Көрсетілетін аты бос болмауы керек.';

  @override
  String settingsProfileEmailConfirmSent(String email) {
    return 'Растау сілтемесін $email адресіне жібердік. Электрондық поштаны өзгерту үшін оны ашыңыз.';
  }

  @override
  String get settingsProfileNameLabel => 'Аты';

  @override
  String get profileStatOrdered => 'Тапсырыс берілді';

  @override
  String get profileStatReceived => 'Қабылданды';

  @override
  String get profileStatToReceive => 'Күтуде';

  @override
  String get profileChatNow => 'Чатқа өту';

  @override
  String get profileSayIt => 'Айтыңыз!';

  @override
  String get profileReviewThankYou => 'Пікіріңіз үшін рахмет';

  @override
  String get profileNoItemsToReview => 'Пікір қалдыратын тауар жоқ';

  @override
  String get profileReviewWhichItem => 'Қай тауарға пікір қалдырғыңыз келеді?';

  @override
  String get profileDeliveryNotSuccessful => 'Жеткізу сәтсіз аяқталды';

  @override
  String get profileDeliveryWhatToDo => 'Не істеу керек?';

  @override
  String get profileDeliveryFailureBody =>
      'Уайымдамаңыз, біз жақында сізбен байланысып, ыңғайлы жеткізу уақытын келісеміз. Сондай-ақ +00 000 000 000 нөміріне хабарласа немесе тұтынушыларға қызмет чатына жазыла аласыз.';

  @override
  String get voucherCollected => 'Жиналды';

  @override
  String get validationChooseCountry => 'Елді таңдаңыз';

  @override
  String get settingsSaveChanges => 'Өзгерістерді сақтау';

  @override
  String get profilePhotoEditorSoon => 'Фото редакторы жақында';

  @override
  String get aiInteriorTitle => 'AI дизайн және баға';

  @override
  String get aiInteriorRoomInput => 'Бөлме деректері';

  @override
  String get aiInteriorRecommendedFurniture => 'Ұсынылған жиһаз';

  @override
  String get aiInteriorSummaryReport => 'Қорытынды есеп';

  @override
  String get aiInteriorStopScanning => 'Сканерлеуді тоқтату';

  @override
  String get aiInteriorStartAiScan => 'AI сканерін бастау';

  @override
  String get aiInteriorUploadImage => 'Сурет жүктеу';

  @override
  String get aiInteriorUploadFormats => 'PNG, JPG, 10 МБ дейін';

  @override
  String get aiInteriorScanning => 'Сканерленуде...';

  @override
  String get aiInteriorShopMarketplace => 'Дүкенде сатып алу';

  @override
  String get aiInteriorMaterialsEstimate => 'Материал бағасы';

  @override
  String get aiInteriorLaborEstimate => 'Еңбек бағасы';

  @override
  String get aiInteriorTotalEstimatedCost => 'Болжамды жалпы құн';

  @override
  String get shoppingNotesTitle => 'Сатып алу жазбалары';

  @override
  String get shoppingNotesChart => 'Диаграмма';

  @override
  String get shoppingNotesAllCategoriesSegment => 'Барлық санаттар';

  @override
  String get shoppingNotesAddCategoryFirst => 'Алдымен санат қосыңыз';

  @override
  String get shoppingNotesNewCategory => 'Жаңа санат';

  @override
  String get shoppingNotesRenameCategory => 'Санатты қайта атау';

  @override
  String get shoppingNotesAddCategory => 'Санат қосу';

  @override
  String get shoppingNotesCannotDelete => 'Жою мүмкін емес';

  @override
  String get shoppingNotesCategoryError => 'Санат қатесі';

  @override
  String get shoppingNotesExportTooltip => 'Экспорт';

  @override
  String get shoppingNotesManageCategoriesTooltip => 'Санаттарды басқару';

  @override
  String get shoppingNotesOnlineBanner =>
      'Онлайн: өзгерістер синхрондалуға тырысады (демо HTTP).';

  @override
  String get shoppingNotesOfflineBanner =>
      'Офлайн: деректер осы құрылғыда қалады.';

  @override
  String get shoppingNotesSearchHint =>
      'Тақырып, мәлімет немесе санат бойынша сүзу';

  @override
  String get shoppingNotesCouldNotLoad => 'Жазбалар жүктелмеді.\n';

  @override
  String get shoppingNotesNoNotesYet => 'Әзірге жазба жоқ. + басып қосыңыз.';

  @override
  String get shoppingNotesNoMatchFilter => 'Ағымдағы сүзгіге сәйкес жазба жоқ.';

  @override
  String get shoppingNotesSyncStatusSynced => 'синхрондалған';

  @override
  String get shoppingNotesSyncStatusLocal => 'жергілікті';

  @override
  String get shoppingNotesNeedCategoryBody =>
      'Жазбалар үшін санат керек. «Санаттарды басқару» бөлімін ашып, кемінде бір санат жасаңыз.';

  @override
  String get shoppingNotesNewNoteTitle => 'Жаңа жазба';

  @override
  String get shoppingNotesEditNoteTitle => 'Жазбаны өңдеу';

  @override
  String get shoppingNotesFieldTitle => 'Тақырып';

  @override
  String get shoppingNotesFieldDetails => 'Мәліметтер';

  @override
  String get shoppingNotesFieldCategory => 'Санат';

  @override
  String get shoppingNotesFieldAmount => 'Сома';

  @override
  String get shoppingNotesCategoriesSheetTitle => 'Санаттар';

  @override
  String get shoppingNotesCouldNotLoadCategories => 'Санаттар жүктелмеді.\n';

  @override
  String get shoppingNotesNoCategoriesYet => 'Санат жоқ. + басып қосыңыз.';

  @override
  String shoppingNotesCategoryRowMeta(int id, String date) {
    return 'id $id · жаңартылды $date';
  }

  @override
  String get shoppingNotesCannotDeleteBody =>
      'Алдымен осы санатты пайдаланатын жазбаларды жойыңыз немесе басқа санатқа ауырыңыз.\n';

  @override
  String get spendingByCategoryTitle => 'Санат бойынша шығын';

  @override
  String get spendingAnalyticsLoadError => 'Диаграмма деректері жүктелмеді.\n';

  @override
  String get spendingAnalyticsEmptyPrompt =>
      'Диаграмманы көру үшін санат пен сомасы бар сатып алу жазбаларын қосыңыз.';

  @override
  String get spendingAnalyticsSubtitle =>
      'Жергілікті жазбалардағы сомалар (офлайн жұмыс істейді).';
}
