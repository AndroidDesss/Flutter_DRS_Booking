import 'package:drs_booking/appointments/model/time_model.dart';
import 'package:drs_booking/appointments/repository/appointment_repository.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentViewModel extends ChangeNotifier {
  final AppointmentRepository _appointmentRepository = AppointmentRepository();

  bool _notAvailable = false;
  bool get notAvailable => _notAvailable;

  List<String> morningSlot = [];

  List<String> afternoonSlot = [];

  List<String> totalSlot = [];

  List<TimeResponse> timeModelsList = [];

  String currentDate = CommonUtilities.getCurrentDate();

  // Doctors Schedule
  Future<void> fetchDoctorsSchedule(
      String doctorId, String day, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNotAvailable(false);
    try {
      final response =
          await _appointmentRepository.getDoctorSchedule(doctorId, day);
      if (response.data.isNotEmpty && response.status == 200) {
        if (response.data.first.isDayOff.trim() == "1") {
          _setNotAvailable(true);
        } else {
          _setNotAvailable(false);
          int slotTime =
              int.parse(response.data.first.slotLength.trim().toLowerCase());
          String startTime = response.data.first.startTime.trim();
          String lunchStart = response.data.first.lunchStart.trim();
          String endTime = response.data.first.endTime.trim();
          String lunchEnd = response.data.first.lunchEnd.trim();
          getMorningSlot(
              slotTime, startTime, lunchStart, endTime, lunchEnd, doctorId);
        }
      } else {
        _setNotAvailable(true);
        CustomLoader.hideLoader();
      }
    } catch (e) {
      _setNotAvailable(true);
      CustomLoader.hideLoader();
      _showErrorMessage("Something went wrong..!", context);
    }
  }

  // No folders
  void _setNotAvailable(bool value) {
    _notAvailable = value;
    notifyListeners();
  }

  // Error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }

  void _setAvailableSlots(List<TimeResponse> availableSlots) {
    timeModelsList = availableSlots;
    notifyListeners();
  }

  //Getting Morning Slots
  void getMorningSlot(int slotTime, String startTime, String lunchStart,
      String endTime, String lunchEnd, String doctorId) {
    morningSlot.clear();
    DateFormat format = DateFormat("hh:mm a");
    DateTime? lunchStartTime;
    DateTime? startDateTime;

    try {
      lunchStartTime = format.parse(lunchStart);
      startDateTime = format.parse(startTime);
    } catch (e) {
      print("Error parsing date: $e");
    }
    while (format.format(startDateTime!) != format.format(lunchStartTime!)) {
      startDateTime = startDateTime.add(Duration(minutes: slotTime));
      String formattedTime = format.format(startDateTime);

      if (formattedTime != format.format(lunchStartTime)) {
        if (currentDate == DateFormat('MM-dd-yyyy').format(DateTime.now())) {
          String currentTime = format.format(DateTime.now());
          DateTime date1 = format.parse(formattedTime);
          DateTime date2 = format.parse(currentTime);

          if (date1.isAfter(date2)) {
            morningSlot.add(formattedTime);
          }
        } else {
          morningSlot.add(formattedTime);
        }
      }
    }
    getAfternoonSlot(slotTime, endTime, lunchEnd, currentDate, doctorId);
  }

  //Getting Afternoon Slots
  void getAfternoonSlot(int slotTime, String endTime, String lunchEnd,
      String currentDate, String doctorId) {
    afternoonSlot.clear();
    DateFormat format = DateFormat("hh:mm a");
    DateTime? lunchEndTime;
    DateTime? endDateTime;
    try {
      lunchEndTime = format.parse(lunchEnd);
      endDateTime = format.parse(endTime);
    } catch (e) {
      print("Error parsing date: $e");
    }

    while (format.format(lunchEndTime!) != format.format(endDateTime!)) {
      lunchEndTime = lunchEndTime.add(Duration(minutes: slotTime));
      String formattedTime = format.format(lunchEndTime);

      if (formattedTime != format.format(endDateTime)) {
        if (currentDate == DateFormat('MM-dd-yyyy').format(DateTime.now())) {
          String currentTime = format.format(DateTime.now());
          DateTime date1 = format.parse(formattedTime);
          DateTime date2 = format.parse(currentTime);

          if (date1.isAfter(date2)) {
            afternoonSlot.add(formattedTime);
          }
        } else {
          afternoonSlot.add(formattedTime);
        }
      }
    }
    setAdapter(doctorId);
  }

  void setAdapter(String doctorId) {
    totalSlot.clear();
    timeModelsList.clear();
    totalSlot.addAll(morningSlot);
    totalSlot.addAll(afternoonSlot);
    fetchAlreadyBookedTime(doctorId);
  }

  Future<void> fetchAlreadyBookedTime(String doctorId) async {
    _setNotAvailable(false);
    try {
      final response = await _appointmentRepository
          .getAlreadyBookedAppointmentSchedule(doctorId);
      if (response.data.isNotEmpty && response.status == 200) {
        int status = response.status;
        if (status == 200) {
          var dataArray = response.data;

          if (dataArray != null && dataArray.isNotEmpty) {
            for (var loginObject in dataArray) {
              String appointmentTime = loginObject.time ?? '';
              String appointmentDate = loginObject.date ?? '';

              if (currentDate == appointmentDate) {
                for (int j = 0; j < totalSlot.length; j++) {
                  if (!(appointmentTime.contains("AM") ||
                      appointmentTime.contains("PM"))) {
                    try {
                      DateTime dateTime =
                          DateFormat('HH:mm').parse(appointmentTime);
                      appointmentTime = DateFormat('hh:mm a').format(dateTime);
                    } catch (e) {
                      print("ServerResponse: Error parsing time: $e");
                    }
                    if (appointmentTime == "12:00 AM") {
                      appointmentTime = "12:00 PM";
                    }
                  }
                  if (totalSlot[j].trim().toLowerCase() ==
                      appointmentTime.trim().toLowerCase()) {
                    totalSlot.removeAt(j);
                    break;
                  }
                }
              }
            }

            if (totalSlot.isNotEmpty) {
              _setAvailableSlots(
                  totalSlot.map((time) => TimeResponse(time: time)).toList());
            } else {
              _setNotAvailable(true);
            }
          } else {
            _setNotAvailable(true);
          }
        }
      } else {
        _setNotAvailable(true);
      }
    } catch (e) {
      _setNotAvailable(true);
    } finally {
      CustomLoader.hideLoader();
    }
  }
}
