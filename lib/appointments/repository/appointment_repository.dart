import 'package:drs_booking/appointments/model/appointment_model.dart';
import 'package:drs_booking/appointments/model/doctor_schedule_model.dart';
import 'package:drs_booking/network/api_response.dart';
import 'package:drs_booking/network/network_api_service.dart';

class AppointmentRepository {
  final NetworkApiService _apiService = NetworkApiService();

  //get doctor schedule
  Future<CommonApiResponse<DoctorScheduleResponse>> getDoctorSchedule(
      String doctorId, String day) async {
    Map<String, String> body = {
      'doctor_id': doctorId,
      'day': day,
    };
    try {
      final response = await _apiService.getResponse('custom_schedule', body);
      if (response != null && response['data'] != null) {
        return CommonApiResponse.fromJson(
            response, (item) => DoctorScheduleResponse.fromJson(item));
      } else {
        throw Exception('Invalid response or no data from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  //get already book appointment schedule
  Future<CommonApiResponse<AppointmentResponse>>
      getAlreadyBookedAppointmentSchedule(String doctorId) async {
    Map<String, String> body = {'doctor_id': doctorId};
    try {
      final response =
          await _apiService.getResponse('doctor_patient_appoinemts', body);
      if (response != null && response['data'] != null) {
        return CommonApiResponse.fromJson(
            response, (item) => AppointmentResponse.fromJson(item));
      } else {
        throw Exception('Invalid response or no data from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse<AppointmentResponse>> bookAppointment(
      String doctorId,
      String patientId,
      String time,
      String date,
      String reasonToVisit,
      String visitDoctor) async {
    Map<String, String> body = {
      'doctor_id': doctorId,
      'patient_id': patientId,
      'time': time.toUpperCase(),
      'date': date,
      'reason_to_visit': reasonToVisit,
      'visit_doctor': visitDoctor,
    };
    try {
      final response = await _apiService.postResponse('appointment', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => AppointmentResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse<AppointmentResponse>> reScheduleAppointment(
      String doctorId,
      String patientId,
      String time,
      String date,
      String reasonToVisit,
      String visitDoctor) async {
    Map<String, String> body = {
      'doctor_id': doctorId,
      'patient_id': patientId,
      'time': time.toUpperCase(),
      'date': date,
      'reason_to_visit': reasonToVisit,
      'visit_doctor': visitDoctor,
    };
    try {
      final response = await _apiService.postResponse('appointment', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => AppointmentResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse<AppointmentResponse>> getInsuranceDetails(
      String userId) async {
    Map<String, String> body = {'id': userId};
    try {
      final response = await _apiService.postResponse('view_insurance', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => AppointmentResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
