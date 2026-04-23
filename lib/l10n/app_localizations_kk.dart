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
}
