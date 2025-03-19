import 'package:drs_booking/appointments/appointments_tab/model/appointments_tab_model.dart';
import 'package:drs_booking/appointments/appointments_tab/repository/appointments_tab_repository.dart';
import 'package:flutter/material.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';

class CompletedAppointmentsTabViewModel extends ChangeNotifier {
  final AppointmentsTabRepository _appointmentsTabRepository =
      AppointmentsTabRepository();

  bool _noCompletedAppointments = false;
  bool get noCompletedAppointments => _noCompletedAppointments;

  List<AppointmentsTabResponse> _appointmentsList = [];
  List<AppointmentsTabResponse> get appointmentsList => _appointmentsList;

  // Appointments List By User Id
  Future<void> fetchAppointmentsList(
      String userId, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoCompletedAppointments(false);
    try {
      final response = await _appointmentsTabRepository.getAppointments(userId);
      if (response.data.isNotEmpty && response.status == 200) {
        List<AppointmentsTabResponse> filteredCompletedAppointments = response
            .data
            .where((appointment) => appointment.visited.toLowerCase() == 'yes')
            .toList();
        if (filteredCompletedAppointments.isNotEmpty) {
          _appointmentsList = filteredCompletedAppointments;
        } else {
          _appointmentsList = [];
          _setNoCompletedAppointments(true);
        }
      } else {
        _appointmentsList = [];
        _setNoCompletedAppointments(true);
      }
    } catch (e) {
      _appointmentsList = [];
      _setNoCompletedAppointments(true);
      _showErrorMessage("Something went wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  // No folders
  void _setNoCompletedAppointments(bool value) {
    _noCompletedAppointments = value;
    notifyListeners();
  }

  // Error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }
}
