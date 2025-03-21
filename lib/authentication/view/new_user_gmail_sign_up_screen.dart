import 'package:drs_booking/authentication/viewModel/new_user_gmail_sign_up_view_model.dart';
import 'package:drs_booking/common/AppColors.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewUserGmailSignUpScreen extends StatefulWidget {
  final String localName;
  final String localEmail;

  const NewUserGmailSignUpScreen(
      {super.key, required this.localName, required this.localEmail});

  @override
  _NewUserGmailSignUpScreenState createState() =>
      _NewUserGmailSignUpScreenState();
}

class _NewUserGmailSignUpScreenState extends State<NewUserGmailSignUpScreen> {
  final NewUserGmailSignUpViewModel newUserGmailSignUpViewModel =
      NewUserGmailSignUpViewModel();

  final _formKey = GlobalKey<FormState>();

  String selectedGender = 'Male';

  late final TextEditingController _firstNameController =
      TextEditingController(text: widget.localName);

  late final TextEditingController _lastNameController =
      TextEditingController();

  late final TextEditingController _dateOfBirthController =
      TextEditingController();

  late final TextEditingController _emailController =
      TextEditingController(text: widget.localEmail);

  late final TextEditingController _phoneNumberController =
      TextEditingController();

  String _selectedCountryCode = '91';

  final List<Map<String, String>> countryCodes = [
    {'code': '91', 'name': 'India'},
    {'code': '1', 'name': 'USA'},
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewUserGmailSignUpViewModel>(
      create: (BuildContext context) => newUserGmailSignUpViewModel,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Consumer<NewUserGmailSignUpViewModel>(
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
                                'assets/images/app_logo.png',
                                width: 180,
                                height: 170,
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                AppStrings.signUpContentText,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MetrischSemiBold',
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _firstNameController,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MetrischRegular',
                                ),
                                decoration: InputDecoration(
                                  labelText: AppStrings.firstName,
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
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _lastNameController,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MetrischRegular',
                                ),
                                decoration: InputDecoration(
                                  labelText: AppStrings.lastName,
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
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _dateOfBirthController,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MetrischRegular',
                                ),
                                decoration: InputDecoration(
                                  labelText: "Date of Birth",
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontFamily: 'MetrischRegular',
                                    fontWeight: FontWeight.normal,
                                  ),
                                  border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );

                                  if (pickedDate != null) {
                                    String formattedDate =
                                        "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
                                    _dateOfBirthController.text = formattedDate;
                                  }
                                },
                                keyboardType: TextInputType
                                    .none, // Prevent the keyboard from appearing
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your date of birth';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _emailController,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MetrischRegular',
                                ),
                                decoration: InputDecoration(
                                  labelText: AppStrings.email,
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
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
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
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: RadioListTile<String>(
                                      title: const Text(
                                        AppStrings.male,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              'MetrischRegular', // Custom font
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Male',
                                      groupValue: selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGender = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile<String>(
                                      title: const Text(
                                        AppStrings.female,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              'MetrischRegular', // Custom font
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Female',
                                      groupValue: selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGender = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      newUserGmailSignUpViewModel
                                          .callNewGmailSignUpApi(
                                              _firstNameController.text,
                                              _lastNameController.text,
                                              widget.localEmail,
                                              selectedGender.toLowerCase(),
                                              _phoneNumberController.text,
                                              _dateOfBirthController.text,
                                              context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    backgroundColor: AppColors.customLightGreen,
                                  ),
                                  child: const Text(
                                    AppStrings.signUp,
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
