import 'package:drs_booking/common/AppColors.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:drs_booking/common/shared_pref.dart';
import 'package:drs_booking/dashboard/dash_board_screen.dart';
import 'package:drs_booking/insurance/view/insurances_screen.dart';
import 'package:drs_booking/profile/viewModel/profile_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final ProfileViewModel profileViewModel = ProfileViewModel();

  late String userId = '';
  String loginType = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getSharedPrefData();
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

  void moveToDashBoardScreen() {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: const DashBoardScreen(),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  Future<void> _getSharedPrefData() async {
    await SharedPrefsHelper.init();
    userId = SharedPrefsHelper.getString('user_id')!;
    loginType = SharedPrefsHelper.getString('loginType')!;

    if (userId.isNotEmpty) {
      profileViewModel.getProfileDetails(userId, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          AppStrings.profile,
          style: TextStyle(
            fontFamily: 'MetrischSemiBold',
            fontSize: 26,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        actions: [
          InkWell(
            onTap: () async {
              bool? logout = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    "Are you sure you want to log out?",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'MetrischRegular',
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("No",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'MetrischRegular',
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                    TextButton(
                      onPressed: () async {
                        _clearSharedPref();
                        Navigator.of(context).pop(true);
                      },
                      child: const Text("Yes",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'MetrischRegular',
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                  ],
                ),
              );
              if (logout == true) {
                if (loginType != 'normal') {
                  _signOut();
                }
                moveToDashBoardScreen();
              }
            },
            child: Image.asset(
              color: Colors.black,
              'assets/images/log_out.png', // Replace with your image path
              width: 30, // Adjust size as needed
              height: 25,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ChangeNotifierProvider<ProfileViewModel>(
        create: (BuildContext context) => profileViewModel,
        child: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.userProfileDetails != null &&
                viewModel.userProfileDetails != null) {
              _nameController.text = viewModel.userProfileDetails!.userName;
              _phoneNumberController.text = viewModel.userProfileDetails!.phone;
              _emailController.text = viewModel.userProfileDetails!.email;
              _passwordController.text = viewModel.userProfileDetails!.password;
            }
            return Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/home_background_gradient.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      Center(
                        child: Container(
                          width: 140, // radius * 2 + border width * 2
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black, // Border color
                              width: 2, // Border width
                            ),
                          ),
                          child: Lottie.asset('assets/loader/profile.json'),
                        ),
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        controller: _nameController,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'MetrischRegular',
                            fontSize: 16),
                        decoration: InputDecoration(
                          labelText: AppStrings.userName,
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'MetrischSemiBold',
                              fontWeight: FontWeight.bold),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          suffixIcon: const Icon(Icons.person),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _phoneNumberController,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'MetrischRegular',
                            fontSize: 16),
                        decoration: InputDecoration(
                          labelText: AppStrings.phoneNumber,
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'MetrischSemiBold',
                              fontWeight: FontWeight.bold),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          suffixIcon: const Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'MetrischRegular',
                            fontSize: 16),
                        decoration: InputDecoration(
                          labelText: AppStrings.email,
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'MetrischSemiBold',
                              fontWeight: FontWeight.bold),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          suffixIcon: const Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'MetrischRegular',
                            fontSize: 16),
                        decoration: InputDecoration(
                          labelText: AppStrings.password,
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'MetrischSemiBold',
                              fontWeight: FontWeight.bold),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          suffixIcon: const Icon(Icons.password),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: const InsurancesScreen(),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.customLightGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(AppStrings.insurance,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'MetrischSemiBold',
                              )),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            bool? cancel = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text(
                                  "Are you sure you want to cancel?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'MetrischRegular',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text(
                                      "No",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'MetrischRegular',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'MetrischRegular',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            );
                            if (cancel == true) {
                              // ongoingAppointmentsTabViewModel.cancelAppointments(
                              //     userId, character.id, context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(AppStrings.deleteAccount,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'MetrischSemiBold',
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
