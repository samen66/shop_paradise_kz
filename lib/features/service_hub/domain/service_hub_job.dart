class ServiceHubJob {
  const ServiceHubJob({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.budgetMin,
    required this.budgetMax,
    required this.address,
    required this.postedHoursAgo,
    required this.responsesCount,
    required this.isUrgent,
    required this.hasAiEstimate,
  });

  final String id;
  final String title;
  final String category;
  final String description;
  final int budgetMin;
  final int budgetMax;
  final String address;
  final int postedHoursAgo;
  final int responsesCount;
  final bool isUrgent;
  final bool hasAiEstimate;
}
