import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/data/firebase_google_auth.dart';
import '../widgets/google_sign_in_render_button.dart';

enum _LoginStep { email, password }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _LoginStep _step = _LoginStep.email;
  bool _googleLoading = false;
  String? _googleError;
  bool _emailLoading = false;
  String? _emailError;
  StreamSubscription<GoogleSignInAuthenticationEvent>? _googleAuthSubscription;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _googleAuthSubscription =
          GoogleSignIn.instance.authenticationEvents.listen(
        (GoogleSignInAuthenticationEvent event) {
          if (event is GoogleSignInAuthenticationEventSignIn) {
            unawaited(_onGoogleWebSignedIn(event.user));
          }
        },
        onError: (Object error, StackTrace stackTrace) {
          if (!mounted) {
            return;
          }
          if (error is GoogleSignInException &&
              error.code == GoogleSignInExceptionCode.canceled) {
            return;
          }
          setState(() {
            _googleError = error.toString();
          });
        },
      );
    }
  }

  @override
  void dispose() {
    unawaited(_googleAuthSubscription?.cancel());
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onNextFromEmail() {
    FocusScope.of(context).unfocus();
    if (_emailController.text.trim().isEmpty) {
      setState(() => _emailError = 'Enter your email');
      return;
    }
    setState(() {
      _emailError = null;
      _step = _LoginStep.password;
    });
  }

  Future<void> _onSignInWithEmailPassword() async {
    FocusScope.of(context).unfocus();
    final AppLocalizations? l10n = AppLocalizations.of(context);
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;
    if (password.isEmpty) {
      setState(
        () => _emailError = l10n?.loginPasswordLabel ?? 'Enter password',
      );
      return;
    }
    setState(() {
      _emailLoading = true;
      _emailError = null;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _emailError = e.message ?? e.code;
      });
    } finally {
      if (mounted) {
        setState(() => _emailLoading = false);
      }
    }
  }

  Future<void> _onSendPasswordReset() async {
    final String email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() => _emailError = 'Enter a valid email first');
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent.')),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() => _emailError = e.message ?? e.code);
    }
  }

  void _setGoogleFailureMessage(AppLocalizations? l10n, String message) {
    if (!mounted) {
      return;
    }
    setState(() {
      _googleError = l10n?.loginGoogleSignInFailed(message) ?? message;
    });
  }

  Future<void> _onGoogleWebSignedIn(GoogleSignInAccount account) async {
    final AppLocalizations? l10n = AppLocalizations.of(context);
    if (_googleLoading) {
      return;
    }
    setState(() {
      _googleLoading = true;
      _googleError = null;
    });
    try {
      await signInToFirebaseWithGoogleAccount(account);
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } on FirebaseAuthException catch (e) {
      _setGoogleFailureMessage(l10n, e.message ?? e.code);
    } on StateError catch (e) {
      _setGoogleFailureMessage(l10n, e.message);
    } finally {
      if (mounted) {
        setState(() => _googleLoading = false);
      }
    }
  }

  Future<void> _onGoogleMobileSignIn() async {
    if (kIsWeb || _googleLoading) {
      return;
    }
    final AppLocalizations? l10n = AppLocalizations.of(context);
    setState(() {
      _googleLoading = true;
      _googleError = null;
    });
    try {
      await signInWithGoogleInteractive();
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled ||
          e.code == GoogleSignInExceptionCode.interrupted ||
          e.code == GoogleSignInExceptionCode.uiUnavailable) {
        return;
      }
      _setGoogleFailureMessage(
        l10n,
        e.description ?? e.code.name,
      );
    } on FirebaseAuthException catch (e) {
      _setGoogleFailureMessage(l10n, e.message ?? e.code);
    } on StateError catch (e) {
      _setGoogleFailureMessage(l10n, e.message);
    } finally {
      if (mounted) {
        setState(() => _googleLoading = false);
      }
    }
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
                        l10n: AppLocalizations.of(context)!,
                        emailController: _emailController,
                        onNext: _onNextFromEmail,
                        onCancel: () => Navigator.of(context).pop(),
                        isGoogleLoading: _googleLoading,
                        googleError: _googleError,
                        useWebGoogleButton: kIsWeb,
                        onGoogleMobilePressed: _onGoogleMobileSignIn,
                        emailError: _emailError,
                      ),
                    _LoginStep.password => _PasswordFieldStep(
                        key: const ValueKey<String>('password-step'),
                        theme: theme,
                        l10n: AppLocalizations.of(context)!,
                        email: _emailController.text.trim(),
                        passwordController: _passwordController,
                        onBack: () => setState(() {
                          _step = _LoginStep.email;
                          _emailError = null;
                        }),
                        onSignIn: _onSignInWithEmailPassword,
                        onForgotPassword: _onSendPasswordReset,
                        isLoading: _emailLoading,
                        errorText: _emailError,
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
    required this.l10n,
    required this.emailController,
    required this.onNext,
    required this.onCancel,
    required this.isGoogleLoading,
    required this.googleError,
    required this.useWebGoogleButton,
    required this.onGoogleMobilePressed,
    this.emailError,
  });

  final ThemeData theme;
  final AppLocalizations l10n;
  final TextEditingController emailController;
  final VoidCallback onNext;
  final VoidCallback onCancel;
  final bool isGoogleLoading;
  final String? googleError;
  final bool useWebGoogleButton;
  final VoidCallback onGoogleMobilePressed;
  final String? emailError;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Spacer(flex: 4),
        Text(
          l10n.loginTitle,
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
          decoration: InputDecoration(hintText: l10n.loginEmailLabel),
        ),
        if (emailError != null) ...<Widget>[
          const SizedBox(height: 8),
          SelectableText.rich(
            TextSpan(
              text: emailError,
              style: TextStyle(color: scheme.error),
            ),
          ),
        ],
        const SizedBox(height: 16),
        if (useWebGoogleButton)
          SizedBox(
            width: double.infinity,
            height: 44,
            child: googleSignInRenderButton(),
          )
        else
          OutlinedButton.icon(
            onPressed: isGoogleLoading ? null : onGoogleMobilePressed,
            icon: isGoogleLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: scheme.primary,
                    ),
                  )
                : Icon(Icons.login, color: scheme.primary),
            label: Text(l10n.loginContinueWithGoogle),
          ),
        if (googleError != null) ...<Widget>[
          const SizedBox(height: 12),
          SelectableText.rich(
            TextSpan(
              text: googleError,
              style: TextStyle(color: scheme.error),
            ),
          ),
        ],
        const Spacer(flex: 5),
        FilledButton(
          onPressed: isGoogleLoading ? null : onNext,
          child: Text(l10n.customerCareNext),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: isGoogleLoading ? null : onCancel,
          child: Text(l10n.loginCloseAction),
        ),
      ],
    );
  }
}

