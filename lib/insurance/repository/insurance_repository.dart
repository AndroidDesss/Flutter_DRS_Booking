import 'dart:io';
import 'package:drs_booking/common/common_model.dart';
import 'package:drs_booking/insurance/model/insurance_model.dart';
import 'package:drs_booking/insurance/model/insurance_title_model.dart';
import 'package:drs_booking/network/api_response.dart';
import 'package:drs_booking/network/network_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;

class InsuranceRepository {
  final NetworkApiService _apiService = NetworkApiService();

  //get insurance details
  Future<CommonApiResponse<InsuranceResponse>> getInsuranceDetails(
      String userId) async {
    Map<String, String> body = {'id': userId};
    try {
      final response = await _apiService.getResponse('view_insurance', body);
      if (response != null && response['data'] != null) {
        return CommonApiResponse.fromJson(
            response, (item) => InsuranceResponse.fromJson(item));
      } else {
        throw Exception('Invalid response or no data from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  //delete insurance details
  Future<CommonApiResponse<CommonMsgResponse>> deleteInsuranceDetails(
      String userId) async {
    Map<String, String> body = {'id': userId};
    try {
      final response = await _apiService.postResponse('delete_insurance', body);
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

  //get Insurance Title APi
  Future<CommonApiResponse<InsuranceTitleResponse>> getInsuranceTitle() async {
    try {
      final response = await _apiService.getResponseWithoutBody('insurance');

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => InsuranceTitleResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  //Update Insurance Status By Id
  Future<CommonApiResponse<CommonMsgResponse>> updateInsuranceStatusById(
      String insuranceId, String isActive) async {
    Map<String, String> body = {'id': insuranceId, 'is_active': isActive};
    try {
      final response =
          await _apiService.postResponse('update_isactive_insurance', body);
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

  //Add New Insurance
  Future<CommonApiResponse<CommonMsgResponse>> addNewInsurance(
      String userId, String name, File? frontImage, File? backImage) async {
    Map<String, String> body = {
      'user_id': userId,
      'name': name,
      'is_active': '1'
    };
    List<http.MultipartFile> files = [];
    try {
      if (frontImage != null) {
        final compressedFrontImage = await compressImage(frontImage);
        files.add(await http.MultipartFile.fromPath(
          'front_image',
          compressedFrontImage.path,
          contentType: MediaType('image', 'jpeg'),
        ));
      }
      if (backImage != null) {
        final compressedBackImage = await compressImage(backImage);
        files.add(await http.MultipartFile.fromPath(
          'back_image',
          compressedBackImage.path,
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      final response = await _apiService
          .postMultipartResponse('add_insurance', body, files)
          .timeout(Duration(seconds: 120));

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

  Future<File> compressImage(File file) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    final compressed =
        img.encodeJpg(image!, quality: 80); // Adjust quality as needed
    final compressedFile = File(file.path)..writeAsBytesSync(compressed);
    return compressedFile;
  }
}
