class AppointmentsTabResponse {
  final String id;
  final String websiteId;
  final String pageId;
  final String doctorId;
  final String time;
  final String date;
  final String patientId;
  final String reasonToVisit;
  final String visitDoctor;
  final String visited;
  final String firstName;
  final String lastName;
  final String image;
  final String city;
  final String state;
  final String zip;
  final String bigImage;
  final String smallImage;
  final String address;

  AppointmentsTabResponse({
    required this.id,
    required this.websiteId,
    required this.pageId,
    required this.doctorId,
    required this.time,
    required this.date,
    required this.patientId,
    required this.reasonToVisit,
    required this.visitDoctor,
    required this.visited,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.city,
    required this.state,
    required this.zip,
    required this.bigImage,
    required this.smallImage,
    required this.address,
  });

  factory AppointmentsTabResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentsTabResponse(
      id: json['id'],
      websiteId: json['website_id'],
      pageId: json['page_id'],
      doctorId: json['doctor_id'],
      time: json['time'],
      date: json['date'],
      patientId: json['patient_id'],
      reasonToVisit: json['reason_to_visit'],
      visitDoctor: json['visitdoctor'],
      visited: json['visited'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      image: json['image'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
      bigImage: json['big_image'],
      smallImage: json['small_image'],
      address: json['address'],
    );
  }
}
