import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

/// Registration screen: avatar placeholder, email, password, phone with country code.
class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _obscurePassword = true;
  _CountryDial _country = _kDefaultCountry;

  static const _CountryDial _kDefaultCountry = _CountryDial(
    iso: 'KZ',
    dial: '+7',
  );

  static const List<_CountryDial> _countries = <_CountryDial>[
    _CountryDial(iso: 'KZ', dial: '+7'),
    _CountryDial(iso: 'GB', dial: '+44'),
    _CountryDial(iso: 'RU', dial: '+7'),
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value, AppLocalizations l10n) {
    final String v = value?.trim() ?? '';
    if (v.isEmpty) {
      return l10n.createAccountEmailInvalid;
    }
    final RegExp email = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!email.hasMatch(v)) {
      return l10n.createAccountEmailInvalid;
    }
    return null;
  }

  String? _validatePassword(String? value, AppLocalizations l10n) {
    final String v = value ?? '';
    if (v.length < 8) {
      return l10n.createAccountPasswordTooShort;
    }
    return null;
  }

  String? _validatePhone(String? value, AppLocalizations l10n) {
    final String digits = RegExp(r'\d').allMatches(value ?? '').map((m) => m.group(0)!).join();
    if (digits.length < 9) {
      return l10n.createAccountPhoneInvalid;
    }
    return null;
  }

  void _onDone(AppLocalizations l10n) {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.createAccountSuccess)),
    );
    Navigator.of(context).pop(true);
  }

  Future<void> _pickCountry() async {
    final _CountryDial? next = await showModalBottomSheet<_CountryDial>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (final _CountryDial c in _countries)
                ListTile(
                  leading: Text(_flagEmoji(c.iso), style: const TextStyle(fontSize: 28)),
                  title: Text('${c.dial} (${c.iso})'),
                  onTap: () => Navigator.of(sheetContext).pop(c),
                ),
            ],
          ),
        );
      },
    );
    if (next != null) {
      setState(() => _country = next);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const _CreateAccountBackdrop(),
          SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              behavior: HitTestBehavior.deferToChild,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        l10n.createAccountTitle,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _AvatarPlaceholder(
                          semanticLabel: l10n.createAccountAvatarSemanticLabel,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l10n.createAccountAvatarUnavailable)),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 28),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autocorrect: false,
                        decoration: InputDecoration(hintText: l10n.createAccountEmailHint),
                        validator: (String? v) => _validateEmail(v, l10n),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: l10n.createAccountPasswordHint,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        validator: (String? v) => _validatePassword(v, l10n),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: l10n.createAccountPhoneHint,
                          prefixIcon: Padding(
                            padding: const EdgeInsetsDirectional.only(start: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: _pickCountry,
                                    borderRadius: BorderRadius.circular(24),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            _flagEmoji(_country.iso),
                                            style: const TextStyle(fontSize: 22),
                                          ),
                                          Icon(Icons.expand_more, color: scheme.onSurfaceVariant, size: 22),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(width: 1, height: 26, color: scheme.outlineVariant),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(minWidth: 0),
                        ),
                        validator: (String? v) => _validatePhone(v, l10n),
                      ),
                      const SizedBox(height: 32),
                      FilledButton(
                        onPressed: () => _onDone(l10n),
                        child: Text(l10n.createAccountDone),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: TextButton.styleFrom(
                            foregroundColor: scheme.onSurfaceVariant,
                          ),
                          child: Text(
                            l10n.createAccountCancel,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountryDial {
  const _CountryDial({required this.iso, required this.dial});

  final String iso;
  final String dial;
}

String _flagEmoji(String isoCode) {
  final String upper = isoCode.toUpperCase();
  if (upper.length != 2) {
    return '🏳️';
  }
  final int first = upper.codeUnitAt(0);
  final int second = upper.codeUnitAt(1);
  if (first < 65 || first > 90 || second < 65 || second > 90) {
    return '🏳️';
  }
  const int base = 0x1F1E6;
  return String.fromCharCodes(<int>[
    base + (first - 65),
    base + (second - 65),
  ]);
}

class _CreateAccountBackdrop extends StatelessWidget {
  const _CreateAccountBackdrop();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        const ColoredBox(color: AppColors.surface),
        Positioned(
          top: -100,
          left: -100,
          child: IgnorePointer(
            child: Transform.rotate(
              angle: -0.2,
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  color: AppColors.blobLightBlue,
                  borderRadius: BorderRadius.circular(140),
                ),
              ),
            ),
          ),
        ),
        const Positioned.fill(
          child: IgnorePointer(child: CustomPaint(painter: _RightBlueCurvePainter())),
        ),
      ],
    );
  }
}

class _RightBlueCurvePainter extends CustomPainter {
  const _RightBlueCurvePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path()
      ..moveTo(size.width, 0)
      ..quadraticBezierTo(size.width * 0.72, size.height * 0.22, size.width * 0.88, size.height * 0.48)
      ..quadraticBezierTo(size.width * 1.02, size.height * 0.72, size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, Paint()..color = AppColors.primary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AvatarPlaceholder extends StatelessWidget {
  const _AvatarPlaceholder({required this.semanticLabel, required this.onTap});

  final String semanticLabel;
  final VoidCallback onTap;

  static const double _size = 96;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: _size,
            height: _size,
            child: CustomPaint(
              painter: _DashedCirclePainter(color: AppColors.primary),
              child: Center(
                child: Icon(Icons.photo_camera_outlined, color: AppColors.primary, size: 32),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  _DashedCirclePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.shortestSide / 2 - 1,
    );
    final Path oval = Path()..addOval(rect);
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    for (final metric in oval.computeMetrics()) {
      double distance = 0;
      const double dashLength = 6;
      const double gapLength = 4;
      while (distance < metric.length) {
        final double end = (distance + dashLength).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += dashLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedCirclePainter oldDelegate) => oldDelegate.color != color;
}
