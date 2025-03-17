import 'package:drs_booking/authentication/viewModel/forgot_password_view_model.dart';
import 'package:drs_booking/common/AppColors.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotPasswordViewModel forgotPasswordViewModel =
      ForgotPasswordViewModel();

  final _formKey = GlobalKey<FormState>();

  bool _isGetOtpPressed = false;

  late TextEditingController _phoneNumberController = TextEditingController();

  String _selectedCountryCode = '91';

  final List<Map<String, String>> countryCodes = [
    {'code': '91', 'name': 'India'},
    {'code': '1', 'name': 'USA'},
  ];

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordViewModel>(
      create: (BuildContext context) => forgotPasswordViewModel,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Consumer<ForgotPasswordViewModel>(
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
                                AppStrings.forgotPasswordContent,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MetrischSemiBold',
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  // Country Code Dropdown
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: const Border(
                                        bottom: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7),
                                    child: DropdownButton<String>(
                                      value: _selectedCountryCode,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedCountryCode = newValue!;
                                        });
                                      },
                                      items: countryCodes
                                          .map<DropdownMenuItem<String>>(
                                              (Map<String, String> country) {
                                        return DropdownMenuItem<String>(
                                          value: country['code']!,
                                          child: Text(
                                            country['code']!,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'MetrischSemiBold',
                                              fontSize: 19,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      dropdownColor: Colors.white,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      iconEnabledColor: Colors.black,
                                      iconSize: 24,
                                      underline: Container(),
                                    ),
                                  ),
                                  const SizedBox(width: 10), // Spacing

                                  // Phone Number Input Field
                                  Expanded(
                                    child: TextFormField(
                                      controller: _phoneNumberController,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'MetrischRegular',
                                      ),
                                      decoration: InputDecoration(
                                        labelText: AppStrings.phoneNumber,
                                        labelStyle: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontFamily: 'MetrischRegular',
                                            fontWeight: FontWeight.normal),
                                        border: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your Phone Number';
                                        } else if (value.length < 10) {
                                          return 'Please enter valid Phone Number';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              if (_isGetOtpPressed &&
                                  (_phoneNumberController.text.isEmpty ||
                                      _phoneNumberController.text.length < 10))
                                const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Please enter a valid number',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'MetrischRegular',
                                        fontSize: 12),
                                  ),
                                ),
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isGetOtpPressed = true;
                                    });
                                    if (_phoneNumberController
                                            .text.isNotEmpty &&
                                        _phoneNumberController.text.length ==
                                            10) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      // forgotPasswordViewModel
                                      //     .callForgotPasswordApi(
                                      //         _phoneNumberController.text,
                                      //         _selectedCountryCode,
                                      //         context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    backgroundColor: AppColors.customLightGreen,
                                  ),
                                  child: const Text(
                                    AppStrings.getOtp,
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
