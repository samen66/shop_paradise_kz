import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/service_hub_role.dart';
import '../providers/service_hub_providers.dart';

class ServiceRoleSelectPage extends ConsumerWidget {
  const ServiceRoleSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выбор роли')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16),
            _RoleCard(
              icon: Icons.home_work_outlined,
              title: 'Я заказчик',
              subtitle: 'Ищу мастеров для ремонта и сборки мебели',
              onTap: () {
                ref
                    .read(serviceHubRoleProvider.notifier)
                    .setRole(ServiceHubRole.client);
                context.go('/services');
              },
            ),
            const SizedBox(height: 12),
            _RoleCard(
              icon: Icons.handyman_outlined,
              title: 'Я исполнитель',
              subtitle: 'Ищу заказы и хочу зарабатывать на навыках',
              onTap: () {
                ref
                    .read(serviceHubRoleProvider.notifier)
                    .setRole(ServiceHubRole.master);
                context.go('/services');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, size: 30),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(subtitle),
            const SizedBox(height: 10),
            FilledButton(onPressed: onTap, child: const Text('Выбрать')),
          ],
        ),
      ),
    );
  }
}
