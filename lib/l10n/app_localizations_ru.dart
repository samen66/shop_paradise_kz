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
}
