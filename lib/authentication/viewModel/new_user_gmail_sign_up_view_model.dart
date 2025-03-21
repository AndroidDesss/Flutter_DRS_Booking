import 'package:drs_booking/authentication/repository/sign_up_repository.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:drs_booking/common/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewUserGmailSignUpViewModel extends ChangeNotifier {
  final SignUpRepository _signUpRepository = SignUpRepository();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //newUserSignUpApi
  Future<void> callNewGmailSignUpApi(
      String firstName,
      String lastName,
      String email,
      String gender,
      String phoneNumber,
      String dateOfBirth,
      BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _signUpRepository.gmailSignUpApi(
          firstName, lastName, email, gender, phoneNumber, dateOfBirth);

      if (response.status == 200 && response.data.isNotEmpty) {
        await _signOut();
        await _clearSharedPref();
        Navigator.pop(context);
        _showErrorMessage("Successfully Registered..!", context);
      }
    } catch (e) {
      _showErrorMessage("Error..!", context);
    } finally {
      CustomLoader.hideLoader();
    }
  }

  //error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }

  Future<void> _signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<void> _clearSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await SharedPrefsHelper.clear();
    prefs.clear();
    await prefs.clear();
  }
}
