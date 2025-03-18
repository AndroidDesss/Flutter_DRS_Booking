class DoctorListResponse {
  final String id;
  final String skillId;
  final String bigImage;
  final String smallImage;
  final String ageLimit;
  final String firstName;
  final String lastName;
  final String education;
  final String gender;
  final String qualification;
  final String contactNumber;
  final String certifications;
  final String awards;
  final String about;
  final String specialties;
  final String description;
  final String facebookUrl;
  final String twitterUrl;
  final String googleUrl;
  final String linkedinUrl;
  final String email;
  final String image;
  final String address;
  final String city;
  final String state;
  final String zip;

  DoctorListResponse({
    required this.id,
    required this.skillId,
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
    required this.about,
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

  factory DoctorListResponse.fromJson(Map<String, dynamic> json) {
    return DoctorListResponse(
      id: json['id'],
      skillId: json['skill_id'],
      bigImage: json['big_image'],
      smallImage: json['small_image'],
      ageLimit: json['age_limit'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      education: json['education'],
      gender: json['gender'],
      qualification: json['qualification'],
      contactNumber: json['contact_number'],
      certifications: json['certifications'],
      awards: json['awards'],
      about: json['about_of'],
      specialties: json['specialties'],
      description: json['description'],
      facebookUrl: json['facebook_url'],
      twitterUrl: json['twitter_url'],
      googleUrl: json['google_url'],
      linkedinUrl: json['linkedin_url'],
      email: json['email'],
      image: json['image'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
    );
  }
}
