import 'package:drs_booking/appointments/appointments_tab/model/appointments_tab_model.dart';
import 'package:drs_booking/appointments/appointments_tab/repository/appointments_tab_repository.dart';
import 'package:flutter/material.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:intl/intl.dart';

class MissedAppointmentsTabViewModel extends ChangeNotifier {
  final AppointmentsTabRepository _appointmentsTabRepository =
      AppointmentsTabRepository();

  bool _noMissedAppointments = false;
  bool get noMissedAppointments => _noMissedAppointments;

  List<AppointmentsTabResponse> _appointmentsList = [];
  List<AppointmentsTabResponse> get appointmentsList => _appointmentsList;

  // Appointments List By User Id
  Future<void> fetchAppointmentsList(
      String userId, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoMissedAppointments(false);
    try {
      final response = await _appointmentsTabRepository.getAppointments(userId);
      if (response.data.isNotEmpty && response.status == 200) {
        List<AppointmentsTabResponse> filteredMissedAppointments =
            response.data.where((appointment) {
          if (appointment.visited.toLowerCase() == 'no') {
            DateFormat timeSdf = DateFormat("hh:mm a");
            DateFormat dateSdf = DateFormat("MM-dd-yyyy");

            try {
              DateTime date1 = dateSdf.parse(appointment.date);
              DateTime date2 = dateSdf.parse(CommonUtilities.getCurrentDate());

              DateTime time1 = timeSdf.parse(appointment.time);
              DateTime time2 = timeSdf.parse(CommonUtilities.getCurrentTime());

              if (date1.isBefore(date2)) {
                return true;
              } else if (date1.isAtSameMomentAs(date2)) {
                return time1.isBefore(time2);
              }
            } catch (e) {
              print("Error: $e");
            }
          }
          return false;
        }).toList();

        if (filteredMissedAppointments.isNotEmpty) {
          _appointmentsList = filteredMissedAppointments;
        } else {
          _appointmentsList = [];
          _setNoMissedAppointments(true);
        }
      } else {
        _appointmentsList = [];
        _setNoMissedAppointments(true);
      }
    } catch (e) {
      _appointmentsList = [];
      _setNoMissedAppointments(true);
      _showErrorMessage("Something went wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  // No folders
  void _setNoMissedAppointments(bool value) {
    _noMissedAppointments = value;
    notifyListeners();
  }

  // Error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }
}
