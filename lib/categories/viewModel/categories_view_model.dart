import 'package:drs_booking/categories/model/categories_model.dart';
import 'package:drs_booking/categories/repository/categories_repository.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:flutter/material.dart';

class CategoriesViewModel extends ChangeNotifier {
  final CategoriesRepository _categoriesRepository = CategoriesRepository();

  bool _noSkills = false;
  bool get noSkills => _noSkills;

  List<CategoriesScreenResponse> _skillsList = [];
  List<CategoriesScreenResponse> get skillsList => _skillsList;

  List<CategoriesScreenResponse> _originalskillsList = [];

  // Skills API
  Future<void> fetchSkillsList(BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoSkills(false);
    try {
      final response = await _categoriesRepository.getSkills();
      if (response.data.isNotEmpty && response.status == 200) {
        List<CategoriesScreenResponse> filteredSkillsList = response.data;
        if (filteredSkillsList.isNotEmpty) {
          _skillsList = filteredSkillsList;
          _originalskillsList = List.from(filteredSkillsList);
        } else {
          _skillsList = [];
          _originalskillsList = [];
          _setNoSkills(true);
        }
      } else {
        _skillsList = [];
        _originalskillsList = [];
        _setNoSkills(true);
      }
    } catch (e) {
      _skillsList = [];
      _originalskillsList = [];
      _setNoSkills(true);
      _showErrorMessage("Something went wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  // No folders
  void _setNoSkills(bool value) {
    _noSkills = value;
    notifyListeners();
  }

  // Error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }

  //search Skills
  void searchSkills(String query) {
    if (query.isEmpty) {
      _skillsList = List.from(_originalskillsList);
    } else {
      _skillsList = _originalskillsList.where((skills) {
        return skills.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
