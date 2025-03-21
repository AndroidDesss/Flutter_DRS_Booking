import 'package:drs_booking/authentication/repository/sign_up_repository.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:flutter/material.dart';

class NewUserVerificationViewModel extends ChangeNotifier {
  final SignUpRepository _signUpRepository = SignUpRepository();

  String localOtp = '';

  //newUserOtpApi
//newUserOtpApi
  Future<void> callNewUserOtpApi(
      String phoneNumber, String region, BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response =
          await _signUpRepository.newUserOtpApi(phoneNumber, region);

      if (response.status == 200 &&
          response.data.isNotEmpty &&
          response.data.first.otp != null) {
        _setLocalOtp(response.data.first.otp!);
        CustomLoader.hideLoader();
      } else {
        _showErrorMessage(
            "You have not registered with this phone number..!", context);
        CustomLoader.hideLoader();
      }
    } catch (e) {
      _showErrorMessage(
          "You have not registered with this phone number..!", context);
      CustomLoader.hideLoader();
    } finally {
      CustomLoader.hideLoader();
    }
  }

  //newUserSignUpApi
  Future<void> callNewSignUpApi(
      String firstName,
      String lastName,
      String email,
      String password,
      String gender,
      String phoneNumber,
      String dateOfBirth,
      BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _signUpRepository.normalSignUpApi(firstName,
          lastName, email, password, gender, phoneNumber, dateOfBirth);

      if (response.status == 200 && response.data.isNotEmpty) {
        Navigator.pop(context);
        _showErrorMessage("Successfully Registered..!", context);
      }
    } catch (e) {
      _showErrorMessage("Error..!", context);
    } finally {
      CustomLoader.hideLoader();
    }
  }

  void _setLocalOtp(String otp) {
    localOtp = otp;
    notifyListeners();
  }

  //error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }
}
