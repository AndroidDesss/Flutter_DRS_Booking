import 'package:drs_booking/common/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

class CommonUtilities {
  static void showToast(
    BuildContext context, {
    required String message,
  }) {
    toastification.show(
      context: context,
      backgroundColor: AppColors.customDarkBlue,
      title: Text(
        message,
        style: const TextStyle(
            fontSize: 14.0, color: Colors.white, fontFamily: 'PoppinsSemiBold'),
      ),
      autoCloseDuration: const Duration(seconds: 3),
      showIcon: false,
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.none,
      alignment: Alignment.bottomCenter, // Set the toast position here
    );
  }

  static String getCurrentDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('MM-dd-yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}
