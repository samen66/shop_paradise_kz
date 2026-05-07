import '../domain/service_hub_job.dart';

abstract class ServiceHubRepository {
  List<ServiceHubJob> getNearbyJobs();
  List<ServiceHubJob> getClientJobs();
}
