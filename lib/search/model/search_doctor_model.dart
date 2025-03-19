class SearchDoctorResponse {
  String id;
  String bigImage;
  String smallImage;
  String ageLimit;
  String firstName;
  String lastName;
  String education;
  String gender;
  String qualification;
  String contactNumber;
  String certifications;
  String awards;
  String aboutOf;
  String specialties;
  String description;
  String facebookUrl;
  String twitterUrl;
  String googleUrl;
  String linkedinUrl;
  String email;
  String image;
  String address;
  String city;
  String state;
  String zip;

  SearchDoctorResponse({
    required this.id,
    required this.bigImage,
    required this.smallImage,
    required this.ageLimit,
    required this.firstName,
    required this.lastName,
    required this.education,
    required this.gender,
    required this.qualification,
    required this.contactNumber,
    required this.certifications,
    required this.awards,
    required this.aboutOf,
    required this.specialties,
    required this.description,
    required this.facebookUrl,
    required this.twitterUrl,
    required this.googleUrl,
    required this.linkedinUrl,
    required this.email,
    required this.image,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
  });

  factory SearchDoctorResponse.fromJson(Map<String, dynamic> json) {
    return SearchDoctorResponse(
      id: json['id'] ?? '',
      bigImage: json['big_image'] ?? '',
      smallImage: json['small_image'] ?? '',
      ageLimit: json['age_limit'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      education: json['education'] ?? '',
      gender: json['gender'] ?? '',
      qualification: json['qualification'] ?? '',
      contactNumber: json['contact_number'] ?? '',
      certifications: json['certifications'] ?? '',
      awards: json['awards'] ?? '',
      aboutOf: json['about_of'] ?? '',
      specialties: json['specialties'] ?? '',
      description: json['description'] ?? '',
      facebookUrl: json['facebook_url'] ?? '',
      twitterUrl: json['twitter_url'] ?? '',
      googleUrl: json['google_url'] ?? '',
      linkedinUrl: json['linkedin_url'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zip: json['zip'] ?? '',
    );
  }
}
