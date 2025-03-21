class ForgotPasswordResponse {
  final String? otp;

  ForgotPasswordResponse({
    this.otp,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      otp: json['otp'],
    );
  }
}
