import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(String title, String body) {
  Get.snackbar(
    title,
    body,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(milliseconds: 1500),
    icon: const Icon(Icons.notifications),
  );
}
