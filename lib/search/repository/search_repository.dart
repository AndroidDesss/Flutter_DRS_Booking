import 'package:drs_booking/categories/model/categories_model.dart';
import 'package:drs_booking/network/api_response.dart';
import 'package:drs_booking/network/network_api_service.dart';
import 'package:drs_booking/search/model/city_state_model.dart';
import 'package:drs_booking/search/model/search_doctor_model.dart';

class SearchRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<CategoriesScreenResponse>> getSkills() async {
    try {
      final response = await _apiService.getResponseWithoutBody('skill');

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => CategoriesScreenResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CityApiResponse> getStateCity() async {
    try {
      final response = await _apiService.getResponseWithoutBody('city_state');
      return CityApiResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse<SearchDoctorResponse>> getDoctorListBasedOnSkillCity(
      String cityZip, String skillId, String dateOfBirth) async {
    Map<String, String> body = {
      'city_zip': cityZip,
      'skill_id': skillId,
      'dob': dateOfBirth,
    };
    try {
      final response = await _apiService.postResponse('search_doctor', body);
      if (response != null && response['data'] != null) {
        return CommonApiResponse.fromJson(
            response, (item) => SearchDoctorResponse.fromJson(item));
      } else {
        throw Exception('Invalid response or no data from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
