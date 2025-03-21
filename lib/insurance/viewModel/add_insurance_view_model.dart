import 'dart:io';

import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:drs_booking/insurance/model/insurance_title_model.dart';
import 'package:drs_booking/insurance/repository/insurance_repository.dart';
import 'package:flutter/material.dart';

class AddInsuranceViewModel extends ChangeNotifier {
  final InsuranceRepository _insuranceRepository = InsuranceRepository();

  List<InsuranceTitleResponse> _insuranceTitleList = [];
  List<InsuranceTitleResponse> get insuranceTitleList => _insuranceTitleList;

  List<String> get insuranceTitles =>
      _insuranceTitleList.map((e) => e.name).toList();

  // InsuranceTitle API
  Future<void> fetchInsuranceTitleList(BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _insuranceRepository.getInsuranceTitle();
      if (response.data.isNotEmpty && response.status == 200) {
        List<InsuranceTitleResponse> filteredInsuranceTitleList = response.data;
        if (filteredInsuranceTitleList.isNotEmpty) {
          _insuranceTitleList = filteredInsuranceTitleList;
        } else {
          _insuranceTitleList = [];
        }
      } else {
        _insuranceTitleList = [];
      }
    } catch (e) {
      _insuranceTitleList = [];
      _showErrorMessage("Something went wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  // Add Insurance API
  Future<void> addNewInsurance(BuildContext context, String userId, String name,
      File? frontImage, File? backImage) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _insuranceRepository.addNewInsurance(
          userId, name, frontImage, backImage);
      if (response.data != null && response.status == 200) {
        _showErrorMessage("Insurance added successfully..!", context);
        Navigator.pop(context, true);
      }
    } catch (e) {
      _showErrorMessage("Something went wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  // Error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }
}
