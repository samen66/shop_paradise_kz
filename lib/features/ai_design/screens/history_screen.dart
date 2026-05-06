import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/ai_design_result.dart';
import '../providers/ai_design_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AiDesignState state = ref.watch(aiDesignProvider);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    if (state.history.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Мои дизайны')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.auto_awesome_outlined, size: 56, color: colors.primary),
                const SizedBox(height: 12),
                Text(
                  'Ваши дизайны появятся здесь',
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Создайте первый AI-дизайн — загрузите фото комнаты и получите смету.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => context.go('/ai-design/upload'),
                  child: const Text('+ Новый анализ'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.go('/ai-design/upload'),
          icon: const Icon(Icons.add_rounded),
          label: const Text('Новый анализ'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Мои дизайны')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: state.history.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (BuildContext context, int index) {
          final AiDesignResult item = state.history[index];
          final int total = item.products.fold<int>(0, (int sum, p) => sum + p.total);
          return Card(
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: Image.asset(
                    item.afterImageAssetPath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: colors.surfaceContainerHighest,
                        child: const Icon(Icons.image_outlined),
                      );
                    },
                  ),
                ),
              ),
              title: Text(
                'Дизайн от ${_formatDate(item.createdAt)}',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              subtitle: Text('Сумма сметы: ${_formatKzt(total)}'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => context.go('/ai-design/result'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/ai-design/upload'),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Новый анализ'),
      ),
    );
  }
}

String _formatDate(DateTime dt) {
  final String dd = dt.day.toString().padLeft(2, '0');
  final String mm = dt.month.toString().padLeft(2, '0');
  final String yyyy = dt.year.toString();
  return '$dd.$mm.$yyyy';
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

