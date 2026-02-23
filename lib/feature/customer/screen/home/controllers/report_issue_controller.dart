import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/report_issue_dialog.dart';

class ReportIssueController extends GetxController {
  final additionalDetailsController = TextEditingController();
  final selectedReason = 0.obs; // 0 = Ghost Lead, 1 = Bad Lead, 2 = Other

  final reasons = [
    'Ghost Lead - No response from customer',
    'Bad Lead - Incorrect information',
    'Other',
  ];

  @override
  void onClose() {
    additionalDetailsController.dispose();
    super.onClose();
  }

  void selectReason(int index) => selectedReason.value = index;

  void submitReport() {
    Get.back();
    // TODO: call report API with selectedReason and additionalDetailsController.text
  }

  // Static method to show the dialog
  static void show(BuildContext context, {String jobType = 'Plumbing'}) {
    final c = Get.put(ReportIssueController());
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ReportIssueDialog(controller: c, jobType: jobType),
    );
  }
}