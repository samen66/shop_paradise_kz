import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../features/ai_design/providers/ai_design_provider.dart';
import '../../domain/service_hub_job.dart';
import '../../domain/service_hub_role.dart';
import '../providers/service_hub_providers.dart';

class ServiceHubPage extends ConsumerWidget {
  const ServiceHubPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    final ServiceHubRole currentRole = ref.watch(serviceHubRoleProvider);
    final AiDesignState aiState = ref.watch(aiDesignProvider);
    final List<ServiceHubJob> clientJobs = ref.watch(clientJobsProvider);
    final List<ServiceHubJob> nearbyJobs = ref.watch(nearbyJobsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Маркетплейс услуг')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _RoleSwitcher(
            currentRole: currentRole,
            onRoleChanged: (ServiceHubRole role) {
              ref.read(serviceHubRoleProvider.notifier).setRole(role);
            },
          ),
          const SizedBox(height: 16),
          if (currentRole.isClient) ...<Widget>[
            _ClientBanner(
              onCreateTap: () => context.push('/services/create/step1'),
            ),
            const SizedBox(height: 12),
            if (aiState.result != null)
              _AiEstimateBridgeCard(
                productsCount: aiState.result!.products.length,
                total: aiState.grandTotal,
                onTap: () => context.push('/services/create/step1?fromAi=true'),
              ),
            const SizedBox(height: 12),
            const _SectionTitle(
              title: 'Мои задания',
              actionTitle: 'Посмотреть все',
            ),
            const SizedBox(height: 8),
            ...clientJobs
                .take(3)
                .map(
                  (ServiceHubJob job) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _JobPreviewCard(
                      job: job,
                      accentColor: colors.primary,
                      actionLabel: 'Смотреть отклики',
                    ),
                  ),
                ),
          ],
          if (currentRole.isMaster) ...<Widget>[
            const _MasterStatusCard(),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => context.push('/services/jobs'),
              icon: const Icon(Icons.search),
              label: const Text('Найти задания'),
            ),
            const SizedBox(height: 12),
            const _SectionTitle(
              title: 'Новые задания рядом',
              actionTitle: 'Смотреть все',
            ),
            const SizedBox(height: 8),
            ...nearbyJobs
                .take(3)
                .map(
                  (ServiceHubJob job) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _JobPreviewCard(
                      job: job,
                      accentColor: colors.tertiary,
                      actionLabel: 'Откликнуться',
                    ),
                  ),
                ),
          ],
        ],
      ),
    );
  }
}

class _RoleSwitcher extends StatelessWidget {
  const _RoleSwitcher({required this.currentRole, required this.onRoleChanged});

  final ServiceHubRole currentRole;
  final ValueChanged<ServiceHubRole> onRoleChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ServiceHubRole>(
      segments: const <ButtonSegment<ServiceHubRole>>[
        ButtonSegment<ServiceHubRole>(
          value: ServiceHubRole.client,
          icon: Icon(Icons.home_outlined),
          label: Text('Заказчик'),
        ),
        ButtonSegment<ServiceHubRole>(
          value: ServiceHubRole.master,
          icon: Icon(Icons.handyman_outlined),
          label: Text('Исполнитель'),
        ),
      ],
      selected: <ServiceHubRole>{currentRole},
      onSelectionChanged: (Set<ServiceHubRole> value) {
        if (value.isEmpty) {
          return;
        }
        onRoleChanged(value.first);
      },
    );
  }
}

class _ClientBanner extends StatelessWidget {
  const _ClientBanner({required this.onCreateTap});

  final VoidCallback onCreateTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Опубликуй задание - мастера сами напишут',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: onCreateTap,
              icon: const Icon(Icons.add),
              label: const Text('Создать задание'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AiEstimateBridgeCard extends StatelessWidget {
  const _AiEstimateBridgeCard({
    required this.productsCount,
    required this.total,
    required this.onTap,
  });

  final int productsCount;
  final int total;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.auto_awesome_outlined),
        title: const Text('У вас готова смета от AI'),
        subtitle: Text('$productsCount позиций, ~${_formatKzt(total)}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _MasterStatusCard extends StatelessWidget {
  const _MasterStatusCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: <Widget>[
            const CircleAvatar(child: Icon(Icons.person_outline)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Рейтинг 4.8 | 120 заказов | Баланс 45 000 ₸',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('Вывести')),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.actionTitle});

  final String title;
  final String actionTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        TextButton(onPressed: () {}, child: Text(actionTitle)),
      ],
    );
  }
}

class _JobPreviewCard extends StatelessWidget {
  const _JobPreviewCard({
    required this.job,
    required this.accentColor,
    required this.actionLabel,
  });

  final ServiceHubJob job;
  final Color accentColor;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    job.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                if (job.isUrgent)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Срочно',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(job.description),
            const SizedBox(height: 6),
            Text(
              '${_formatKzt(job.budgetMin)} - ${_formatKzt(job.budgetMax)}',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: accentColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${job.responsesCount} отклика • ${job.address}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SizedBox(
                  width: 140,
                  height: 40,
                  child: FilledButton.tonal(
                    onPressed: () {},
                    child: Text(actionLabel),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String _formatKzt(int amount) {
  return '${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ')} ₸';
}
