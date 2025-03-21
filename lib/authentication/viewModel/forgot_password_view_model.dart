import 'package:drs_booking/authentication/repository/forgot_password_repository.dart';
import 'package:drs_booking/authentication/view/forgot_password_verification_screen.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final ForgotPasswordRepository _forgotPasswordRepository =
      ForgotPasswordRepository();

  //forgotPasswordApi
  Future<void> callForgotPasswordOtpApi(
      String phoneNumber, String region, BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _forgotPasswordRepository.forgotPasswordOtpAPi(
          phoneNumber, region);

      if (response.status == 200 &&
          response.data.isNotEmpty &&
          response.data.first.otp != null) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return ForgotPasswordVerificationScreen(
                  localOtp: response.data.first.otp!,
                  localRegion: region,
                  localPhoneNumber: phoneNumber);
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
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
}
