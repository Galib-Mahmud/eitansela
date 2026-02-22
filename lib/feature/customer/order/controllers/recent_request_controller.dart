import 'package:get/get.dart';

class RecentRequestModel {
  final String iconPath;
  final String title;
  final String date;
  final String status;

  const RecentRequestModel({
    required this.iconPath,
    required this.title,
    required this.date,
    required this.status,
  });
}

class RecentRequestController extends GetxController {
  final requests = <RecentRequestModel>[
    const RecentRequestModel(
      iconPath: 'assets/images/profile/water.png',
      title: 'Kitchen Sink Leak',
      date: 'oct 24 - Complete',
      status: 'IN Process',
    ),
    const RecentRequestModel(
      iconPath: 'assets/images/profile/water.png',
      title: 'Kitchen Sink Leak',
      date: 'oct 24 - Complete',
      status: 'IN Process',
    ),
  ].obs;
}