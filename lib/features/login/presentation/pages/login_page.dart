import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

enum _LoginStep { email, password, recoveryMethod, recoveryCode, newPassword }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  _LoginStep _step = _LoginStep.email;
  int _passwordDigits = 0;
  int _recoveryCodeDigits = 0;
  bool _smsSelected = true;
  bool _showRecoveryError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  void _onNextFromEmail() {
    FocusScope.of(context).unfocus();
    setState(() {
      _step = _LoginStep.password;
    });
  }

  void _onTypePasswordDigit() {
    if (_passwordDigits >= 8) {
      return;
    }
    setState(() {
      _passwordDigits += 1;
    });
  }

  void _onDeletePasswordDigit() {
    if (_passwordDigits <= 0) {
      return;
    }
    setState(() {
      _passwordDigits -= 1;
    });
  }

  void _onGoToRecoveryMethod() {
    setState(() {
      _step = _LoginStep.recoveryMethod;
    });
  }

  void _onGoToRecoveryCode() {
    setState(() {
      _step = _LoginStep.recoveryCode;
      _showRecoveryError = false;
      _recoveryCodeDigits = 0;
    });
  }

  void _onTypeRecoveryCodeDigit() {
    if (_recoveryCodeDigits >= 4) {
      return;
    }
    setState(() {
      _recoveryCodeDigits += 1;
      if (_recoveryCodeDigits == 4) {
        _step = _LoginStep.newPassword;
      }
    });
  }

  void _onShowRecoveryError() {
    setState(() {
      _showRecoveryError = true;
    });
  }

  void _onSaveNewPassword() {
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Password updated.')));
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const _LoginBackdrop(),
          SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 240),
                  child: switch (_step) {
                    _LoginStep.email => _EmailStep(
                      key: const ValueKey<String>('email-step'),
                      theme: theme,
                      emailController: _emailController,
                      onNext: _onNextFromEmail,
                      onCancel: () => Navigator.of(context).pop(),
                    ),
                    _LoginStep.password => _PasswordStep(
                      key: const ValueKey<String>('password-step'),
                      theme: theme,
                      filledCount: _passwordDigits,
                      onDigitTap: _onTypePasswordDigit,
                      onBackspaceTap: _onDeletePasswordDigit,
                      onNotYouTap: () => Navigator.of(context).pop(),
                      onForgotPasswordTap: _onGoToRecoveryMethod,
                    ),
                    _LoginStep.recoveryMethod => _RecoveryMethodStep(
                      key: const ValueKey<String>('recovery-method-step'),
                      theme: theme,
                      smsSelected: _smsSelected,
                      onSelectSms: () => setState(() => _smsSelected = true),
                      onSelectEmail: () => setState(() => _smsSelected = false),
                      onNext: _onGoToRecoveryCode,
                      onCancel: () => Navigator.of(context).pop(),
                    ),
                    _LoginStep.recoveryCode => _RecoveryCodeStep(
                      key: const ValueKey<String>('recovery-code-step'),
                      theme: theme,
                      filledCount: _recoveryCodeDigits,
                      showError: _showRecoveryError,
                      onSendAgain: _onShowRecoveryError,
                      onCancel: () => Navigator.of(context).pop(),
                      onDigitTap: _onTypeRecoveryCodeDigit,
                    ),
                    _LoginStep.newPassword => _NewPasswordStep(
                      key: const ValueKey<String>('new-password-step'),
                      theme: theme,
                      newPasswordController: _newPasswordController,
                      repeatPasswordController: _repeatPasswordController,
                      onSave: _onSaveNewPassword,
                      onCancel: () => Navigator.of(context).pop(),
                    ),
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmailStep extends StatelessWidget {
  const _EmailStep({
    super.key,
    required this.theme,
    required this.emailController,
    required this.onNext,
    required this.onCancel,
  });

  final ThemeData theme;
  final TextEditingController emailController;
  final VoidCallback onNext;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Spacer(flex: 4),
        Text(
          'Login',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Good to see you back!  🖤',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w400,
            color: scheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 28),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(hintText: 'Email'),
        ),
        const Spacer(flex: 5),
        FilledButton(onPressed: onNext, child: const Text('Next')),
        const SizedBox(height: 10),
        TextButton(onPressed: onCancel, child: const Text('Cancel')),
      ],
    );
  }
}

