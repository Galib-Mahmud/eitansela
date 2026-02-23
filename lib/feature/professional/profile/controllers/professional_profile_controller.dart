import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProfessionalProfileScreenController extends GetxController {
  var userName = 'Michael Ben'.obs;
  var userEmail = 'michealben@gmail.com'.obs;
  var userPhone = '+1 234 567 890'.obs;
  var userImage = 'assets/images/profile.png'.obs;

  // Stats
  var emergencyCount = 4.obs;
  var jobsCount = 342.obs;
  var rating = 4.8.obs;

  // Delete account
  var isDeleteChecked = false.obs;

  void toggleDeleteCheck(bool value) => isDeleteChecked.value = value;

  void confirmDeleteAccount() {
    Get.back();
    // TODO: call your delete account API here
  }

  void showDeleteAccountDialog(BuildContext context) {
    isDeleteChecked.value = false; // reset checkbox each time dialog opens
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => _DeleteAccountDialog(controller: this),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Log Out', style: TextStyle(color: Color(0xFFE53935))),
          ),
        ],
      ),
    );
  }
}


class _DeleteAccountDialog extends StatelessWidget {
  final ProfessionalProfileScreenController controller;

  const _DeleteAccountDialog({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close, color: Color(0xFF9E9E9E), size: 22),
                ),
              ),
              const SizedBox(height: 4),

              // Trash icon
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFEBEE),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.delete_outline, color: Color(0xFFE53935), size: 28),
              ),
              const SizedBox(height: 16),

              // Title
              const Text(
                'Delete Account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF212121)),
              ),
              const SizedBox(height: 10),

              // Subtitle
              const Text(
                'This will permanently delete your account and all associated data. This action cannot be undone.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Color(0xFF6B7280), height: 1.5),
              ),
              const SizedBox(height: 16),

              // GDPR notice
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.warning_amber_rounded, color: Color(0xFFB45309), size: 18),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Under GDPR (Art. 17), you have the right to erasure. Deleting your account will remove all personal data we hold about you within 30 days.',
                        style: TextStyle(fontSize: 12, color: Color(0xFFB45309), height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Checkbox
              Obx(() => GestureDetector(
                onTap: () => controller.toggleDeleteCheck(!controller.isDeleteChecked.value),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: controller.isDeleteChecked.value
                            ? const Color(0xFF1565C0)
                            : Colors.white,
                        border: Border.all(
                          color: controller.isDeleteChecked.value
                              ? const Color(0xFF1565C0)
                              : const Color(0xFFBDBDBD),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: controller.isDeleteChecked.value
                          ? const Icon(Icons.check, color: Colors.white, size: 14)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'I understand this is permanent and irreversible',
                        style: TextStyle(fontSize: 13, color: Color(0xFF212121)),
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 20),

              // Delete button
              Obx(() => GestureDetector(
                onTap: controller.isDeleteChecked.value ? controller.confirmDeleteAccount : null,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: controller.isDeleteChecked.value
                        ? const Color(0xFFE53935)
                        : const Color(0xFFEF9A9A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Delete My Account',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              )),
              const SizedBox(height: 10),

              // Cancel button
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF212121)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}