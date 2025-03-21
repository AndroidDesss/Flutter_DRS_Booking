import 'package:drs_booking/authentication/repository/change_password_repository.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:flutter/material.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final ChangePasswordRepository _changePasswordRepository =
      ChangePasswordRepository();

  //login
  Future<void> callChangePasswordApi(
      String phoneNumber, String password, BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response =
          await _changePasswordRepository.changePassword(phoneNumber, password);

      if (response.status == 200) {
        _showErrorMessage("Successfully Changed..!", context);
        Navigator.pop(context);
      }
    } catch (e) {
      _showErrorMessage("Credentials Wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
    }
  }

  //error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }
}
