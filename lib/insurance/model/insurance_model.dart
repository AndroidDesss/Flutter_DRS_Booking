class InsuranceResponse {
  final String id;
  final String userId;
  final String name;
  final String frontImage;
  final String backImage;
  final String isActive;

  InsuranceResponse({
    required this.id,
    required this.userId,
    required this.name,
    required this.frontImage,
    required this.backImage,
    required this.isActive,
  });

  factory InsuranceResponse.fromJson(Map<String, dynamic> json) {
    return InsuranceResponse(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      frontImage: json['front_image'],
      backImage: json['back_image'],
      isActive: json['is_active'],
    );
  }
}
