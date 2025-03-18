import 'package:drs_booking/doctors/model/doctor_list_model.dart';
import 'package:drs_booking/network/api_response.dart';
import 'package:drs_booking/network/network_api_service.dart';

class DoctorListRepository {
  final NetworkApiService _apiService = NetworkApiService();

  //get doctor list based on skill id
  Future<CommonApiResponse<DoctorListResponse>> getDoctorListBasedOnSkillId(
      String skillId, String dateOfBirth) async {
    Map<String, String> body = {
      'skill_id': skillId,
      'dob': dateOfBirth,
    };
    try {
      final response = await _apiService.getResponse('doctor', body);
      if (response != null && response['data'] != null) {
        return CommonApiResponse.fromJson(
            response, (item) => DoctorListResponse.fromJson(item));
      } else {
        throw Exception('Invalid response or no data from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
