import 'package:drs_booking/authentication/repository/forgot_password_repository.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:flutter/material.dart';

class ForgotPasswordVerificationViewModel extends ChangeNotifier {
  final ForgotPasswordRepository _forgotPasswordRepository =
      ForgotPasswordRepository();

  String localOtp = '';

  //reSendForgotPasswordApi
  Future<void> callReSendForgotPasswordVerificationApiViewModel(
      String phoneNumber, String region, BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _forgotPasswordRepository.forgotPasswordOtpAPi(
          phoneNumber, region);

      if (response.status == 200 &&
          response.data.isNotEmpty &&
          response.data.first.otp != null) {
        _setLocalOtp(response.data.first.otp!);
      } else {
        _showErrorMessage(
            "You have not registered with this phone number..!", context);
      }
    } catch (e) {
      _showErrorMessage(
          "You have not registered with this phone number..!", context);
    } finally {
      CustomLoader.hideLoader();
    }
  }

  //error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }

  void _setLocalOtp(String otp) {
    localOtp = otp;
    notifyListeners();
  }
}
