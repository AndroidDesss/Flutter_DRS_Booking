import 'dart:convert';
import 'dart:io';
import 'package:drs_booking/network/base_api_service.dart';
import 'package:drs_booking/network/error_exception.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiService {
  //Post Api Call With Body
  Future postResponse(String url, Map<String, String> jsonBody) async {
    dynamic responseJson;
    try {
      final response =
          await http.post(Uri.parse(baseUrl + url), body: jsonBody);
      responseJson = returnResponse(response);
      print("ServerResponse: ${response.statusCode} - ${response.body}");
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      print(e);
    }
    return responseJson;
  }

  //Get Api Call With Body
  Future<dynamic> getResponse(
      String url, Map<String, String> queryParams) async {
    dynamic responseJson;
    try {
      final uri = Uri.parse(baseUrl + url);
      final fullUrl = "$uri&${Uri(queryParameters: queryParams).query}";
      final response = await http.get(Uri.parse(fullUrl));
      print("ServerResponse: ${response.statusCode} - ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  //Get Api Call Without Body
  Future<dynamic> getResponseWithoutBody(String url) async {
    dynamic responseJson;
    try {
      final uri = Uri.parse(baseUrl + url);
      final response = await http.get(uri);
      print("ServerResponse: ${response.statusCode} - ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
