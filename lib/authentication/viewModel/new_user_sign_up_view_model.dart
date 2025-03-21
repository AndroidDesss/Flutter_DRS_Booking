import 'package:drs_booking/authentication/repository/sign_up_repository.dart';
import 'package:drs_booking/authentication/view/new_user_verification_screen.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:flutter/material.dart';

class NewUserSignUpViewModel extends ChangeNotifier {
  final SignUpRepository _signUpRepository = SignUpRepository();

  //Check User
  Future<void> callCheckUserApi(
      String email,
      String phoneNumber,
      String region,
      String firstName,
      String lastName,
      String password,
      String gender,
      String dateOfBirth,
      BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _signUpRepository.checkUser(email, phoneNumber);
      if (response.status == 200) {
        if (response.data.first.msg == 'You can go ahead') {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return NewUserVerificationScreen(
                  localPhoneNumber: phoneNumber,
                  localRegion: region,
                  localFirstName: firstName,
                  localLastName: lastName,
                  localEmail: email,
                  localPassword: password,
                  localGender: gender,
                  localDateOfBirth: dateOfBirth,
                );
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            ),
          );
        }
      }
    } catch (e) {
      _showErrorMessage("Already Registered..!", context);
    } finally {
      CustomLoader.hideLoader();
    }
  }

  //error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }
}
