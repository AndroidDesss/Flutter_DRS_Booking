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
}