class _PasswordFieldStep extends StatelessWidget {
  const _PasswordFieldStep({
    super.key,
    required this.theme,
    required this.l10n,
    required this.email,
    required this.passwordController,
    required this.onBack,
    required this.onSignIn,
    required this.onForgotPassword,
    required this.isLoading,
    this.errorText,
  });

  final ThemeData theme;
  final AppLocalizations l10n;
  final String email;
  final TextEditingController passwordController;
  final VoidCallback onBack;
  final VoidCallback onSignIn;
  final VoidCallback onForgotPassword;
  final bool isLoading;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Spacer(flex: 3),
        Text(
          l10n.loginTitle,
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          email,
          style: theme.textTheme.titleMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: l10n.loginPasswordLabel,
          ),
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => onSignIn(),
        ),
        if (errorText != null) ...<Widget>[
          const SizedBox(height: 8),
          SelectableText.rich(
            TextSpan(
              text: errorText,
              style: TextStyle(color: scheme.error),
            ),
          ),
        ],
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: isLoading ? null : onForgotPassword,
            child: const Text('Forgot password?'),
          ),
        ),
        const Spacer(flex: 4),
        FilledButton(
          onPressed: isLoading ? null : onSignIn,
          child: isLoading
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Sign in'),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: isLoading ? null : onBack,
          child: const Text('Change email'),
        ),
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
