import 'package:get/get.dart';

class NotificationModel {
  final String title;
  final String message;
  final String time;
  final bool isRead;

  const NotificationModel({
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });
}

class NotificationsController extends GetxController {
  final notifications = <NotificationModel>[
    const NotificationModel(
      title: 'Reminder!',
      message: 'Your Kitchen Sink Leak request is now In Process.',
      time: '2 days ago',
    ),
    const NotificationModel(
      title: 'Reminder!',
      message: 'Your Kitchen Sink Leak request is now In Process.',
      time: '2 days ago',
    ),
  ].obs;
}