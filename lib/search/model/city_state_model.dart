class CityApiResponse {
  final int code;
  final int status;
  final List<City> cityList;

  CityApiResponse({
    required this.code,
    required this.status,
    required this.cityList,
  });

  factory CityApiResponse.fromJson(Map<String, dynamic> json) {
    return CityApiResponse(
      code: json['code'] ?? 0,
      status: json['status'] ?? 0,
      cityList: (json['data']['city'] as List<dynamic>?)
              ?.map((item) => City.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class City {
  final String id;
  final String cityName;

  City({
    required this.id,
    required this.cityName,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] ?? '',
      cityName: json['city_name'] ?? '',
    );
  }
}
