class CommonApiResponse<T> {
  final int code;
  final int status;
  final List<T> data;

  CommonApiResponse(
      {required this.code, required this.status, required this.data});

  factory CommonApiResponse.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonFunc) {
    return CommonApiResponse<T>(
      code: json['code'],
      status: json['status'],
      data: List<T>.from(json['data'].map((item) => fromJsonFunc(item))),
    );
  }
}
