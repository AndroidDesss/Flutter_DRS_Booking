import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:drs_booking/insurance/model/insurance_model.dart';
import 'package:drs_booking/insurance/repository/insurance_repository.dart';
import 'package:flutter/material.dart';

class InsuranceViewModel extends ChangeNotifier {
  final InsuranceRepository _insuranceRepository = InsuranceRepository();

  bool _noInsurance = false;
  bool get noInsurance => _noInsurance;

  List<InsuranceResponse> _insuranceList = [];
  List<InsuranceResponse> get insuranceList => _insuranceList;

  // Insurance API
  Future<void> fetchInsuranceList(String userId, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoInsurance(false);
    try {
      final response = await _insuranceRepository.getInsuranceDetails(userId);
      if (response.data.isNotEmpty && response.status == 200) {
        List<InsuranceResponse> filteredSkillsList = response.data;
        if (filteredSkillsList.isNotEmpty) {
          _insuranceList = filteredSkillsList;
        } else {
          _insuranceList = [];
          _setNoInsurance(true);
        }
      } else {
        _insuranceList = [];
        _setNoInsurance(true);
      }
    } catch (e) {
      _insuranceList = [];
      _setNoInsurance(true);
      _showErrorMessage("Something went wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  // Delete Insurance API
  Future<void> deleteInsuranceApiById(
      String insuranceId, String userId, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoInsurance(false);
    try {
      final response =
          await _insuranceRepository.deleteInsuranceDetails(insuranceId);
      if (response.data.isNotEmpty && response.status == 200) {
        _showErrorMessage("Successfully Deleted..!", context);
        fetchInsuranceList(userId, context);
      }
    } catch (e) {
      _showErrorMessage("Something went wrong..!", context);
    }
  }

  // No Insurance
  void _setNoInsurance(bool value) {
    _noInsurance = value;
    notifyListeners();
  }

  // Error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }
}
