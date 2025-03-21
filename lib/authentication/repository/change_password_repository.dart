import 'package:drs_booking/common/common_model.dart';
import 'package:drs_booking/network/api_response.dart';
import 'package:drs_booking/network/network_api_service.dart';

class ChangePasswordRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<CommonMsgResponse>> changePassword(
      String phoneNumber, String password) async {
    Map<String, String> body = {
      'phone': phoneNumber,
      'confirm_password': password
    };
    try {
      final response =
          await _apiService.postResponse('forgot_new_passwrod', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => CommonMsgResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
