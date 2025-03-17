class CategoriesScreenResponse {
  final String id;
  final String image;
  final String name;
  final String status;

  CategoriesScreenResponse(
      {required this.id,
      required this.image,
      required this.name,
      required this.status});

  // Factory method to convert JSON to UserData object
  factory CategoriesScreenResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesScreenResponse(
        id: json['id'],
        image: json['image'],
        name: json['name'],
        status: json['status']);
  }
}
