import 'package:drs_booking/authentication/view/forgot_password_screen.dart';
import 'package:drs_booking/authentication/view/new_user_sign_up_screen.dart';
import 'package:drs_booking/authentication/viewModel/login_view_model.dart';
import 'package:drs_booking/common/AppColors.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel loginViewModel = LoginViewModel();

  final _formKey = GlobalKey<FormState>();

  bool _isObscured = true;

  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (BuildContext context) => loginViewModel,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Consumer<LoginViewModel>(builder: (context, viewModel, child) {
            return Stack(children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        const AssetImage('assets/images/login_background.png'),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.1),
                      BlendMode.dstATop,
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                            const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                AppStrings.loginContentText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontFamily: 'MetrischSemiBold',
                                    fontWeight: FontWeight.bold),
                              ),
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
                                suffixIcon: const Icon(Icons.email),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordController,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'MetrischRegular',
                              ),
                              obscureText: _isObscured,
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
                                suffixIcon: IconButton(
                                  icon:
                                      const Icon(Icons.remove_red_eye_rounded),
                                  onPressed: () {
                                    setState(() {
                                      _isObscured = !_isObscured;
                                    });
                                  },
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                if (value.length < 8) {
                                  return 'Please enter a valid password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return const ForgotPasswordScreen();
                                      },
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(1.0,
                                            0.0); // Start from right to left
                                        const end = Offset
                                            .zero; // End at current position
                                        const curve = Curves
                                            .easeInOut; // Smooth transition
                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        var offsetAnimation =
                                            animation.drive(tween);
                                        return SlideTransition(
                                            position: offsetAnimation,
                                            child: child);
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  AppStrings.forgotPassword,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    loginViewModel.callLoginApi(
                                      _emailController.text,
                                      _passwordController.text,
                                      context,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                  backgroundColor: AppColors.customLightGreen,
                                ),
                                child: const Text(
                                  AppStrings.signIn,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'MetrischSemiBold',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              AppStrings.continueWith,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontFamily: 'MetrischSemiBold',
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {
                                final user = await loginViewModel
                                    .signInWithGoogle(context);
                                if (user != null) {
                                  loginViewModel.callGmailLoginApi(
                                      user.email!, user.displayName!, context);
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 45, vertical: 20),
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white, // Background color
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                          0.25), // Shadow color with opacity
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/google.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      AppStrings.signIn,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black, // Text color
                                        fontFamily:
                                            'MetrischSemiBold', // Custom font
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return const NewUserSignUpScreen();
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(
                                          1.0, 0.0); // Start from right to left
                                      const end = Offset
                                          .zero; // End at current position
                                      const curve =
                                          Curves.easeInOut; // Smooth transition
                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);
                                      return SlideTransition(
                                          position: offsetAnimation,
                                          child: child);
                                    },
                                  ),
                                );
                              },
                              child: const Text(
                                AppStrings.signUp,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: 'MetrischSemiBold',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]);
          }),
        ),
      ),
    );
  }
}
