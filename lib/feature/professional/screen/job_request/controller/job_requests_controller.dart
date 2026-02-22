import 'package:get/get.dart';

class JobRequestModel {
  final String clientName;
  final String clientImage;
  final String timeAgo;
  final String issueTitle;
  final String aiDiagnosis;
  final String address;
  final String distance;
  final String zipCode;

  const JobRequestModel({
    required this.clientName,
    required this.clientImage,
    required this.timeAgo,
    required this.issueTitle,
    required this.aiDiagnosis,
    required this.address,
    required this.distance,
    required this.zipCode,
  });
}

class JobRequestsController extends GetxController {
  final requests = <JobRequestModel>[
    const JobRequestModel(
      clientName: 'David Cohen',
      clientImage: 'assets/images/profile/profile.png',
      timeAgo: '4h ago',
      issueTitle: 'Leaking pipe under kitchen sink',
      aiDiagnosis: 'Worn seal or small crack in pipe',
      address: '15 Herzl St, Tel Aviv',
      distance: '2.3 km',
      zipCode: '1234',
    ),
    const JobRequestModel(
      clientName: 'David Cohen',
      clientImage: 'assets/images/profile/profile.png',
      timeAgo: '4h ago',
      issueTitle: 'Leaking pipe under kitchen sink',
      aiDiagnosis: 'Worn seal or small crack in pipe',
      address: '15 Herzl St, Tel Aviv',
      distance: '2.3 km',
      zipCode: '1234',
    ),
    const JobRequestModel(
      clientName: 'David Cohen',
      clientImage: 'assets/images/profile/profile.png',
      timeAgo: '4h ago',
      issueTitle: 'Leaking pipe under kitchen sink',
      aiDiagnosis: 'Worn seal or small crack in pipe',
      address: '15 Herzl St, Tel Aviv',
      distance: '2.3 km',
      zipCode: '1234',
    ),
  ].obs;

  void acceptRequest(int index) {
    requests.removeAt(index);
    // TODO: call accept API
  }

  void declineRequest(int index) {
    requests.removeAt(index);
    // TODO: call decline API
  }
}