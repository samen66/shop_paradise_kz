import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/ai_design_provider.dart';

class UploadPhotoScreen extends ConsumerWidget {
  const UploadPhotoScreen({super.key});

  static final ImagePicker _picker = ImagePicker();

  Future<void> _pick(
    WidgetRef ref, {
    required ImageSource source,
  }) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      maxWidth: 2048,
      imageQuality: 85,
    );
    if (image == null) {
      return;
    }
    ref.read(aiDesignProvider.notifier).setPhoto(image);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AiDesignState state = ref.watch(aiDesignProvider);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    final bool hasPhoto = state.photo != null;

    return Scaffold(
      appBar: AppBar(title: const Text('Фото комнаты')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _UploadZone(
            hasPhoto: hasPhoto,
            photo: state.photo,
            onTap: () => _pick(ref, source: ImageSource.gallery),
            onRemove: () => ref.read(aiDesignProvider.notifier).clearPhoto(),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pick(ref, source: ImageSource.camera),
                  icon: const Text('📷'),
                  label: const Text('Камера'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pick(ref, source: ImageSource.gallery),
                  icon: const Text('🖼'),
                  label: const Text('Галерея'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text(
              'Как сделать хорошее фото?',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            children: <Widget>[
              _Tip(text: 'Снимайте при дневном свете'),
              _Tip(text: 'Сделайте фото с угла комнаты'),
              _Tip(text: 'Уберите лишние предметы из кадра'),
              const SizedBox(height: 8),
            ],
          ),
          if (state.errorMessage != null) ...<Widget>[
            const SizedBox(height: 10),
            SelectableText.rich(
              TextSpan(
                text: state.errorMessage,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.error,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
          const SizedBox(height: 80),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          child: FilledButton(
            onPressed: hasPhoto ? () => context.push('/ai-design/settings') : null,
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
            child: const Text('Далее →'),
          ),
        ),
      ),
    );
  }
}

class _UploadZone extends StatelessWidget {
  const _UploadZone({
    required this.hasPhoto,
    required this.photo,
    required this.onTap,
    required this.onRemove,
  });

  final bool hasPhoto;
  final XFile? photo;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colors.outlineVariant,
            width: 1.2,
          ),
          color: colors.surfaceContainerHighest.withValues(alpha: 0.4),
        ),
        child: hasPhoto
            ? Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: _PickedImage(photo: photo!),
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: IconButton.filled(
                      onPressed: onRemove,
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.photo_camera_outlined, size: 64, color: colors.primary),
                  const SizedBox(height: 10),
                  Text(
                    'Нажмите чтобы выбрать фото',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Лучший результат — фото при дневном свете',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _PickedImage extends StatelessWidget {
  const _PickedImage({required this.photo});

  final XFile photo;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Image.network(photo.path, fit: BoxFit.cover);
    }
    return Image.file(File(photo.path), fit: BoxFit.cover);
  }
}

class _Tip extends StatelessWidget {
  const _Tip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.check_circle_outline, color: colors.primary),
      title: Text(text),
    );
  }
}

