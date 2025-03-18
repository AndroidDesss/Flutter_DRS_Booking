import 'package:drs_booking/authentication/view/change_password_screen.dart';
import 'package:drs_booking/authentication/viewModel/forgot_password_verification_view_model.dart';
import 'package:drs_booking/common/AppColors.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordVerificationScreen extends StatefulWidget {
  const ForgotPasswordVerificationScreen({super.key});

  @override
  _ForgotPasswordVerificationScreenState createState() =>
      _ForgotPasswordVerificationScreenState();
}

class _ForgotPasswordVerificationScreenState
    extends State<ForgotPasswordVerificationScreen> {
  final ForgotPasswordVerificationViewModel
      forgotPasswordVerificationViewModel =
      ForgotPasswordVerificationViewModel();

  final _formKey = GlobalKey<FormState>();

  final _otpController1 = TextEditingController();
  final _otpController2 = TextEditingController();
  final _otpController3 = TextEditingController();
  final _otpController4 = TextEditingController();
  final _otpController5 = TextEditingController();
  final _otpController6 = TextEditingController();

  Widget buildOTPField(TextEditingController controller) {
    return SizedBox(
      width: 45, // Adjust width as needed
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "", // Hide counter
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            fontFamily: 'MetrischRegular'),
        onChanged: (value) {
          if (value.length >= 1) {
            FocusScope.of(context).nextFocus();
          } else if (value.length < 1) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordVerificationViewModel>(
      create: (BuildContext context) => forgotPasswordVerificationViewModel,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Consumer<ForgotPasswordVerificationViewModel>(
            builder: (context, viewModel, child) {
              return Stack(
                children: [
                  Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/forgot_password_vector.png',
                                width: 180,
                                height: 170,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                AppStrings.verificationContent,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MetrischSemiBold',
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 25),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 10),
                                    buildOTPField(_otpController1),
                                    const SizedBox(width: 10),
                                    buildOTPField(_otpController2),
                                    const SizedBox(width: 10),
                                    buildOTPField(_otpController3),
                                    const SizedBox(width: 10),
                                    buildOTPField(_otpController4),
                                    const SizedBox(width: 10),
                                    buildOTPField(_otpController5),
                                    const SizedBox(width: 10),
                                    buildOTPField(_otpController6),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _otpController1.clear();
                                      _otpController2.clear();
                                      _otpController3.clear();
                                      _otpController4.clear();
                                      _otpController5.clear();
                                      _otpController6.clear();
                                    });
                                    // forgotPasswordVerificationViewModel
                                    //     .callReSendForgotPasswordVerificationApiViewModel(
                                    //   widget.localUserName,
                                    //   context,
                                    // );
                                  },
                                  child: const Text(
                                    AppStrings.reSendOtp,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: 'MetrischSemiBold',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // if (_formKey.currentState?.validate() ??
                                    //     false) {
                                    //   String enteredOtp = _otpController1.text +
                                    //       _otpController2.text +
                                    //       _otpController3.text +
                                    //       _otpController4.text +
                                    //       _otpController5.text +
                                    //       _otpController6.text;
                                    //   String correctOtp = viewModel.localOtp;
                                    //   if (enteredOtp == correctOtp) {
                                    //     CommonUtilities.showToast(context,
                                    //         message: "Success..!");
                                    //     Navigator.pushReplacement(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             ChangePasswordScreen(
                                    //                 localId: widget.localId),
                                    //       ),
                                    //     );
                                    //   } else {
                                    //     CommonUtilities.showToast(context,
                                    //         message:
                                    //             "Invalid OTP. Please try again.");
                                    //   }
                                    // } else {
                                    //   CommonUtilities.showToast(context,
                                    //       message: otpFieldErrorContent);
                                    // }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    backgroundColor: AppColors.customLightGreen,
                                  ),
                                  child: const Text(
                                    AppStrings.verifyProceed,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'MetrischSemiBold',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
