class InsuranceTitleResponse {
  final String id;
  final String name;
  final String status;

  InsuranceTitleResponse({
    required this.id,
    required this.name,
    required this.status,
  });

  factory InsuranceTitleResponse.fromJson(Map<String, dynamic> json) {
    return InsuranceTitleResponse(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }
}
