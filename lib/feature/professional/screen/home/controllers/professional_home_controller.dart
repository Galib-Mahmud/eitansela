// lib/features/professional/home/controllers/professional_home_controller.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/endpoint/api_client.dart';
import '../../../../../core/endpoint/api_endpoint.dart';


class ProfessionalHomeController extends GetxController {
  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  // ── Observables ───────────────────────────────────────────────────
  final RxBool isLoading = false.obs;
  final RxBool isOnline  = false.obs;

  // ── Profile ───────────────────────────────────────────────────────
  final RxString professionalName  = ''.obs;
  final RxString professionalImage = ''.obs;
  final RxString professionalRole  = 'Professional'.obs;

  // ── Stats ─────────────────────────────────────────────────────────
  final RxInt    emergencyCount = 0.obs;
  final RxInt    jobsCount      = 0.obs;
  final RxDouble rating         = 0.0.obs;

  // ── Lists ─────────────────────────────────────────────────────────
  final RxList<Map<String, dynamic>> activeJobs        = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> emergencyRequests = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> newRequests       = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> privateRequests   = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    fetchHomepage();
  }

  // ── Fetch Profile ─────────────────────────────────────────────────
  Future<void> fetchProfile() async {
    try {
      print('👤 [PRO PROFILE] Fetching...');

      final response = await _apiClient.get(ApiEndpoint.providerProfile);

      print('✅ [PRO PROFILE] Response: $response');

      // Response is a list, take first item
      if (response is List && response.isNotEmpty) {
        final profile = Map<String, dynamic>.from(response[0]);

        professionalName.value  = profile['full_name'] ?? 'Professional';
        professionalImage.value = profile['profile_photo'] ?? '';
        professionalRole.value  = profile['category_name'] ?? 'Professional';

        // Use rating from profile if available
        final profileRating = double.tryParse(profile['rating']?.toString() ?? '0') ?? 0.0;
        if (profileRating > 0) rating.value = profileRating;

        print('👤 Name  : ${professionalName.value}');
        print('📸 Photo : ${professionalImage.value}');
      }

    } on HttpException catch (e) {
      print('❌ [PRO PROFILE] HttpException: ${e.message}');
    } catch (e) {
      print('❌ [PRO PROFILE] Error: $e');
    }
  }

  // ── Fetch Homepage ────────────────────────────────────────────────
  Future<void> fetchHomepage() async {
    try {
      isLoading.value = true;

      print('🏠 [PRO HOME] Fetching...');

      final response = await _apiClient.get(ApiEndpoint.proHomepage);

      print('✅ [PRO HOME] Response: $response');

      // ── Online status ────────────────────────────────────────────
      isOnline.value = response['is_online'] ?? false;

      // ── Stats ────────────────────────────────────────────────────
      final stats = response['stats'] ?? {};
      emergencyCount.value = stats['emergency_count'] ?? 0;
      jobsCount.value      = stats['active_jobs_count'] ?? 0;
      final apiRating      = double.tryParse(stats['rating']?.toString() ?? '0') ?? 0.0;
      if (apiRating > 0) rating.value = apiRating;

      // ── Lists ────────────────────────────────────────────────────
      activeJobs.value = List<Map<String, dynamic>>.from(
        (response['active_jobs'] ?? []).map((e) => Map<String, dynamic>.from(e)),
      );
      emergencyRequests.value = List<Map<String, dynamic>>.from(
        (response['emergency_requests'] ?? []).map((e) => Map<String, dynamic>.from(e)),
      );
      newRequests.value = List<Map<String, dynamic>>.from(
        (response['new_requests'] ?? []).map((e) => Map<String, dynamic>.from(e)),
      );
      privateRequests.value = List<Map<String, dynamic>>.from(
        (response['private_requests'] ?? []).map((e) => Map<String, dynamic>.from(e)),
      );

      print('🔧 Active Jobs        : ${activeJobs.length}');
      print('🚨 Emergency Requests : ${emergencyRequests.length}');
      print('🆕 New Requests       : ${newRequests.length}');
      print('🔒 Private Requests   : ${privateRequests.length}');

    } on HttpException catch (e) {
      print('❌ [PRO HOME] HttpException: ${e.message}');
      Get.snackbar('Error', e.message);
    } catch (e) {
      print('❌ [PRO HOME] Error: $e');
      Get.snackbar('Error', 'Something went wrong.');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Toggle Online ─────────────────────────────────────────────────
  void toggleOnline(bool val) {
    isOnline.value = val;
    print('🔄 [ONLINE STATUS] Changed to: $val');
    // TODO: call PATCH /services/providers/toggle-online/ if API exists
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
}