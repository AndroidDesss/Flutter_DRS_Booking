import 'package:drs_booking/authentication/model/forgot_password_model.dart';
import 'package:drs_booking/authentication/model/login_model.dart';
import 'package:drs_booking/common/common_model.dart';
import 'package:drs_booking/network/api_response.dart';
import 'package:drs_booking/network/network_api_service.dart';

class SignUpRepository {
  final NetworkApiService _apiService = NetworkApiService();

  //Check User Available
  Future<CommonApiResponse<CommonMsgResponse>> checkUser(
      String email, String phoneNumber) async {
    Map<String, String> body = {'email': email, 'phone': phoneNumber};
    try {
      final response = await _apiService.postResponse('check_is_user', body);

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

  Future<CommonApiResponse<ForgotPasswordResponse>> newUserOtpApi(
      String phoneNumber, String region) async {
    Map<String, String> body = {
      'phone': phoneNumber,
      'region': region,
    };
    try {
      final response = await _apiService.postResponse('open_otp', body);

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

  Future<CommonApiResponse<LoginScreenResponse>> normalSignUpApi(
      String firstName,
      String lastName,
      String email,
      String password,
      String gender,
      String phoneNumber,
      String dateOfBirth) async {
    Map<String, String> body = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'gender': gender,
      'comments': 'test',
      'phone': phoneNumber,
      'verify_phone': 'Yes',
      'dob': dateOfBirth,
      'logintype': 'normal',
    };
    try {
      final response = await _apiService.postResponse('signup', body);

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

  Future<CommonApiResponse<LoginScreenResponse>> gmailSignUpApi(
      String firstName,
      String lastName,
      String email,
      String gender,
      String phoneNumber,
      String dateOfBirth) async {
    Map<String, String> body = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': '',
      'gender': gender,
      'comments': 'test',
      'phone': phoneNumber,
      'verify_phone': 'Yes',
      'dob': dateOfBirth,
      'logintype': 'gmail',
    };
    try {
      final response = await _apiService.postResponse('signup', body);

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
