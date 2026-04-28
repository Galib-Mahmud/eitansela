// lib/features/request/controller/request_controller.dart

import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/endpoint/api_client.dart';
import '../../../../../core/endpoint/api_endpoint.dart';
import '../../../../../routes/route_name.dart';
class RequestController extends GetxController {
  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);
  final ImagePicker _picker = ImagePicker();

  // ── Observables ───────────────────────────────────────────────────
  final RxList<XFile>           selectedImages = <XFile>[].obs;
  final RxBool                  isEmergency    = false.obs;
  final RxBool                  canCall        = false.obs;
  final RxBool                  isLoading      = false.obs;
  final Rx<Map<String, dynamic>?> createdRequest = Rx<Map<String, dynamic>?>(null);

  // ── Pick Images ───────────────────────────────────────────────────
  Future<void> pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (images.isEmpty) return;

      final int remaining = 5 - selectedImages.length;
      if (remaining <= 0) {
        Get.snackbar('Limit Reached', 'You can upload a maximum of 5 images.');
        return;
      }
      selectedImages.addAll(images.take(remaining));
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick images.');
    }
  }

  void removeImage(int index) => selectedImages.removeAt(index);

  // ── Submit ────────────────────────────────────────────────────────
  Future<void> submitRequest({
    required int    serviceId,
    required String description,
    required String address,
    required String zipCode,
    required String phoneNumber,
  }) async {
    // ── Validation ────────────────────────────────────────────────
    if (description.trim().isEmpty) {
      Get.snackbar('Missing Info', 'Please describe your problem.'); return;
    }
    if (address.trim().isEmpty) {
      Get.snackbar('Missing Info', 'Please enter your address.'); return;
    }
    if (zipCode.trim().isEmpty) {
      Get.snackbar('Missing Info', 'Please enter your zip code.'); return;
    }
    if (phoneNumber.trim().isEmpty) {
      Get.snackbar('Missing Info', 'Please enter your phone number.'); return;
    }

    try {
      isLoading.value = true;

      // ── Step 1: Create request ────────────────────────────────
      final Map<String, dynamic> response = await _apiClient.post(
        ApiEndpoint.createRequest,
        body: {
          "service"           : serviceId,
          "description"       : description,
          "address"           : address,
          "zip_code"          : zipCode,
          "phone_number"      : phoneNumber,
          "no_call_just_chat" : !canCall.value,
          "mark_as_priority"  : isEmergency.value,
        },
      );

      createdRequest.value = response;
      final int requestId = response['id'];

      // ── Step 2: Upload images (if any) ────────────────────────
      if (selectedImages.isNotEmpty) {
        for (final xFile in selectedImages) {
          await _apiClient.multipart(
            ApiEndpoint.uploadMedia,
            method: 'POST',
            fields: {"request": requestId.toString()},
            files: {"file": File(xFile.path)},
          );
        }
      }

      // ── Step 3: Navigate ──────────────────────────────────────
      Get.toNamed(RouteName.newRequestAnalysis);

    } on HttpException catch (e) {
      Get.snackbar('Error', e.message);
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Reset ─────────────────────────────────────────────────────────
  void reset() {
    selectedImages.clear();
    isEmergency.value    = false;
    canCall.value        = false;
    createdRequest.value = null;
  }
}