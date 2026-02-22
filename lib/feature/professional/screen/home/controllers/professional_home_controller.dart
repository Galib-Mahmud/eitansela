import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActiveJobModel {
  final String clientName;
  final String address;
  final String status;
  final String iconPath;

  const ActiveJobModel({
    required this.clientName,
    required this.address,
    required this.status,
    required this.iconPath,
  });
}

class JobRequestModel {
  final String service;
  final String date;
  final String total;
  final String distance;
  final String iconPath;

  const JobRequestModel({
    required this.service,
    required this.date,
    required this.total,
    required this.distance,
    required this.iconPath,
  });
}

class ProfessionalHomeController extends GetxController {
  final isOnline = true.obs;

  final professionalName = 'Joseph Pillado'.obs;
  final professionalImage = 'assets/images/profile/profile.png'.obs;

  final emergencyCount = 4.obs;
  final jobsCount = 4.obs;
  final rating = 4.8.obs;

  final activeJobs = <ActiveJobModel>[
    const ActiveJobModel(
      clientName: 'Michael Ben',
      address: '22 Dizengoff St, Tel Aviv',
      status: 'On the way',
      iconPath: 'assets/images/profile/water.png',
    ),
  ].obs;

  final emergencyRequests = <JobRequestModel>[
    const JobRequestModel(
      service: 'Plumbing',
      date: 'Oct 24, 2023',
      total: '₪450',
      distance: '2.3 km',
      iconPath: 'assets/images/profile/water.png',
    ),
    const JobRequestModel(
      service: 'Plumbing',
      date: 'Oct 24, 2023',
      total: '₪450',
      distance: '2.3 km',
      iconPath: 'assets/images/profile/water.png',
    ),
  ].obs;

  final newRequests = <JobRequestModel>[
    const JobRequestModel(
      service: 'Plumbing',
      date: 'Oct 24, 2023',
      total: '₪450',
      distance: '2.3 km',
      iconPath: 'assets/images/profile/water.png',
    ),
  ].obs;

  void toggleOnline(bool val) => isOnline.value = val;
}