import 'package:drs_booking/categories/model/categories_model.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:drs_booking/doctors/model/doctor_list_model.dart';
import 'package:drs_booking/search/model/city_state_model.dart';
import 'package:drs_booking/search/model/search_doctor_model.dart';
import 'package:drs_booking/search/repository/search_repository.dart';
import 'package:flutter/material.dart';

class SearchScreenViewModel extends ChangeNotifier {
  final SearchRepository _searchRepository = SearchRepository();

  List<CategoriesScreenResponse> _skillsList = [];
  List<CategoriesScreenResponse> get skillsList => _skillsList;

  List<City> _cityStateList = [];
  List<City> get cityStateList => _cityStateList;

  bool _noDoctors = false;
  bool get noDoctors => _noDoctors;

  List<SearchDoctorResponse> _doctorsList = [];
  List<SearchDoctorResponse> get doctorsList => _doctorsList;

  // Skills API
  Future<void> fetchSkillsList(BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _searchRepository.getSkills();
      if (response.data.isNotEmpty && response.status == 200) {
        List<CategoriesScreenResponse> filteredSkillsList = response.data;
        if (filteredSkillsList.isNotEmpty) {
          _skillsList = filteredSkillsList;
        } else {
          _skillsList = [];
        }
        fetchCityList(context);
      } else {
        _skillsList = [];
        CustomLoader.hideLoader();
      }
    } catch (e) {
      _skillsList = [];
      CustomLoader.hideLoader();
      _showErrorMessage("Something went wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  // City State API
  Future<void> fetchCityList(BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _searchRepository.getStateCity();
      if (response.status == 200 && response.cityList.isNotEmpty) {
        _cityStateList = response.cityList;
      } else {
        _cityStateList.clear();
      }
    } catch (e) {
      _cityStateList.clear();
      _showErrorMessage("Error: ${e.toString()}", context);
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  // Doctors List By Skill Id API
  Future<void> fetchDoctorsListBySkillStateCity(String cityZip, String skillId,
      String dateOfBirth, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoDoctors(false);
    try {
      final response = await _searchRepository.getDoctorListBasedOnSkillCity(
          cityZip, skillId, dateOfBirth);
      if (response.data.isNotEmpty && response.status == 200) {
        List<SearchDoctorResponse> filteredDoctorsList = response.data;
        if (filteredDoctorsList.isNotEmpty) {
          _doctorsList = filteredDoctorsList;
        } else {
          _doctorsList = [];
          _setNoDoctors(true);
        }
      } else {
        _doctorsList = [];
        _setNoDoctors(true);
      }
    } catch (e) {
      _doctorsList = [];
      _setNoDoctors(true);
      _showErrorMessage("Something went wrong..!", context);
      print("ServerResponse$e");
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  // Error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }

  // No folders
  void _setNoDoctors(bool value) {
    _noDoctors = value;
    notifyListeners();
  }
}
