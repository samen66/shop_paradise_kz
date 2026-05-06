import '../domain/service_hub_job.dart';
import 'service_hub_repository.dart';

class MockServiceHubRepository implements ServiceHubRepository {
  const MockServiceHubRepository();

  @override
  List<ServiceHubJob> getClientJobs() {
    return _jobs;
  }

  @override
  List<ServiceHubJob> getNearbyJobs() {
    return _jobs
        .where((ServiceHubJob job) => job.postedHoursAgo <= 24)
        .toList();
  }
}

const List<ServiceHubJob> _jobs = <ServiceHubJob>[
  ServiceHubJob(
    id: 'j001',
    title: 'Сборка угловой кухни IKEA',
    category: 'Сборка мебели',
    description: 'Нужна сборка кухни 8 секций. Товары уже доставлены.',
    budgetMin: 50000,
    budgetMax: 80000,
    address: 'Алматы, Бостандыкский район',
    postedHoursAgo: 2,
    responsesCount: 3,
    isUrgent: false,
    hasAiEstimate: true,
  ),
  ServiceHubJob(
    id: 'j002',
    title: 'Монтаж гипсокартонных перегородок',
    category: 'Ремонт и отделка',
    description: 'Перегородка между гостиной и кухней, 4м x 2.7м.',
    budgetMin: 120000,
    budgetMax: 180000,
    address: 'Алматы, Алмалинский район',
    postedHoursAgo: 20,
    responsesCount: 7,
    isUrgent: false,
    hasAiEstimate: false,
  ),
  ServiceHubJob(
    id: 'j003',
    title: 'Срочно! Замена смесителя',
    category: 'Сантехника',
    description: 'Течет смеситель на кухне. Нужен мастер сегодня.',
    budgetMin: 8000,
    budgetMax: 15000,
    address: 'Алматы, Медеуский район',
    postedHoursAgo: 1,
    responsesCount: 1,
    isUrgent: true,
    hasAiEstimate: false,
  ),
];
