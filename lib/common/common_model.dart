class CommonResponse {
  final String errmsg;

  CommonResponse({
    required this.errmsg,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(errmsg: json['errmsg']);
  }
}

class CommonMsgResponse {
  final String msg;

  CommonMsgResponse({
    required this.msg,
  });

  factory CommonMsgResponse.fromJson(Map<String, dynamic> json) {
    return CommonMsgResponse(msg: json['msg']);
  }
}
