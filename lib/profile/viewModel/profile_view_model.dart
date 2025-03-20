import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:drs_booking/profile/model/profile_model.dart';
import 'package:drs_booking/profile/repository/profile_repository.dart';
import 'package:flutter/material.dart';

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

  // //deleteDoctorProfileDetails
  // Future<void> deleteDoctorDetails(
  //     String doctorId, String userId, BuildContext context) async {
  //   _setLoading(true);
  //   try {
  //     final response =
  //         await _doctorProfileRepository.deleteDoctorProfile(doctorId, userId);
  //     if (response.status == 200) {
  //       _setLoading(false);
  //       Navigator.of(context).pop(true);
  //     }
  //   } catch (e) {
  //     _showErrorMessage("Wrong..!", context);
  //     _setLoading(false);
  //   }
  // }

  void _setUserProfileDetails(ProfileResponse profileResponse) {
    _userProfileDetails = profileResponse;
    notifyListeners();
  }

  //error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }
}
