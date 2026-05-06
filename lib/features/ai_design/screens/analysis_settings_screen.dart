import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/supported_room_type.dart';
import '../providers/ai_design_provider.dart';
import '../widgets/style_chip_selector.dart';

class AnalysisSettingsScreen extends ConsumerWidget {
  const AnalysisSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AiDesignState state = ref.watch(aiDesignProvider);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _PhotoPreviewCard(photoPath: state.photo?.path),
          const SizedBox(height: 16),
          Text('Желаемый стиль', style: theme.textTheme.titleMedium),
          const SizedBox(height: 10),
          StyleChipSelector(
            value: state.style,
            onChanged: (style) {
              ref.read(aiDesignProvider.notifier).setStyle(style);
            },
          ),
          const SizedBox(height: 18),
          Text('Комната', style: theme.textTheme.titleMedium),
          const SizedBox(height: 10),
          DropdownButtonFormField<SupportedRoomType>(
            initialValue: state.roomType,
            items: SupportedRoomType.values
                .map(
                  (SupportedRoomType v) => DropdownMenuItem<SupportedRoomType>(
                    value: v,
                    child: Text('${v.emoji} ${v.label}'),
                  ),
                )
                .toList(growable: false),
            onChanged: (SupportedRoomType? value) {
              if (value == null) {
                return;
              }
              ref.read(aiDesignProvider.notifier).setRoomType(value);
            },
          ),
          const SizedBox(height: 18),
          Text('Примерный бюджет', style: theme.textTheme.titleMedium),
          const SizedBox(height: 10),
          RangeSlider(
            min: 50000,
            max: 2000000,
            divisions: 39,
            values: state.budgetRange,
            labels: RangeLabels(
              _formatKzt(state.budgetRange.start.round()),
              _formatKzt(state.budgetRange.end.round()),
            ),
            onChanged: (RangeValues values) {
              ref.read(aiDesignProvider.notifier).setBudgetRange(values);
            },
          ),
          Text(
            '${_formatKzt(state.budgetRange.start.round())} — '
            '${_formatKzt(state.budgetRange.end.round())}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _PresetChip(
                label: 'До 200к',
                onTap: () => ref
                    .read(aiDesignProvider.notifier)
                    .setBudgetRange(const RangeValues(50000, 200000)),
              ),
              _PresetChip(
                label: '200–500к',
                onTap: () => ref
                    .read(aiDesignProvider.notifier)
                    .setBudgetRange(const RangeValues(200000, 500000)),
              ),
              _PresetChip(
                label: '500к–1M',
                onTap: () => ref
                    .read(aiDesignProvider.notifier)
                    .setBudgetRange(const RangeValues(500000, 1000000)),
              ),
              _PresetChip(
                label: 'Без лимита',
                onTap: () => ref
                    .read(aiDesignProvider.notifier)
                    .setBudgetRange(const RangeValues(50000, 2000000)),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text(
              'Дополнительно',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            children: <Widget>[
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: state.includeServices,
                onChanged: (bool v) =>
                    ref.read(aiDesignProvider.notifier).setIncludeServices(v),
                title: const Text('Включить услуги (монтаж, доставка)'),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: state.onlyInStock,
                onChanged: (bool v) =>
                    ref.read(aiDesignProvider.notifier).setOnlyInStock(v),
                title: const Text('Только товары в наличии'),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: state.considerExistingFurniture,
                onChanged: (bool v) => ref
                    .read(aiDesignProvider.notifier)
                    .setConsiderExistingFurniture(v),
                title: const Text('Учитывать существующую мебель'),
              ),
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
          const SizedBox(height: 90),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          child: FilledButton.icon(
            onPressed: state.photo == null
                ? null
                : () async {
                    await ref.read(aiDesignProvider.notifier).startAnalysis();
                    if (!context.mounted) {
                      return;
                    }
                    context.go('/ai-design/analyzing');
                  },
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
            icon: const Icon(Icons.auto_awesome_rounded),
            label: const Text('Анализировать'),
          ),
        ),
      ),
    );
  }
}

class _PhotoPreviewCard extends StatelessWidget {
  const _PhotoPreviewCard({required this.photoPath});

  final String? photoPath;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 110,
                height: 80,
                child: photoPath == null
                    ? Container(
                        color: colors.surfaceContainerHighest,
                        child: const Center(child: Icon(Icons.image_outlined)),
                      )
                    : _PreviewImage(path: photoPath!),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Загруженное фото',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Не нужно возвращаться назад — настройте анализ здесь.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
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

class _PreviewImage extends StatelessWidget {
  const _PreviewImage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Image.network(path, fit: BoxFit.cover);
    }
    return Image.file(File(path), fit: BoxFit.cover);
  }
}

class _PresetChip extends StatelessWidget {
  const _PresetChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: onTap,
      label: Text(label),
    );
  }
}

String _formatKzt(int value) {
  final String s = value.toString();
  final StringBuffer buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    final int remaining = s.length - i;
    buf.write(s[i]);
    if (remaining > 1 && remaining % 3 == 1) {
      buf.write(' ');
    }
  }
  return '₸${buf.toString()}';
}

