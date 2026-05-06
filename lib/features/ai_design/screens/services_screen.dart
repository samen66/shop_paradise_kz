import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ai_service.dart';
import '../providers/ai_design_provider.dart';

class ServicesScreen extends ConsumerWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AiDesignState state = ref.watch(aiDesignProvider);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    final int selectedTotal = state.services
        .where((AiService s) => s.isSelected)
        .fold<int>(0, (int sum, AiService s) => sum + s.price);

    return Scaffold(
      appBar: AppBar(title: const Text('Добавить услуги')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: state.services.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (BuildContext context, int index) {
          final AiService s = state.services[index];
          return Card(
            child: CheckboxListTile(
              value: s.isSelected,
              onChanged: (_) => ref.read(aiDesignProvider.notifier).toggleService(s.id),
              title: Text('${s.emojiIcon} ${s.name}'),
              subtitle: Text(
                '${s.description}\n${_formatKzt(s.price)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          child: FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Услуги добавлены: ${_formatKzt(selectedTotal)}'),
                ),
              );
              Navigator.of(context).pop();
            },
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
            child: Text('Добавить к заказу (${_formatKzt(selectedTotal)})'),
          ),
        ),
      ),
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

