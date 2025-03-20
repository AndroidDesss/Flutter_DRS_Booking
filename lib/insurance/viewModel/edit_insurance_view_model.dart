import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:drs_booking/insurance/repository/insurance_repository.dart';
import 'package:flutter/material.dart';

class EditInsuranceViewModel extends ChangeNotifier {
  final InsuranceRepository _insuranceRepository = InsuranceRepository();

  // InsuranceTitle API
  Future<void> updateInsuranceStatusById(
      String insuranceId, String isActive, BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _insuranceRepository.updateInsuranceStatusById(
          insuranceId, isActive);
      if (response.data.isNotEmpty && response.status == 200) {
        _showErrorMessage("Successfully Updated..!", context);
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
