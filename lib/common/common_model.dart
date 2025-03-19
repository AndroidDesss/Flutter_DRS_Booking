class CommonResponse {
  final String errmsg;

  CommonResponse({
    required this.errmsg,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(errmsg: json['errmsg']);
  }
}
