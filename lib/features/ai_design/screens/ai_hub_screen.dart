import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AiHubScreen extends StatelessWidget {
  const AiHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Дизайн'),
        actions: <Widget>[
          IconButton(
            tooltip: 'История',
            onPressed: () => context.push('/ai-design/history'),
            icon: const Icon(Icons.history_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _HeroBanner(colors: colors),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => context.push('/ai-design/upload'),
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
              child: const Text('Начать →'),
            ),
          ),
          const SizedBox(height: 18),
          Text('Как это работает', style: theme.textTheme.titleMedium),
          const SizedBox(height: 10),
          const _HowItWorksRow(),
          const SizedBox(height: 18),
          Row(
            children: <Widget>[
              Expanded(
                child: Text('Примеры работ', style: theme.textTheme.titleMedium),
              ),
              TextButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    showDragHandle: true,
                    builder: (_) => const _ExamplesSheet(),
                  );
                },
                child: const Text('Посмотреть'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const _ExamplesScroller(),
          const SizedBox(height: 18),
          Card(
            color: colors.surfaceContainerHighest.withValues(alpha: 0.55),
            child: const Padding(
              padding: EdgeInsets.all(14),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _TrustMetric(
                      title: '12 400+',
                      subtitle: 'дизайнов создано',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _TrustMetric(
                      title: '4.8★',
                      subtitle: 'оценка пользователей',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.colors});

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            colors.primary.withValues(alpha: 0.85),
            colors.tertiary.withValues(alpha: 0.75),
            colors.secondary.withValues(alpha: 0.75),
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 22,
            color: colors.primary.withValues(alpha: 0.25),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Загрузи фото — получи готовый дизайн',
                  style: text.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text('✨', style: TextStyle(fontSize: 26)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'AI подберёт товары из нашего каталога и составит смету',
            style: text.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.92),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _HowItWorksRow extends StatelessWidget {
  const _HowItWorksRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const <Widget>[
          _StepChip(emoji: '📷', label: 'Фото'),
          _Arrow(),
          _StepChip(emoji: '🤖', label: 'Анализ'),
          _Arrow(),
          _StepChip(emoji: '🛒', label: 'Смета'),
        ],
      ),
    );
  }
}

class _StepChip extends StatelessWidget {
  const _StepChip({required this.emoji, required this.label});

  final String emoji;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        children: <Widget>[
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _Arrow extends StatelessWidget {
  const _Arrow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Center(child: Icon(Icons.chevron_right_rounded)),
    );
  }
}

class _ExamplesScroller extends StatelessWidget {
  const _ExamplesScroller();

  static const List<String> _examples = <String>[
    'docs/screenshots/01_welcome.png',
    'docs/screenshots/02_shopping_notes.png',
    'docs/screenshots/03_spending_analytics.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _examples.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.asset(
                _examples[index],
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: const Center(child: Icon(Icons.image_outlined)),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ExamplesSheet extends StatelessWidget {
  const _ExamplesSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Примеры работ',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          const _ExamplesScroller(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _TrustMetric extends StatelessWidget {
  const _TrustMetric({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w900,
            color: colors.primary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

