import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ServiceCreateStep1Page extends StatelessWidget {
  const ServiceCreateStep1Page({super.key, required this.fromAi});

  final bool fromAi;

  @override
  Widget build(BuildContext context) {
    final String sourceLabel = fromAi ? 'Из AI-сметы' : 'Описать вручную';
    return Scaffold(
      appBar: AppBar(title: const Text('Создание задания: шаг 1')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Что нужно сделать?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Источник: $sourceLabel'),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Название задания',
                hintText: 'Сборка угловой кухни IKEA, 8 секций',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Описание',
                hintText: 'Опишите объём работы и пожелания',
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () => context.pop(),
              child: const Text('Сохранить черновик'),
            ),
          ],
        ),
      ),
    );
  }
}