class _PasswordStep extends StatelessWidget {
  const _PasswordStep({
    super.key,
    required this.theme,
    required this.filledCount,
    required this.onDigitTap,
    required this.onBackspaceTap,
    required this.onNotYouTap,
    required this.onForgotPasswordTap,
  });

  final ThemeData theme;
  final int filledCount;
  final VoidCallback onDigitTap;
  final VoidCallback onBackspaceTap;
  final VoidCallback onNotYouTap;
  final VoidCallback onForgotPasswordTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = theme.colorScheme;
    final bool isComplete = filledCount >= 8;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 62),
        const _Avatar(),
        const SizedBox(height: 20),
        Center(
          child: Text(
            'Hello, Romina!!',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            'Type your password',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w400,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: 22),
        _PinDots(
          total: 8,
          filled: filledCount,
          filledColor: isComplete ? const Color(0xFFEF5350) : AppColors.primary,
        ),
        const SizedBox(height: 18),
        if (isComplete)
          Center(
            child: TextButton(
              onPressed: onForgotPasswordTap,
              child: const Text('Forgot your password?'),
            ),
          ),
        const Spacer(),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Not you?',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 12),
              Material(
                color: scheme.primary,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onNotYouTap,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.arrow_forward,
                      color: scheme.onPrimary,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _NumberPad(onDigitTap: onDigitTap, onBackspaceTap: onBackspaceTap),
      ],
    );
  }
}

class _RecoveryMethodStep extends StatelessWidget {
  const _RecoveryMethodStep({
    super.key,
    required this.theme,
    required this.smsSelected,
    required this.onSelectSms,
    required this.onSelectEmail,
    required this.onNext,
    required this.onCancel,
  });

  final ThemeData theme;
  final bool smsSelected;
  final VoidCallback onSelectSms;
  final VoidCallback onSelectEmail;
  final VoidCallback onNext;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 56),
        const _Avatar(),
        const SizedBox(height: 22),
        Center(
          child: Text(
            'Password Recovery',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            'How you would like to restore your password?',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w400,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: 24),
        _ChoicePill(
          text: 'SMS',
          selected: smsSelected,
          selectedColor: const Color(0xFFE7EBFA),
          iconColor: AppColors.primary,
          onTap: onSelectSms,
        ),
        const SizedBox(height: 10),
        _ChoicePill(
          text: 'Email',
          selected: !smsSelected,
          selectedColor: const Color(0xFFFFE6EF),
          iconColor: const Color(0xFFF06292),
          onTap: onSelectEmail,
        ),
        const Spacer(),
        FilledButton(onPressed: onNext, child: const Text('Next')),
        const SizedBox(height: 10),
        TextButton(onPressed: onCancel, child: const Text('Cancel')),
      ],
    );
  }
}

class _RecoveryCodeStep extends StatelessWidget {
  const _RecoveryCodeStep({
    super.key,
    required this.theme,
    required this.filledCount,
    required this.showError,
    required this.onSendAgain,
    required this.onCancel,
    required this.onDigitTap,
  });

  final ThemeData theme;
  final int filledCount;
  final bool showError;
  final VoidCallback onSendAgain;
  final VoidCallback onCancel;
  final VoidCallback onDigitTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 56),
        const _Avatar(),
        const SizedBox(height: 22),
        Center(
          child: Text(
            'Password Recovery',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            'Enter 4-digits code we sent you on your phone number',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w400,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            '+98*******00',
            style: theme.textTheme.titleLarge?.copyWith(
              color: scheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 20),
        _PinDots(total: 4, filled: filledCount, filledColor: AppColors.primary),
        const Spacer(),
        FilledButton(
          onPressed: onSendAgain,
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFFF34F92),
          ),
          child: const Text('Send Again'),
        ),
        const SizedBox(height: 10),
        TextButton(onPressed: onCancel, child: const Text('Cancel')),
        const SizedBox(height: 10),
        if (showError)
          Card(
            color: scheme.surface,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1F4),
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: const Icon(
                      Icons.error_outline,
                      color: Color(0xFFF48FB1),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'You reached out maximum amount of attempts. Please, try later.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.black87,
                      ),
                      child: const Text('Okay'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        _NumberPad(onDigitTap: onDigitTap, onBackspaceTap: () {}),
      ],
    );
  }
}

