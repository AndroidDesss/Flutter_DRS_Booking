import 'package:drs_booking/appointments/appointments_tab/model/appointments_tab_model.dart';
import 'package:drs_booking/appointments/appointments_tab/repository/appointments_tab_repository.dart';
import 'package:flutter/material.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:intl/intl.dart';

class OngoingAppointmentsTabViewModel extends ChangeNotifier {
  final AppointmentsTabRepository _appointmentsTabRepository =
      AppointmentsTabRepository();

  bool _noOngoingAppointments = false;
  bool get noOnGoingAppointments => _noOngoingAppointments;

  List<AppointmentsTabResponse> _appointmentsList = [];
  List<AppointmentsTabResponse> get appointmentsList => _appointmentsList;

  // Appointments List By User Id
  Future<void> fetchAppointmentsList(
      String userId, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setOngoingAppointments(false);
    try {
      final response = await _appointmentsTabRepository.getAppointments(userId);
      if (response.data.isNotEmpty && response.status == 200) {
        List<AppointmentsTabResponse> filteredOnGoingAppointments =
            response.data.where((appointment) {
          if (appointment.visited.toLowerCase() == 'no') {
            DateFormat timeSdf = DateFormat("hh:mm a");
            DateFormat dateSdf = DateFormat("MM-dd-yyyy");

            try {
              DateTime date1 = dateSdf.parse(appointment.date);
              DateTime date2 = dateSdf.parse(CommonUtilities.getCurrentDate());

              DateTime time1 = timeSdf.parse(appointment.time);
              DateTime time2 = timeSdf.parse(CommonUtilities.getCurrentTime());

              if (date1.isAfter(date2)) {
                return true;
              } else if (date1.isAtSameMomentAs(date2)) {
                return time1.isAfter(time2);
              }
            } catch (e) {
              print("Error: $e");
            }
          }
          return false;
        }).toList();

        if (filteredOnGoingAppointments.isNotEmpty) {
          //Data and Time Sorting
          filteredOnGoingAppointments.sort((a, b) {
            DateFormat dateTimeFormat = DateFormat("MM-dd-yyyy hh:mm a");
            DateTime dateTimeA = dateTimeFormat.parse("${a.date} ${a.time}");
            DateTime dateTimeB = dateTimeFormat.parse("${b.date} ${b.time}");
            return dateTimeA.compareTo(dateTimeB);
          });

          _appointmentsList = filteredOnGoingAppointments;
        } else {
          _appointmentsList = [];
          _setOngoingAppointments(true);
        }
      } else {
        _appointmentsList = [];
        _setOngoingAppointments(true);
      }
    } catch (e) {
      _appointmentsList = [];
      _setOngoingAppointments(true);
      _showErrorMessage("Something went wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  // Cancel Appointments
  Future<void> cancelAppointments(
      String userId, String appointmentId, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setOngoingAppointments(false);
    try {
      final response =
          await _appointmentsTabRepository.cancelAppointments(appointmentId);
      if (response.data.isNotEmpty && response.status == 200) {
        _showErrorMessage("Successfully Cancelled..!", context);
        await fetchAppointmentsList(userId, context);
      }
    } catch (e) {
      CustomLoader.hideLoader();
      _showErrorMessage("Something went wrong..!", context);
    }
  }

  // No folders
  void _setOngoingAppointments(bool value) {
    _noOngoingAppointments = value;
    notifyListeners();
  }

  // Error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }
}
