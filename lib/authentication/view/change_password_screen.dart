import 'package:drs_booking/authentication/viewModel/change_password_view_model.dart';
import 'package:drs_booking/common/AppColors.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String localPhoneNumber;

  const ChangePasswordScreen({super.key, required this.localPhoneNumber});

  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePasswordViewModel changePasswordViewModel =
      ChangePasswordViewModel();

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _passwordController = TextEditingController();
  late TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangePasswordViewModel>(
      create: (BuildContext context) => changePasswordViewModel,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Consumer<ChangePasswordViewModel>(
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
                                AppStrings.changePasswordContentText,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MetrischSemiBold',
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 25),
                              TextFormField(
                                controller: _passwordController,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MetrischRegular',
                                ),
                                decoration: InputDecoration(
                                  labelText: AppStrings.password,
                                  labelStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontFamily: 'MetrischRegular',
                                      fontWeight: FontWeight.normal),
                                  border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  } else if (value == null ||
                                      value.length < 8) {
                                    return 'Please enter minimum 8 digits';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                controller: _confirmPasswordController,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MetrischRegular',
                                ),
                                decoration: InputDecoration(
                                  labelText: AppStrings.confirmPassword,
                                  labelStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontFamily: 'MetrischRegular',
                                      fontWeight: FontWeight.normal),
                                  border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your confirm password';
                                  } else if (value == null ||
                                      value.length < 8) {
                                    return 'Please enter minimum 8 digits';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      if (_passwordController.text ==
                                          _confirmPasswordController.text) {
                                        changePasswordViewModel
                                            .callChangePasswordApi(
                                                widget.localPhoneNumber,
                                                _confirmPasswordController.text,
                                                context);
                                      } else {
                                        CommonUtilities.showToast(context,
                                            message:
                                                AppStrings.passwordNotMatch);
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    backgroundColor: AppColors.customLightGreen,
                                  ),
                                  child: const Text(
                                    AppStrings.confirm,
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
