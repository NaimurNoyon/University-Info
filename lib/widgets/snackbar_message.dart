import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_info/utils/colors.dart';

class SnackBarMessage {
  static snackBarMessage(
      String message, {
        SnackPosition position = SnackPosition.BOTTOM,
      }) {
    Get.rawSnackbar(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      messageText: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 14,
          color: AppColors.colorBlack,
        ),
      ),
      backgroundColor: AppColors.colorPrimaryLight,
      duration: const Duration(seconds: 2),
      snackPosition: position,
    );
  }
}