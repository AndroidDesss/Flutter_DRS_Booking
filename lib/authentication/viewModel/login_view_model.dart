import 'package:drs_booking/authentication/repository/login_repository.dart';
import 'package:drs_booking/authentication/view/new_user_gmail_sign_up_screen.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:drs_booking/common/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository _loginRepository = LoginRepository();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //login
  Future<void> callLoginApi(
      String email, String password, BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _loginRepository.login(email, password);

      if (response.status == 200) {
        if (response.data.first.verifyPhone == "No" ||
            response.data.first.verifyPhone == "no") {
        } else {
          String age = calculateAge(response.data.first.dob);
          await SharedPrefsHelper.init();
          await SharedPrefsHelper.setString('user_id', response.data.first.id);
          await SharedPrefsHelper.setString('loginType', 'normal');
          await SharedPrefsHelper.setString(
              'is_insurance', response.data.first.isInsurance);
          await SharedPrefsHelper.setString(
              'phoneNumber', response.data.first.phone);
          await SharedPrefsHelper.setString(
              'dateOfBirth', response.data.first.dob);
          await SharedPrefsHelper.setString('ageLimit', age);
          Navigator.pop(context);
        }
      }
    } catch (e) {
      _showErrorMessage("Credentials Wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
    }
  }

  //login
  Future<void> callGmailLoginApi(
      String email, String userName, BuildContext context) async {
    try {
      final response = await _loginRepository.gmailLogin(email, userName);

      if (response.status == 200) {
        String age = calculateAge(response.data.first.dob);
        await SharedPrefsHelper.init();
        await SharedPrefsHelper.setString('user_id', response.data.first.id);
        await SharedPrefsHelper.setString('loginType', 'emailSignIn');
        await SharedPrefsHelper.setString(
            'is_insurance', response.data.first.isInsurance);
        await SharedPrefsHelper.setString(
            'phoneNumber', response.data.first.phone);
        await SharedPrefsHelper.setString(
            'dateOfBirth', response.data.first.dob);
        await SharedPrefsHelper.setString('ageLimit', age);
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return NewUserGmailSignUpScreen(
                localName: userName, localEmail: email);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
    } finally {
      CustomLoader.hideLoader();
    }
  }

  //error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      CustomLoader.showLoader(context);
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      CustomLoader.hideLoader();
      print("Error signing in with Google: $e");
      return null;
    }
  }

  String calculateAge(String dateOfBirth) {
    List<String> separated = dateOfBirth.split("/");
    int month = int.parse(separated[0]);
    int day = int.parse(separated[1]);
    int year = int.parse(separated[2]);

    DateTime dob = DateTime(year, month, day);
    DateTime today = DateTime.now();

    int age = today.year - dob.year;
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age.toString();
  }
}
