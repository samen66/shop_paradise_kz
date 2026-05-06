import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/service_hub_job.dart';
import '../providers/service_hub_providers.dart';

class ServiceJobsFeedPage extends ConsumerWidget {
  const ServiceJobsFeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ServiceHubJob> jobs = ref.watch(nearbyJobsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Лента заданий')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: jobs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (BuildContext context, int index) {
          final ServiceHubJob job = jobs[index];
          return ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            title: Text(job.title),
            subtitle: Text(
              '${job.address}\n${job.description}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right),
          );
        },
      ),
    );
  }
}
