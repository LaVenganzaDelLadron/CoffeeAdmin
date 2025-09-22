import 'package:admincoffee/view/dashboard/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showAuthDialog({
  required String title,
  required String message,
  bool isSuccess = true,
}) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: AnimatedScale(
        scale: 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Icon(
                  isSuccess ? Icons.check_circle : Icons.error,
                  key: ValueKey<bool>(isSuccess),
                  color: isSuccess ? Colors.green : Colors.red,
                  size: 70,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSuccess ? Colors.green : Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                onPressed: () {
                  Get.back();
                  if (isSuccess) {
                    Get.offAll(() => const AdminDashboard());
                  }
                },
                child: const Text("OK"),
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false,
    transitionCurve: Curves.easeOutBack,
    transitionDuration: const Duration(milliseconds: 400),
  );
}
