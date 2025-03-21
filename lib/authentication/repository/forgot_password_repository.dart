import 'package:drs_booking/authentication/model/forgot_password_model.dart';
import 'package:drs_booking/network/api_response.dart';
import 'package:drs_booking/network/network_api_service.dart';

class ForgotPasswordRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<ForgotPasswordResponse>> forgotPasswordOtpAPi(
      String phoneNumber, String region) async {
    Map<String, String> body = {
      'phone': phoneNumber,
      'region': region,
    };
    try {
      final response = await _apiService.postResponse('otp', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => ForgotPasswordResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
