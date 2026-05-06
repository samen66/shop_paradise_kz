// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appBrandTitle => 'Paradise';

  @override
  String get welcomeTaglineLine1 => 'Мебель и интерьер для дома';

  @override
  String get welcomeTaglineLine2 =>
      'Гостиная, спальня, кухня — всё в одном месте';

  @override
  String get welcomePrimaryCta => 'Смотреть каталог';

  @override
  String get welcomeSecondaryCta => 'У меня уже есть аккаунт';

  @override
  String get loginTitle => 'Вход';

  @override
  String get loginEmailLabel => 'Эл. почта';

  @override
  String get loginPasswordLabel => 'Пароль';

  @override
  String get loginCloseAction => 'Закрыть';

  @override
  String get loginContinueWithGoogle => 'Продолжить с Google';

  @override
  String loginGoogleSignInFailed(String message) {
    return 'Вход через Google не удался: $message';
  }

  @override
  String get webHeaderCatalog => 'Каталог';

  @override
  String get webHeaderSearchPlaceholder => 'Введите запрос';

  @override
  String get webHeaderLinkPromotions => 'Акции';

  @override
  String get webHeaderLinkMagazine => 'Журнал';

  @override
  String get webHeaderLinkShowrooms => 'Шоурумы';

  @override
  String customerCareWelcomeMessage(String name) {
    return 'Здравствуйте, $name! Добро пожаловать в службу поддержки. Мы рады помочь. Расскажите подробнее о проблеме, прежде чем мы начнём.';
  }

  @override
  String get customerCareHeaderChatBotTitle => 'Чат-бот';

  @override
  String get customerCareHeaderAgentName => 'Мэгги Ли';

  @override
  String get customerCareHeaderSubtitle => 'Служба поддержки';

  @override
  String get customerCareSheetWhatsYourIssue => 'В чём проблема?';

  @override
  String get customerCareSheetSelectOrder => 'Выберите один из заказов';

  @override
  String get customerCareNext => 'Далее';

  @override
  String get customerCareMessageHint => 'Сообщение';

  @override
  String get customerCareConnecting => 'Соединяем с оператором';

  @override
  String get customerCareStandardDelivery => 'Стандартная доставка';

  @override
  String customerCareItemsCount(int count) {
    return '$count товар(ов)';
  }

  @override
  String get customerCareOrderSelect => 'Выбрать';

  @override
  String get customerCareOrderSelected => 'Выбрано';

  @override
  String get customerCareRateTitle => 'Оцените сервис';

  @override
  String get customerCareRateCommentHint => 'Ваш комментарий';

  @override
  String get customerCareRatingThanks => 'Спасибо за отзыв.';

  @override
  String get customerCareSettingsRow => 'Поддержка';

  @override
  String get customerCareSnackbarAttach => 'В демо вложения недоступны.';

  @override
  String get customerCareSnackbarMenu =>
      'В демо дополнительные опции недоступны.';

  @override
  String get customerCareCategoryOrder => 'Проблемы с заказом';

  @override
  String get customerCareCategoryItemQuality => 'Качество товара';

  @override
  String get customerCareCategoryPayment => 'Проблемы с оплатой';

  @override
  String get customerCareCategoryTechnical => 'Техническая помощь';

  @override
  String get customerCareCategoryOther => 'Другое';

  @override
  String get customerCareSubOrderNotReceived => 'Не получил(а) посылку';

  @override
  String get customerCareSubOrderCancel => 'Хочу отменить заказ';

  @override
  String get customerCareSubOrderReturn => 'Хочу вернуть заказ';

  @override
  String get customerCareSubOrderDamaged => 'Посылка повреждена';

  @override
  String get customerCareSubOrderOther => 'Другое';

  @override
  String get customerCareSubQualityDefective => 'Товар бракованный или сломан';

  @override
  String get customerCareSubQualityWrongItem => 'Прислали не тот товар';

  @override
  String get customerCareSubQualityNotAsDescribed =>
      'Не соответствует описанию';

  @override
  String get customerCareSubQualityPackaging => 'Плохая упаковка';

  @override
  String get customerCareSubQualityOther => 'Другое';

  @override
  String get customerCareSubPaymentDouble => 'Списали дважды';

  @override
  String get customerCareSubPaymentRefund => 'Задержка возврата';

  @override
  String get customerCareSubPaymentFailed => 'Оплата не прошла';

  @override
  String get customerCareSubPaymentWrongAmount => 'Неверная сумма списания';

  @override
  String get customerCareSubPaymentOther => 'Другое';

  @override
  String get customerCareSubTechCrash => 'Приложение вылетает или зависает';

  @override
  String get customerCareSubTechLogin => 'Не получается войти';

  @override
  String get customerCareSubTechSlow => 'Страницы грузятся медленно';

  @override
  String get customerCareSubTechNotifications => 'Не работают уведомления';

  @override
  String get customerCareSubTechOther => 'Другое';

  @override
  String get customerCareSubOtherFeedback => 'Общий отзыв';

  @override
  String get customerCareSubOtherComplaint => 'Жалоба на сервис';

  @override
  String get customerCareSubOtherPartner => 'Партнёрство или B2B';

  @override
  String get customerCareSubOtherPress => 'Пресса и СМИ';

  @override
  String get customerCareSubOtherMisc => 'Другое';

  @override
  String get customerCareVoucherCollect => 'Получить';

  @override
  String get customerCareVoucherSaved => 'Предложение сохранено в аккаунте.';

  @override
  String get createAccountTitle => 'Создать аккаунт';

  @override
  String get createAccountEmailHint => 'Эл. почта';

  @override
  String get createAccountPasswordHint => 'Пароль';

  @override
  String get createAccountPhoneHint => 'Ваш номер';

  @override
  String get createAccountDone => 'Готово';

  @override
  String get createAccountCancel => 'Отмена';

  @override
  String get createAccountEmailInvalid => 'Введите корректный адрес эл. почты.';

  @override
  String get createAccountPasswordTooShort =>
      'Пароль должен быть не короче 8 символов.';

  @override
  String get createAccountPhoneInvalid => 'Введите корректный номер телефона.';

  @override
  String get createAccountSuccess =>
      'Данные аккаунта приняты. Вход будет подключён позже.';

  @override
  String get createAccountAvatarSemanticLabel => 'Добавить фото профиля';

  @override
  String get createAccountAvatarUnavailable =>
      'Загрузка фото недоступна в этой сборке.';

  @override
  String get loginCreateAccountLink => 'Создать аккаунт';

  @override
  String get settingsThemeSection => 'Оформление';

  @override
  String get themeModeSystem => 'Как в системе';

  @override
  String get themeModeLight => 'Светлая';

  @override
  String get themeModeDark => 'Тёмная';

  @override
  String get settingsDailyReminderTitle => 'Ежедневное напоминание о заметках';

  @override
  String get settingsDailyReminderSubtitle =>
      'Раз в день в 20:00 (время устройства)';

  @override
  String get onboardingSkip => 'Пропустить';

  @override
  String get onboardingNext => 'Далее';

  @override
  String get onboardingStart => 'Начать';

  @override
  String get onboardingPage1Title => 'Выбирайте спокойно';

  @override
  String get onboardingPage1Body =>
      'Мебель и декор в одном месте — для вашего дома.';

  @override
  String get onboardingPage2Title => 'Учитывайте траты';

  @override
  String get onboardingPage2Body =>
      'Офлайн-заметки о ценах и категориях — в любое время.';

  @override
  String get onboardingPage3Title => 'Данные у вас';

  @override
  String get onboardingPage3Body =>
      'Заметки на устройстве; вход — когда нужны облачные функции.';

  @override
  String get exportShoppingNotesCsv => 'Экспорт CSV';

  @override
  String get exportShoppingNotesPdf => 'Экспорт PDF';

  @override
  String get exportShoppingNotesEmpty => 'Нет заметок для экспорта.';

  @override
  String exportShoppingNotesFailed(String message) {
    return 'Экспорт не удался: $message';
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
  String get settingsTitle => 'Настройки';

  @override
  String get settingsSectionPersonal => 'Личное';

  @override
  String get settingsSectionShop => 'Магазин';

  @override
  String get settingsSectionAccount => 'Аккаунт';

  @override
  String get settingsRowProfile => 'Профиль';

  @override
  String get settingsRowShippingAddress => 'Адрес доставки';

  @override
  String get settingsRowPaymentMethods => 'Способы оплаты';

  @override
  String get settingsRowShoppingNotes => 'Заметки покупок (офлайн)';

  @override
  String get settingsRowSpendingChart => 'График расходов';

  @override
  String get settingsRowCountry => 'Страна';

  @override
  String get settingsRowCurrency => 'Валюта';

  @override
  String get settingsRowSizes => 'Размеры';

  @override
  String get settingsRowTerms => 'Условия использования';

  @override
  String get settingsRowLanguage => 'Язык';

  @override
  String get settingsRowLogout => 'Выйти';

  @override
  String settingsRowAbout(String appName) {
    return 'О приложении $appName';
  }

  @override
  String get settingsDeleteAccountAction => 'Удалить мой аккаунт';

  @override
  String settingsVersionLabel(String version, String buildDate) {
    return 'Версия $version · $buildDate';
  }

  @override
  String get settingsLogoutTitle => 'Выйти';

  @override
  String get settingsLogoutMessage => 'Выйти из аккаунта?';

  @override
  String get settingsDeleteAccountTitle => 'Удалить аккаунт?';

  @override
  String get settingsDeleteAccountMessage =>
      'Вы не сможете восстановить данные. Это только демо.';

  @override
  String get settingsDeleteAccountDemoMessage =>
      'Удаление аккаунта недоступно в демо';

  @override
  String settingsComingSoonMessage(String feature) {
    return '$feature — скоро';
  }

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonLogout => 'Выйти';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get languagePageTitle => 'Язык';

  @override
  String get languageFollowSystem => 'Как в системе';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get languageKazakh => 'Казахский';

  @override
  String get languageRussian => 'Русский';

  @override
  String get appWindowTitle => 'Shop Paradise';

  @override
  String get commonOk => 'ОК';

  @override
  String get commonSave => 'Сохранить';

  @override
  String get commonRetry => 'Повторить';

  @override
  String get commonSeeAll => 'Смотреть все';

  @override
  String get homeJustForYouRetryLoadingMore => 'Повторить загрузку';

  @override
  String get commonTryAgain => 'Попробовать снова';

  @override
  String get commonApply => 'Применить';

  @override
  String get commonDone => 'Готово';

  @override
  String get commonChange => 'Изменить';

  @override
  String get commonClear => 'Очистить';

  @override
  String get commonCloseTooltip => 'Закрыть';

  @override
  String get commonSelectAll => 'Выбрать всё';

  @override
  String errorMessageWithDetails(String message) {
    return 'Ошибка: $message';
  }

  @override
  String get loginSubtitleWelcomeBack => 'Рады снова вас видеть!  🖤';

  @override
  String get loginForgotPassword => 'Забыли пароль?';

  @override
  String get loginChangeEmail => 'Сменить email';

  @override
  String get loginPasswordResetSent => 'Письмо для сброса пароля отправлено.';

  @override
  String get loginEnterEmail => 'Введите email';

  @override
  String get loginEnterPassword => 'Введите пароль';

  @override
  String get loginEnterValidEmailFirst => 'Сначала введите корректный email';

  @override
  String get shopHomeTitle => 'Магазин';

  @override
  String get cartTitle => 'Корзина';

  @override
  String get cartFailedToLoad => 'Не удалось загрузить корзину';

  @override
  String get cartRemovedSelected => 'Выбранные позиции удалены';

  @override
  String get cartBrowseHomeSnackbar =>
      'Откройте вкладку «Главная», чтобы смотреть товары.';

  @override
  String cartItemRemoved(String title) {
    return '$title удалено';
  }

  @override
  String get cartTooltipDeleteSelected => 'Удалить выбранное';

  @override
  String get cartTooltipSelectItems => 'Выбрать позиции';

  @override
  String get cartCheckout => 'Оформить';

  @override
  String get cartSubtotal => 'Подытог';

  @override
  String get cartDiscountRow => 'Скидка';

  @override
  String get cartTax => 'Налог';

  @override
  String get cartFreeLabel => 'Бесплатно';

  @override
  String get cartTotalRow => 'Итого';

  @override
  String get cartStartShopping => 'Начать покупки';

  @override
  String get wishlistFailedToLoad => 'Не удалось загрузить избранное';

  @override
  String wishlistSavedCount(int count) {
    return '$count сохранённых товар(ов)';
  }

  @override
  String get wishlistTitle => 'Избранное';

  @override
  String wishlistItemRemoved(String title) {
    return '$title удалено';
  }

  @override
  String wishlistItemAddedToCart(String title) {
    return '$title добавлено в корзину';
  }

  @override
  String get wishlistRestoreDemo => 'Восстановить демо-список';

  @override
  String get ordersFailedToLoad => 'Не удалось загрузить заказы';

  @override
  String ordersPlacedOn(String when) {
    return 'Оформлен $when';
  }

  @override
  String ordersSheetSummaryLine(int itemCount, String total) {
    return '$itemCount товар(ов) · $total';
  }

  @override
  String get ordersSheetTrackingPlaceholder =>
      'Полное отслеживание заказа появится здесь после подключения к бэкенду магазина.';

  @override
  String ordersCountHeader(int count) {
    return '$count заказ(ов)';
  }

  @override
  String get ordersTitle => 'Мои заказы';

  @override
  String get ordersRestoreDemo => 'Восстановить демо-заказы';

  @override
  String get orderStatusProcessing => 'В обработке';

  @override
  String get orderStatusShipped => 'Отправлен';

  @override
  String get orderStatusDelivered => 'Доставлен';

  @override
  String get orderStatusCancelled => 'Отменён';

  @override
  String orderItemsCount(int count) {
    return '$count товар(ов)';
  }

  @override
  String get homeMarketplaceTitle => 'Домашний маркетплейс';

  @override
  String get homeMarketSearchHint => 'Поиск товаров, брендов, расходников...';

  @override
  String get homeMarketSearchPlaceholderShort => 'Поиск';

  @override
  String get homeMarketCategoryFiltersTooltip => 'Фильтры категорий';

  @override
  String get homeAppBarAiDesignTooltip => 'AI-дизайн';

  @override
  String get homeAppBarServiceHubTooltip => 'Сервис-хаб';

  @override
  String get homeMarketCategoryAll => 'Все';

  @override
  String get homeMarketCategoryGroceries => 'Продукты';

  @override
  String get homeMarketCategoryHomeGoods => 'Товары для дома';

  @override
  String get homeMarketCategoryDecor => 'Декор';

  @override
  String get homeMarketProductFreshFruitBasket => 'Корзина свежих фруктов';

  @override
  String get homeMarketProductKitchenStorageSet => 'Набор ёмкостей для кухни';

  @override
  String get homeMarketProductScentedCandleTrio => 'Набор ароматических свечей';

  @override
  String get homeMarketProductLaundryOrganizer => 'Органайзер для белья';

  @override
  String get homeMarketProductIndoorPlantKit => 'Набор для комнатных растений';

  @override
  String get homeMarketProductOrganicDairyBundle =>
      'Набор органических молочных продуктов';

  @override
  String get cartPromoCodeHint => 'Введите код';

  @override
  String get productAddToCart => 'В корзину';

  @override
  String get productAddToCartShort => 'В корзину';

  @override
  String get productBuyNow => 'Купить сейчас';

  @override
  String get productViewAllReviews => 'Все отзывы';

  @override
  String get productSectionVariations => 'Варианты';

  @override
  String get productSectionSpecifications => 'Характеристики';

  @override
  String get productOrigin => 'Происхождение';

  @override
  String get productDelivery => 'Доставка';

  @override
  String get productRatingReviews => 'Рейтинг и отзывы';

  @override
  String get productMostPopular => 'Популярное';

  @override
  String get productYouMightLike => 'Вам может понравиться';

  @override
  String get productSizeGuideFallback => 'Таблица размеров';

  @override
  String get productNoReviewsYet => 'Пока нет отзывов.';

  @override
  String get productOriginFallbackEu => 'ЕС';

  @override
  String productSpecLine(String label, String value) {
    return '$label  $value';
  }

  @override
  String get categoryFilterAllCategoriesTitle => 'Все категории';

  @override
  String get categoryFilterSearchHint => 'Поиск категорий';

  @override
  String get categoryFilterEmpty => 'Нет категорий';

  @override
  String get categoryFilterClearAllFilters => 'Сбросить фильтры';

  @override
  String get categoryFilterApplyFilters => 'Применить фильтры';

  @override
  String get paymentPageTitle => 'Оплата';

  @override
  String get paymentShippingAddressCardTitle => 'Адрес доставки';

  @override
  String get paymentContactInformationTitle => 'Контактные данные';

  @override
  String get paymentItemsSectionTitle => 'Товары';

  @override
  String get paymentShippingOptionsTitle => 'Варианты доставки';

  @override
  String get paymentShippingStandard => 'Стандарт';

  @override
  String get paymentShippingStandardEta => '5–7 дней';

  @override
  String get paymentShippingFree => 'БЕСПЛАТНО';

  @override
  String get paymentShippingExpress => 'Экспресс';

  @override
  String get paymentShippingExpressEta => '1–2 дня';

  @override
  String get paymentDeliverySampleNote =>
      'Доставка не позже четверга, 23 апреля 2020';

  @override
  String get paymentMethodSectionTitle => 'Способ оплаты';

  @override
  String get paymentAddVoucher => 'Добавить ваучер';

  @override
  String get paymentProcessingTitle => 'Обработка платежа';

  @override
  String get paymentProcessingSubtitle => 'Подождите несколько секунд';

  @override
  String get paymentErrorTitle => 'Не удалось выполнить оплату';

  @override
  String get paymentErrorBody => 'Смените способ оплаты или попробуйте снова';

  @override
  String get paymentTryAgain => 'Повторить';

  @override
  String get paymentChangeMethod => 'Сменить';

  @override
  String get paymentSuccessTitle => 'Готово!';

  @override
  String get paymentSuccessBody => 'Оплата по карте прошла успешно';

  @override
  String get paymentTrackOrder => 'Отследить заказ';

  @override
  String paymentPercentDiscount(int percent) {
    return 'Скидка $percent%';
  }

  @override
  String paymentNamedDiscount(String name) {
    return 'Скидка: $name';
  }

  @override
  String get paymentTotalLabel => 'Итого';

  @override
  String get paymentPayButton => 'Оплатить';

  @override
  String get paymentCountryLabel => 'Страна';

  @override
  String get paymentSaveChanges => 'Сохранить изменения';

  @override
  String get paymentAddressLineLabel => 'Адрес';

  @override
  String get paymentTownCityLabel => 'Город';

  @override
  String get paymentPostcodeLabel => 'Индекс';

  @override
  String get paymentPhoneLabel => 'Телефон';

  @override
  String get paymentEmailLabelField => 'Email';

  @override
  String get paymentMethodsSubtitle =>
      'Выберите карту для этого заказа. Можно добавить новую или изменить сохранённую.';

  @override
  String get paymentEditTooltip => 'Изменить';

  @override
  String get paymentAddPaymentMethod => 'Добавить способ оплаты';

  @override
  String get paymentUseThisCard => 'Использовать эту карту';

  @override
  String get paymentEditCardTitle => 'Изменить карту';

  @override
  String get paymentAddCardTitle => 'Добавить карту';

  @override
  String get paymentCardIntroEdit =>
      'Имя и срок можно менять в любое время. Полный номер карты вводите только если хотите заменить карту.';

  @override
  String get paymentCardIntroAdd =>
      'Введите данные карты. Это демо — списаний не будет.';

  @override
  String paymentCardCurrentMasked(String masked) {
    return 'Текущая: $masked';
  }

  @override
  String get paymentCardNumberLabel => 'Номер карты';

  @override
  String get paymentCardNumberHintKeep =>
      'Оставьте пустым, чтобы сохранить текущий';

  @override
  String get paymentCardNumberError => 'Введите корректный номер карты';

  @override
  String get paymentCardHolderLabel => 'Имя на карте';

  @override
  String get paymentCardHolderError => 'Введите имя держателя';

  @override
  String get paymentCardExpiryLabel => 'Срок (ММ/ГГ)';

  @override
  String get paymentCardExpiryFormatError => 'Формат ММ/ГГ';

  @override
  String get paymentCardExpiryMonthError => 'Неверный месяц';

  @override
  String get paymentCardCvvLabel => 'CVV';

  @override
  String get paymentCardCvvError => 'Введите CVV';

  @override
  String get paymentBrandVisa => 'Visa';

  @override
  String get paymentBrandMastercard => 'Mastercard';

  @override
  String get paymentVouchersActiveTitle => 'Активные ваучеры';

  @override
  String get paymentVoucherLabel => 'Ваучер';

  @override
  String get paymentVoucherValid => 'Действителен';

  @override
  String get serviceHubTitle => 'Сервис-хаб';

  @override
  String get serviceHubPostSuccess => 'Проект успешно опубликован.';

  @override
  String get serviceHubPostProject => 'Опубликовать проект';

  @override
  String get serviceHubBidApply => 'Предложить / Откликнуться';

  @override
  String get serviceHubTabPostJob => 'Разместить заказ';

  @override
  String get serviceHubTabBrowseRequests => 'Заявки';

  @override
  String get serviceHubFormHeading => 'Новый проект';

  @override
  String get serviceHubFormSubheading =>
      'Опишите задачу и получите предложения от специалистов.';

  @override
  String get serviceHubFieldProjectTitle => 'Название проекта';

  @override
  String get serviceHubFieldProjectTitleHint => 'Ремонт сантехники на кухне';

  @override
  String get serviceHubFieldProjectTitleError => 'Введите название проекта';

  @override
  String get serviceHubFieldDescription => 'Подробное описание';

  @override
  String get serviceHubFieldDescriptionHint =>
      'Опишите объём, сроки и особые пожелания...';

  @override
  String get serviceHubFieldDescriptionError => 'Добавьте не менее 12 символов';

  @override
  String get serviceHubSampleJob1Customer => 'Лера';

  @override
  String get serviceHubSampleJob1Title => 'Ремонт квартиры';

  @override
  String get serviceHubSampleJob1Snippet =>
      'Покраска, обновление пола и кухонных фасадов.';

  @override
  String get serviceHubSampleJob2Customer => 'Аскар';

  @override
  String get serviceHubSampleJob2Title => 'Генеральная уборка';

  @override
  String get serviceHubSampleJob2Snippet =>
      'Уборка при выезде из двухкомнатной квартиры в эти выходные.';

  @override
  String get serviceHubSampleJob3Customer => 'Дана';

  @override
  String get serviceHubSampleJob3Title => 'Сборка мебели';

  @override
  String get serviceHubSampleJob3Snippet => 'Собрать шкаф, стол и две тумбы.';

  @override
  String get profilePayNow => 'Оплатить';

  @override
  String get profileTrack => 'Отследить';

  @override
  String get profileReview => 'Отзыв';

  @override
  String get profileOrderHistory => 'История заказов';

  @override
  String get profileHistoryTitle => 'История';

  @override
  String get profileTabToPay => 'К оплате';

  @override
  String get profileTabToReceive => 'К получению';

  @override
  String get profileTabToReview => 'К отзыву';

  @override
  String get profileMyOrdersSubtitle => 'Мои заказы';

  @override
  String get profileNothingHereYet => 'Пока пусто';

  @override
  String get profilePaymentFlowSoon => 'Оплата скоро';

  @override
  String get profileFailedToLoad => 'Не удалось загрузить профиль';

  @override
  String profileGreeting(String name) {
    return 'Здравствуйте, $name!';
  }

  @override
  String get profileRecentlyViewed => 'Недавно просмотренные';

  @override
  String get profileMyOrdersSection => 'Мои заказы';

  @override
  String get profileStoriesSection => 'Истории';

  @override
  String get profileMyActivity => 'Моя активность';

  @override
  String get profileScannerSoon => 'Сканер скоро';

  @override
  String get profileFiltersSoon => 'Фильтры скоро';

  @override
  String get orderTrackingPageSubtitle => 'Отследите заказ';

  @override
  String get orderTrackingNumberLabel => 'Трек-номер';

  @override
  String get orderTrackingCopiedNumber => 'Трек-номер скопирован';

  @override
  String get vouchersPageTitle => 'Ваучеры';

  @override
  String get vouchersTabActiveRewards => 'Активные награды';

  @override
  String get vouchersTabProgress => 'Прогресс';

  @override
  String get settingsYourProfile => 'Ваш профиль';

  @override
  String get settingsChooseCountryPlaceholder => 'Выберите страну';

  @override
  String get validationFieldRequired => 'Обязательно';

  @override
  String get settingsProfileDisplayNameEmpty => 'Имя не может быть пустым.';

  @override
  String settingsProfileEmailConfirmSent(String email) {
    return 'Мы отправили ссылку для подтверждения на $email. Откройте её, чтобы завершить смену email.';
  }

  @override
  String get settingsProfileNameLabel => 'Имя';

  @override
  String get profileStatOrdered => 'Заказано';

  @override
  String get profileStatReceived => 'Получено';

  @override
  String get profileStatToReceive => 'К получению';

  @override
  String get profileChatNow => 'В чат';

  @override
  String get profileSayIt => 'Написать!';

  @override
  String get profileReviewThankYou => 'Спасибо за отзыв';

  @override
  String get profileNoItemsToReview => 'Нет товаров для отзыва';

  @override
  String get profileReviewWhichItem => 'Какой товар хотите оценить?';

  @override
  String get profileDeliveryNotSuccessful => 'Доставка не удалась';

  @override
  String get profileDeliveryWhatToDo => 'Что делать?';

  @override
  String get profileDeliveryFailureBody =>
      'Не волнуйтесь, мы скоро свяжемся с вами, чтобы согласовать удобное время доставки. Также можно позвонить +00 000 000 000 или написать в чат поддержки.';

  @override
  String get voucherCollected => 'Получено';

  @override
  String get validationChooseCountry => 'Выберите страну';

  @override
  String get settingsSaveChanges => 'Сохранить изменения';

  @override
  String get profilePhotoEditorSoon => 'Редактор фото скоро';

  @override
  String get aiInteriorTitle => 'AI-дизайн и расчёт';

  @override
  String get aiInteriorRoomInput => 'Параметры комнаты';

  @override
  String get aiInteriorRecommendedFurniture => 'Рекомендуемая мебель';

  @override
  String get aiInteriorSummaryReport => 'Итоговый отчёт';

  @override
  String get aiInteriorStopScanning => 'Остановить сканирование';

  @override
  String get aiInteriorStartAiScan => 'Запустить AI-скан';

  @override
  String get aiInteriorUploadImage => 'Загрузить изображение';

  @override
  String get aiInteriorUploadFormats => 'PNG, JPG до 10 МБ';

  @override
  String get aiInteriorScanning => 'Сканирование...';

  @override
  String get aiInteriorShopMarketplace => 'Купить в маркетплейсе';

  @override
  String get aiInteriorMaterialsEstimate => 'Оценка материалов';

  @override
  String get aiInteriorLaborEstimate => 'Оценка работ';

  @override
  String get aiInteriorTotalEstimatedCost =>
      'Итоговая ориентировочная стоимость';

  @override
  String get shoppingNotesTitle => 'Заметки покупок';

  @override
  String get shoppingNotesChart => 'График';

  @override
  String get shoppingNotesAllCategoriesSegment => 'Все категории';

  @override
  String get shoppingNotesAddCategoryFirst => 'Сначала добавьте категорию';

  @override
  String get shoppingNotesNewCategory => 'Новая категория';

  @override
  String get shoppingNotesRenameCategory => 'Переименовать категорию';

  @override
  String get shoppingNotesAddCategory => 'Добавить категорию';

  @override
  String get shoppingNotesCannotDelete => 'Нельзя удалить';

  @override
  String get shoppingNotesCategoryError => 'Ошибка категории';

  @override
  String get shoppingNotesExportTooltip => 'Экспорт';

  @override
  String get shoppingNotesManageCategoriesTooltip => 'Управление категориями';

  @override
  String get shoppingNotesOnlineBanner =>
      'Онлайн: изменения попытаются синхронизироваться (демо HTTP).';

  @override
  String get shoppingNotesOfflineBanner =>
      'Офлайн: данные остаются на этом устройстве.';

  @override
  String get shoppingNotesSearchHint =>
      'Фильтр по названию, деталям или категории';

  @override
  String get shoppingNotesCouldNotLoad => 'Не удалось загрузить заметки.\n';

  @override
  String get shoppingNotesNoNotesYet =>
      'Заметок пока нет. Нажмите +, чтобы добавить.';

  @override
  String get shoppingNotesNoMatchFilter => 'Нет заметок по текущему фильтру.';

  @override
  String get shoppingNotesSyncStatusSynced => 'синхр.';

  @override
  String get shoppingNotesSyncStatusLocal => 'локально';

  @override
  String get shoppingNotesNeedCategoryBody =>
      'Для заметок нужна категория. Откройте «Управление категориями» и создайте хотя бы одну.';

  @override
  String get shoppingNotesNewNoteTitle => 'Новая заметка';

  @override
  String get shoppingNotesEditNoteTitle => 'Редактировать заметку';

  @override
  String get shoppingNotesFieldTitle => 'Название';

  @override
  String get shoppingNotesFieldDetails => 'Детали';

  @override
  String get shoppingNotesFieldCategory => 'Категория';

  @override
  String get shoppingNotesFieldAmount => 'Сумма';

  @override
  String get shoppingNotesCategoriesSheetTitle => 'Категории';

  @override
  String get shoppingNotesCouldNotLoadCategories =>
      'Не удалось загрузить категории.\n';

  @override
  String get shoppingNotesNoCategoriesYet =>
      'Категорий нет. Нажмите +, чтобы добавить.';

  @override
  String shoppingNotesCategoryRowMeta(int id, String date) {
    return 'id $id · обновлено $date';
  }

  @override
  String get shoppingNotesCannotDeleteBody =>
      'Сначала удалите или переназначьте заметки, использующие эту категорию.\n';

  @override
  String get spendingByCategoryTitle => 'Расходы по категориям';

  @override
  String get spendingAnalyticsLoadError =>
      'Не удалось загрузить данные графика.\n';

  @override
  String get spendingAnalyticsEmptyPrompt =>
      'Добавьте заметки с категориями и суммами, чтобы увидеть график.';

  @override
  String get spendingAnalyticsSubtitle =>
      'Итоги по локальным заметкам (работает офлайн).';
}
