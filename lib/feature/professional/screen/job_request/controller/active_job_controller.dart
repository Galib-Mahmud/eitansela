import 'package:get/get.dart';

enum JobProgressStatus { completed, active, pending }

class JobProgressStep {
  final int number;
  final String label;
  final String? subtitle;
  final JobProgressStatus status;

  const JobProgressStep({
    required this.number,
    required this.label,
    this.subtitle,
    required this.status,
  });
}

class ActiveJobController extends GetxController {
  final clientName = 'Michael Ben'.obs;
  final clientAddress = '22 Dizengoff St, Tel Aviv'.obs;
  final clientImage = 'assets/images/profile/profile.png'.obs;

  final detectedIssue = 'Burst Pipe (Under Sink)'.obs;
  final severity = 'High Severity'.obs;
  final estPriceMin = '₪350'.obs;
  final estPriceMax = '₪500'.obs;

  final priceFeedback = ''.obs; // 'good' | 'bad' | ''

  final jobStatus = 'Accepted'.obs;

  final progressSteps = <JobProgressStep>[
    const JobProgressStep(
      number: 1,
      label: 'Accepted',
      subtitle: 'Active now',
      status: JobProgressStatus.active,
    ),
    const JobProgressStep(
      number: 2,
      label: 'On The Way',
      status: JobProgressStatus.pending,
    ),
    const JobProgressStep(
      number: 3,
      label: 'In Progress',
      status: JobProgressStatus.pending,
    ),
    const JobProgressStep(
      number: 4,
      label: 'Completed',
      status: JobProgressStatus.pending,
    ),
  ].obs;

  void submitGoodEstimation() {
    priceFeedback.value = 'good';
  }

  void submitBadEstimation() {
    priceFeedback.value = 'bad';
  }

  void openChat() {
    // TODO: navigate to chat
  }
}