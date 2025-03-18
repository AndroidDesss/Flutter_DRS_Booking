import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:drs_booking/doctors/model/doctor_list_model.dart';
import 'package:drs_booking/doctors/repository/doctor_list_repository.dart';
import 'package:flutter/material.dart';

class DoctorListViewModel extends ChangeNotifier {
  final DoctorListRepository _doctorListRepository = DoctorListRepository();

  bool _noDoctors = false;
  bool get noDoctors => _noDoctors;

  List<DoctorListResponse> _doctorsList = [];
  List<DoctorListResponse> get doctorsList => _doctorsList;

  List<DoctorListResponse> _originalDoctorsList = [];

  // Doctors List By Skill Id API
  Future<void> fetchDoctorsList(
      String skillId, String dateOfBirth, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoDoctors(false);
    try {
      final response = await _doctorListRepository.getDoctorListBasedOnSkillId(
          skillId, dateOfBirth);
      if (response.data.isNotEmpty && response.status == 200) {
        List<DoctorListResponse> filteredDoctorsList = response.data;
        if (filteredDoctorsList.isNotEmpty) {
          _doctorsList = filteredDoctorsList;
          _originalDoctorsList = List.from(filteredDoctorsList);
        } else {
          _doctorsList = [];
          _originalDoctorsList = [];
          _setNoDoctors(true);
        }
      } else {
        _doctorsList = [];
        _originalDoctorsList = [];
        _setNoDoctors(true);
      }
    } catch (e) {
      _doctorsList = [];
      _originalDoctorsList = [];
      _setNoDoctors(true);
      _showErrorMessage("Something went wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  // No folders
  void _setNoDoctors(bool value) {
    _noDoctors = value;
    notifyListeners();
  }

  // Error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }

  //search Skills
  void searchSkills(String query) {
    if (query.isEmpty) {
      _doctorsList = List.from(_originalDoctorsList);
    } else {
      _doctorsList = _originalDoctorsList.where((doctors) {
        return doctors.firstName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
