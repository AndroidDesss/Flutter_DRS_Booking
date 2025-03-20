import 'package:drs_booking/common/common_model.dart';
import 'package:drs_booking/network/api_response.dart';
import 'package:drs_booking/network/network_api_service.dart';
import 'package:drs_booking/profile/model/profile_model.dart';

class ProfileRepository {
  final NetworkApiService _apiService = NetworkApiService();

  //get profile details
  Future<CommonApiResponse<ProfileResponse>> getProfileDetails(
      String userId) async {
    Map<String, String> body = {'id': userId};
    try {
      final response = await _apiService.getResponse('profile', body);
      if (response != null && response['data'] != null) {
        return CommonApiResponse.fromJson(
            response, (item) => ProfileResponse.fromJson(item));
      } else {
        throw Exception('Invalid response or no data from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  //delete profile details
  Future<CommonApiResponse<CommonMsgResponse>> deleteProfileDetails(
      String userId) async {
    Map<String, String> body = {'id': userId};
    try {
      final response = await _apiService.getResponse('delete_profile', body);
      if (response != null && response['data'] != null) {
        return CommonApiResponse.fromJson(
            response, (item) => CommonMsgResponse.fromJson(item));
      } else {
        throw Exception('Invalid response or no data from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
