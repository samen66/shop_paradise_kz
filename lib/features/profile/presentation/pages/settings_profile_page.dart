import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/auth_providers.dart';
import '../../domain/entities/profile_entities.dart' show ProfileHubEntity;
import '../providers/profile_providers.dart';
import '../widgets/settings_subpage_header.dart';

/// **Settings** → **Your Profile**: edit name / email (Firebase or mock).
class SettingsProfilePage extends ConsumerStatefulWidget {
  const SettingsProfilePage({super.key});

  @override
  ConsumerState<SettingsProfilePage> createState() =>
      _SettingsProfilePageState();
}

class _SettingsProfilePageState extends ConsumerState<SettingsProfilePage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  bool _seededFromHub = false;
  bool _saving = false;
  String? _firebaseSaveError;
  String? _firebaseSaveInfo;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    if (_saving) {
      return;
    }
    setState(() {
      _saving = true;
      _firebaseSaveError = null;
      _firebaseSaveInfo = null;
    });
    try {
      final User? user = Firebase.apps.isNotEmpty
          ? FirebaseAuth.instance.currentUser
          : null;
      if (user == null) {
        await ref.read(profileRepositoryProvider).saveProfileUser(
              displayName: _nameCtrl.text,
              email: _emailCtrl.text,
            );
        ref.invalidate(profileHubProvider);
        if (mounted) {
          Navigator.of(context).pop();
        }
        return;
      }
      final String name = _nameCtrl.text.trim();
      final String email = _emailCtrl.text.trim();
      if (name.isEmpty) {
        setState(() {
          _firebaseSaveError = 'Display name cannot be empty.';
        });
        return;
      }
      await user.updateDisplayName(name);
      final String? currentEmail = user.email;
      final bool wantsEmailChange =
          email.isNotEmpty && email != currentEmail;
      if (wantsEmailChange) {
        await user.verifyBeforeUpdateEmail(email);
      }
      await user.reload();
      ref.invalidate(authStateProvider);
      ref.invalidate(profileHubProvider);
      if (!mounted) {
        return;
      }
      if (wantsEmailChange) {
        setState(() {
          _firebaseSaveInfo =
              'We sent a confirmation link to $email. Open it to '
              'complete the email change.';
        });
      } else {
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() {
          _firebaseSaveError = e.message ?? e.code;
        });
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<ProfileHubEntity>>(profileHubProvider, (
      AsyncValue<ProfileHubEntity>? previous,
      AsyncValue<ProfileHubEntity> next,
    ) {
      next.whenData((ProfileHubEntity d) {
        if (!_seededFromHub && mounted) {
          _nameCtrl.text = d.user.displayName;
          _emailCtrl.text = d.user.email;
          setState(() => _seededFromHub = true);
        }
      });
    });

    final AsyncValue<ProfileHubEntity> hub = ref.watch(profileHubProvider);
    return hub.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (Object e, StackTrace _) => Scaffold(
        body: Center(child: Text('Error: $e')),
      ),
      data: (ProfileHubEntity data) {
        return _buildScaffold(context, data.user.avatarUrl);
      },
    );
  }

  Widget _buildScaffold(BuildContext context, String avatarUrl) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SettingsSubpageHeader(subtitle: 'Your Profile'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                children: <Widget>[
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: scheme.outlineVariant,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 48,
                            backgroundImage: NetworkImage(avatarUrl),
                            onBackgroundImageError: (_, __) {},
                          ),
                        ),
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Material(
                            color: AppColors.primary,
                            shape: const CircleBorder(),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Photo editor coming soon'),
                                  ),
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.edit_rounded,
                                  size: 18,
                                  color: AppColors.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  TextFormField(
                    key: const Key('settings_profile_name_field'),
                    controller: _nameCtrl,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      filled: true,
                      fillColor: AppColors.blobLightBlue.withValues(alpha: 0.45),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('settings_profile_email_field'),
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: AppColors.blobLightBlue.withValues(alpha: 0.45),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('settings_profile_password_field'),
                    obscureText: true,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '••••••••••••',
                      filled: true,
                      fillColor: AppColors.blobLightBlue.withValues(alpha: 0.45),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  if (_firebaseSaveError != null) ...<Widget>[
                    const SizedBox(height: 16),
                    SelectableText.rich(
                      TextSpan(
                        text: _firebaseSaveError,
                        style: TextStyle(color: scheme.error),
                      ),
                    ),
                  ],
                  if (_firebaseSaveInfo != null) ...<Widget>[
                    const SizedBox(height: 16),
                    SelectableText.rich(
                      TextSpan(
                        text: _firebaseSaveInfo,
                        style: TextStyle(color: scheme.onSurfaceVariant),
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                  FilledButton(
                    key: const Key('settings_profile_save_button'),
                    onPressed: _saving ? null : _onSave,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _saving
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.onPrimary,
                            ),
                          )
                        : const Text('Save changes'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
