import 'package:drs_booking/appointments/appointments_tab/model/appointments_tab_model.dart';
import 'package:drs_booking/common/common_model.dart';
import 'package:drs_booking/network/api_response.dart';
import 'package:drs_booking/network/network_api_service.dart';

class AppointmentsTabRepository {
  final NetworkApiService _apiService = NetworkApiService();

  //get appointments
  Future<CommonApiResponse<AppointmentsTabResponse>> getAppointments(
      String userId) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    try {
      final response =
          await _apiService.getResponse('patient_appoinemts', body);
      if (response != null && response['data'] != null) {
        return CommonApiResponse.fromJson(
            response, (item) => AppointmentsTabResponse.fromJson(item));
      } else {
        throw Exception('Invalid response or no data from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  //cancel appointments
  Future<CommonApiResponse<CommonResponse>> cancelAppointments(
      String appointmentId) async {
    Map<String, String> body = {
      'id': appointmentId,
    };
    try {
      final response = await _apiService.getResponse('cancel_appoinemt', body);
      if (response != null && response['data'] != null) {
        return CommonApiResponse.fromJson(
            response, (item) => CommonResponse.fromJson(item));
      } else {
        throw Exception('Invalid response or no data from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
