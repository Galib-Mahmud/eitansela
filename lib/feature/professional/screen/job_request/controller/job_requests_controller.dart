// lib/features/professional/job_requests/controller/job_requests_controller.dart

import 'dart:io';

import 'package:get/get.dart';
import '../../../../../core/endpoint/api_client.dart';
import '../../../../../core/endpoint/api_endpoint.dart';


class JobRequestsController extends GetxController {
  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  // ── Observables ───────────────────────────────────────────────────
  final RxBool isLoading = false.obs;

  final RxList<Map<String, dynamic>> activeAndCompleted = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> newLeads           = <Map<String, dynamic>>[].obs;

  // Combined list for display (active/completed first, then new leads)
  RxList<Map<String, dynamic>> get requests {
    return <Map<String, dynamic>>[
      ...activeAndCompleted,
      ...newLeads,
    ].obs;
  }

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  // ── Fetch All Requests ────────────────────────────────────────────
  Future<void> fetchRequests() async {
    try {
      isLoading.value = true;

      print('📋 [PRO REQUESTS] Fetching...');

      final response = await _apiClient.get(ApiEndpoint.proRequests);

      print('✅ [PRO REQUESTS] Response: $response');

      activeAndCompleted.value = List<Map<String, dynamic>>.from(
        (response['active_and_completed'] ?? []).map((e) => Map<String, dynamic>.from(e)),
      );

      newLeads.value = List<Map<String, dynamic>>.from(
        (response['new_leads'] ?? []).map((e) => Map<String, dynamic>.from(e)),
      );

      print('🔧 Active/Completed : ${activeAndCompleted.length}');
      print('🆕 New Leads        : ${newLeads.length}');

    } on HttpException catch (e) {
      print('❌ [PRO REQUESTS] HttpException: ${e.message}');
      Get.snackbar('Error', e.message);
    } catch (e) {
      print('❌ [PRO REQUESTS] Error: $e');
      Get.snackbar('Error', 'Something went wrong.');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Accept Request ────────────────────────────────────────────────
  Future<void> acceptRequest(int requestId) async {
    try {
      print('✅ [ACCEPT] Request ID: $requestId');

      // TODO: call accept API when endpoint is available
      // await _apiClient.post('/services/requests/$requestId/accept/');

      // Remove from newLeads locally
      newLeads.removeWhere((r) => r['id'] == requestId);

      Get.snackbar('Success', 'Request accepted!');
      print('✅ [ACCEPT] Done');

    } on HttpException catch (e) {
      print('❌ [ACCEPT] Error: ${e.message}');
      Get.snackbar('Error', e.message);
    } catch (e) {
      print('❌ [ACCEPT] Error: $e');
    }
  }

  // ── Decline Request ───────────────────────────────────────────────
  Future<void> declineRequest(int requestId) async {
    try {
      print('❌ [DECLINE] Request ID: $requestId');

      // TODO: call decline API when endpoint is available
      // await _apiClient.post('/services/requests/$requestId/decline/');

      // Remove from newLeads locally
      newLeads.removeWhere((r) => r['id'] == requestId);

      Get.snackbar('Declined', 'Request declined.');
      print('✅ [DECLINE] Done');

    } on HttpException catch (e) {
      print('❌ [DECLINE] Error: ${e.message}');
      Get.snackbar('Error', e.message);
    } catch (e) {
      print('❌ [DECLINE] Error: $e');
    }
  }

  // ── Helper: icon string → asset path ─────────────────────────────
  static String assetFromIcon(String icon) {
    const map = {
      'water_drop'     : 'assets/images/profile/water.png',
      'bolt'           : 'assets/images/profile/2.png',
      'ac_unit'        : 'assets/images/profile/3.png',
      'palette'        : 'assets/images/profile/7.png',
      'local_shipping' : 'assets/images/profile/8.png',
      'eco'            : 'assets/images/profile/12.png',
    };
    return map[icon] ?? 'assets/images/profile/water.png';
  }

  // ── Helper: status string → JobStatus ────────────────────────────
  static JobStatus statusFromString(String status) {
    switch (status.toUpperCase()) {
      case 'COMPLETED' : return JobStatus.completed;
      case 'IN_PROCESS':
      case 'CONFIRMED' : return JobStatus.inProcess;
      default          : return JobStatus.pending;
    }
  }

  // ── Total count for badge ─────────────────────────────────────────
  int get totalCount => activeAndCompleted.length + newLeads.length;
}

enum JobStatus { pending, completed, inProcess }