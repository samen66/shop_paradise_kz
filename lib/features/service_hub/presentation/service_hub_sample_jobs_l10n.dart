import '../../../l10n/app_localizations.dart';

/// Demo job cards on [ServiceHubPage] second tab.
extension ServiceHubSampleJobsL10n on AppLocalizations {
  static const int sampleJobCount = 3;

  ({String customer, String title, String snippet}) serviceHubSampleJob(int index) {
    return switch (index) {
      0 => (
          customer: serviceHubSampleJob1Customer,
          title: serviceHubSampleJob1Title,
          snippet: serviceHubSampleJob1Snippet,
        ),
      1 => (
          customer: serviceHubSampleJob2Customer,
          title: serviceHubSampleJob2Title,
          snippet: serviceHubSampleJob2Snippet,
        ),
      2 => (
          customer: serviceHubSampleJob3Customer,
          title: serviceHubSampleJob3Title,
          snippet: serviceHubSampleJob3Snippet,
        ),
      _ => (customer: '', title: '', snippet: ''),
    };
  }
}
