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
  String get webHeaderCatalog => 'Catalog';

  @override
  String get webHeaderSearchPlaceholder => 'Enter query';

  @override
  String get webHeaderLinkPromotions => 'Promotions';

  @override
  String get webHeaderLinkMagazine => 'Magazine';

  @override
  String get webHeaderLinkShowrooms => 'Showrooms';
}