class _NewPasswordStep extends StatelessWidget {
  const _NewPasswordStep({
    super.key,
    required this.theme,
    required this.newPasswordController,
    required this.repeatPasswordController,
    required this.onSave,
    required this.onCancel,
  });

  final ThemeData theme;
  final TextEditingController newPasswordController;
  final TextEditingController repeatPasswordController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 56),
        const _Avatar(),
        const SizedBox(height: 22),
        Center(
          child: Text(
            'Setup New Password',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            'Please, setup a new password for your account',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w400,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: newPasswordController,
          obscureText: true,
          decoration: const InputDecoration(hintText: 'New Password'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: repeatPasswordController,
          obscureText: true,
          decoration: const InputDecoration(hintText: 'Repeat Password'),
        ),
        const Spacer(),
        FilledButton(onPressed: onSave, child: const Text('Save')),
        const SizedBox(height: 10),
        TextButton(onPressed: onCancel, child: const Text('Cancel')),
      ],
    );
  }
}

class _LoginBackdrop extends StatelessWidget {
  const _LoginBackdrop();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        const ColoredBox(color: AppColors.surface),
        Positioned(
          top: -110,
          left: -120,
          child: Container(
            width: 360,
            height: 340,
            decoration: BoxDecoration(
              color: AppColors.blobLightBlue,
              borderRadius: BorderRadius.circular(180),
            ),
          ),
        ),
        Positioned(
          top: -160,
          left: -160,
          child: Container(
            width: 330,
            height: 330,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(170),
            ),
          ),
        ),
        Positioned(
          right: -32,
          top: 235,
          child: Transform.rotate(
            angle: -0.4,
            child: Container(
              width: 92,
              height: 84,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(34),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 104,
        height: 104,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFF7F7F9),
          border: Border.all(color: const Color(0xFFEAEAEA)),
        ),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF8B5D1),
          ),
          child: const Icon(
            Icons.face_3_outlined,
            size: 54,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

class _PinDots extends StatelessWidget {
  const _PinDots({
    required this.total,
    required this.filled,
    required this.filledColor,
  });

  final int total;
  final int filled;
  final Color filledColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(total, (int index) {
        final bool isFilled = index < filled;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isFilled ? filledColor : AppColors.blobLightBlue,
            ),
          ),
        );
      }),
    );
  }
}

class _ChoicePill extends StatelessWidget {
  const _ChoicePill({
    required this.text,
    required this.selected,
    required this.selectedColor,
    required this.iconColor,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final Color selectedColor;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      color: selectedColor,
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 12, 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Text(
                    text,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: selected ? iconColor : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? iconColor : Colors.white,
                  border: Border.all(color: Colors.white70, width: 3),
                ),
                child: selected
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NumberPad extends StatelessWidget {
  const _NumberPad({required this.onDigitTap, required this.onBackspaceTap});

  final VoidCallback onDigitTap;
  final VoidCallback onBackspaceTap;

  @override
  Widget build(BuildContext context) {
    final List<String> rows = <String>['123', '456', '789', '<0>'];
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: rows
            .map((String row) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: row
                      .split('')
                      .map((String item) {
                        if (item == '<' || item == '>') {
                          final bool isBackspace = item == '>';
                          return Expanded(
                            child: _PadButton(
                              label: isBackspace ? '⌫' : '',
                              onTap: isBackspace ? onBackspaceTap : null,
                              theme: theme,
                            ),
                          );
                        }
                        return Expanded(
                          child: _PadButton(
                            label: item,
                            onTap: onDigitTap,
                            theme: theme,
                          ),
                        );
                      })
                      .toList(growable: false),
                ),
              );
            })
            .toList(growable: false),
      ),
    );
  }
}

class _PadButton extends StatelessWidget {
  const _PadButton({
    required this.label,
    required this.onTap,
    required this.theme,
  });

  final String label;
  final VoidCallback? onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
