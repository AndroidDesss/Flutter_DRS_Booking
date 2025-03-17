import 'package:drs_booking/authentication/model/login_model.dart';
import 'package:drs_booking/network/api_response.dart';
import 'package:drs_booking/network/network_api_service.dart';

class LoginRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<LoginScreenResponse>> login(
      String email, String password) async {
    Map<String, String> body = {
      'email': email,
      'password': password,
      'logintype': 'normal'
    };
    try {
      final response = await _apiService.postResponse('login', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => LoginScreenResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse<LoginScreenResponse>> gmailLogin(
      String email, String userName) async {
    Map<String, String> body = {
      'email': email,
      'username': userName,
      'password': '',
      'logintype': 'gmail',
      'gender': '',
      'profile_pic': ''
    };
    try {
      final response = await _apiService.postResponse('login', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => LoginScreenResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
