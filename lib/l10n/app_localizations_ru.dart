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
}
