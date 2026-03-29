import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(const ShopParadiseApp());
}

/// Root widget: applies [AppTheme.light] for preview and future screens.
class ShopParadiseApp extends StatelessWidget {
  const ShopParadiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Paradise',
      theme: AppTheme.light,
      home: const _ThemePreviewHome(),
    );
  }
}

/// Minimal scaffold to verify colors, typography, and pill controls.
class _ThemePreviewHome extends StatelessWidget {
  const _ThemePreviewHome();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Shop Paradise')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Login', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(
                'Good to see you back!',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {},
                child: const Text('Next'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {},
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
