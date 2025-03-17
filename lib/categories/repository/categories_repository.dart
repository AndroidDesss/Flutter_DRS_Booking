import 'package:drs_booking/categories/model/categories_model.dart';
import 'package:drs_booking/network/api_response.dart';
import 'package:drs_booking/network/network_api_service.dart';

class CategoriesRepository {
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
}
