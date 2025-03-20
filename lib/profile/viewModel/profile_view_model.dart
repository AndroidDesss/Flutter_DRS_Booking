import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:drs_booking/dashboard/dash_board_screen.dart';
import 'package:drs_booking/profile/model/profile_model.dart';
import 'package:drs_booking/profile/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileRepository _profileRepository = ProfileRepository();

  ProfileResponse? _userProfileDetails;
  ProfileResponse? get userProfileDetails => _userProfileDetails;

  //userProfileDetails
  Future<void> getProfileDetails(String userId, BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _profileRepository.getProfileDetails(userId);
      if (response.status == 200) {
        _setUserProfileDetails(response.data.first);
      }
    } catch (e) {
      _showErrorMessage("Wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
    }
  }

  //deleteDoctorProfileDetails
  Future<void> deleteDoctorDetails(
      String doctorId, String userId, BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _profileRepository.deleteProfileDetails(userId);
      if (response.status == 200) {
        _showErrorMessage("Successfully Deleted..!", context);
        moveToDashBoardScreen(context);
      }
    } catch (e) {
      _showErrorMessage("Wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
    }
  }

  void _setUserProfileDetails(ProfileResponse profileResponse) {
    _userProfileDetails = profileResponse;
    notifyListeners();
  }

  //error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }

  void moveToDashBoardScreen(BuildContext context) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: const DashBoardScreen(),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
