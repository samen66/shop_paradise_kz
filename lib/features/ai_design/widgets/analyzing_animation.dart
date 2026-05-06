import 'dart:async';

import 'package:flutter/material.dart';

class AnalyzingAnimation extends StatefulWidget {
  const AnalyzingAnimation({
    super.key,
    required this.onFinished,
    this.duration = const Duration(seconds: 5),
  });

  final VoidCallback onFinished;
  final Duration duration;

  @override
  State<AnalyzingAnimation> createState() => _AnalyzingAnimationState();
}

class _AnalyzingAnimationState extends State<AnalyzingAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progress;
  Timer? _statusTimer;
  int _statusIndex = 0;

  static const List<String> _statuses = <String>[
    'Анализирую пространство...',
    'Определяю стиль комнаты...',
    'Подбираю товары из каталога...',
    'Рассчитываю смету...',
    'Финальные штрихи...',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _progress = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        widget.onFinished();
      }
    });
    _controller.forward();
    _statusTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _statusIndex = (_statusIndex + 1) % _statuses.length;
      });
    });
  }

  @override
  void dispose() {
    _statusTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    return AnimatedBuilder(
      animation: _progress,
      builder: (BuildContext context, Widget? _) {
        final int percent = (_progress.value * 100).round();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _PulsingLogo(progress: _progress.value),
            const SizedBox(height: 22),
            SizedBox(
              width: 240,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(value: _progress.value),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${_statuses[_statusIndex]} ($percent%)',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.95),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Обычно занимает 15–30 секунд',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.75),
              ),
            ),
            const SizedBox(height: 10),
            Icon(Icons.auto_awesome, color: colors.tertiary),
          ],
        );
      },
    );
  }
}

class _PulsingLogo extends StatelessWidget {
  const _PulsingLogo({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final double pulse = 0.9 + (0.2 * (0.5 - (progress - 0.5).abs()) * 2);
    return Transform.scale(
      scale: pulse.clamp(0.9, 1.1),
      child: Container(
        width: 86,
        height: 86,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: <Color>[
              colors.primary,
              colors.tertiary,
              colors.secondary,
            ],
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 22,
              color: colors.primary.withValues(alpha: 0.45),
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.auto_awesome_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}

