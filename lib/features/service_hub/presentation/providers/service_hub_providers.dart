import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/mock_service_hub_repository.dart';
import '../../data/service_hub_repository.dart';
import '../../domain/service_hub_job.dart';
import '../../domain/service_hub_role.dart';

final Provider<ServiceHubRepository> serviceHubRepositoryProvider =
    Provider<ServiceHubRepository>((Ref ref) {
      return const MockServiceHubRepository();
    });

final NotifierProvider<ServiceHubRoleNotifier, ServiceHubRole>
serviceHubRoleProvider =
    NotifierProvider<ServiceHubRoleNotifier, ServiceHubRole>(
      ServiceHubRoleNotifier.new,
    );

class ServiceHubRoleNotifier extends Notifier<ServiceHubRole> {
  @override
  ServiceHubRole build() {
    return ServiceHubRole.client;
  }

  void setRole(ServiceHubRole role) {
    state = role;
  }
}

final Provider<List<ServiceHubJob>> clientJobsProvider =
    Provider<List<ServiceHubJob>>((Ref ref) {
      final ServiceHubRepository repository = ref.watch(
        serviceHubRepositoryProvider,
      );
      return repository.getClientJobs();
    });

final Provider<List<ServiceHubJob>> nearbyJobsProvider =
    Provider<List<ServiceHubJob>>((Ref ref) {
      final ServiceHubRepository repository = ref.watch(
        serviceHubRepositoryProvider,
      );
      return repository.getNearbyJobs();
    });
