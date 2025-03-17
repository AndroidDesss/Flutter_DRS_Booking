class LoginScreenResponse {
  final String id;
  final String websiteId;
  final String userName;
  final String email;
  final String password;
  final String passwordEncode;
  final String registerKeys;
  final String registerValues;
  final String customerType;
  final String multiplier;
  final String isDeleted;
  final String createdAt;
  final String updatedAt;
  final String guestUserId;
  final String verifyEmailAddress;
  final String registeredFrom;
  final String gender;
  final String dob;
  final String dobAlter;
  final String phone;
  final String verifyPhone;
  final String registerType;
  final String frontImage;
  final String backImage;
  final String isInsurance;
  final String mrn;
  final String date;
  final String firstName;
  final String lastName;
  final String middleInitial;
  final String nickname;
  final String socialSecurityNumber;
  final String maritalStatus;
  final String languageOtherThanEnglish;
  final String race;
  final String homeAddress;
  final String ape;
  final String city;
  final String state;
  final String zip;
  final String homePhone;
  final String workPhone;
  final String otherPhone;
  final String? cellNumber;
  final String emailAddress;
  final String employmentStatus;
  final String employer;
  final String employerPhone;
  final String? relationshipToPatient;

  LoginScreenResponse({
    required this.id,
    required this.websiteId,
    required this.userName,
    required this.email,
    required this.password,
    required this.passwordEncode,
    required this.registerKeys,
    required this.registerValues,
    required this.customerType,
    required this.multiplier,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.guestUserId,
    required this.verifyEmailAddress,
    required this.registeredFrom,
    required this.gender,
    required this.dob,
    required this.dobAlter,
    required this.phone,
    required this.verifyPhone,
    required this.registerType,
    required this.frontImage,
    required this.backImage,
    required this.isInsurance,
    required this.mrn,
    required this.date,
    required this.firstName,
    required this.lastName,
    required this.middleInitial,
    required this.nickname,
    required this.socialSecurityNumber,
    required this.maritalStatus,
    required this.languageOtherThanEnglish,
    required this.race,
    required this.homeAddress,
    required this.ape,
    required this.city,
    required this.state,
    required this.zip,
    required this.homePhone,
    required this.workPhone,
    required this.otherPhone,
    this.cellNumber,
    required this.emailAddress,
    required this.employmentStatus,
    required this.employer,
    required this.employerPhone,
    this.relationshipToPatient,
  });

  factory LoginScreenResponse.fromJson(Map<String, dynamic> json) {
    return LoginScreenResponse(
      id: json['id'],
      websiteId: json['website_id'],
      userName: json['user_name'],
      email: json['email'],
      password: json['password'],
      passwordEncode: json['password_encode'],
      registerKeys: json['register_keys'],
      registerValues: json['register_values'],
      customerType: json['customer_type'],
      multiplier: json['multiplier'],
      isDeleted: json['is_deleted'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      guestUserId: json['guest_user_id'],
      verifyEmailAddress: json['verify_email_address'],
      registeredFrom: json['registered_from'],
      gender: json['gender'],
      dob: json['dob'],
      dobAlter: json['dob_alter'],
      phone: json['phone'],
      verifyPhone: json['verify_phone'],
      registerType: json['register_type'],
      frontImage: json['front_image'],
      backImage: json['back_image'],
      isInsurance: json['is_insurance'],
      mrn: json['mrn'],
      date: json['date'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      middleInitial: json['middle_initial'],
      nickname: json['nickname'],
      socialSecurityNumber: json['social_security_number'],
      maritalStatus: json['marital_status'],
      languageOtherThanEnglish: json['language_other_than_english'],
      race: json['race'],
      homeAddress: json['home_address'],
      ape: json['ape'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
      homePhone: json['home_phone'],
      workPhone: json['work_phone'],
      otherPhone: json['other_phone'],
      cellNumber: json['cell_number'],
      emailAddress: json['email_address'],
      employmentStatus: json['employment_status'],
      employer: json['employer'],
      employerPhone: json['employer_phone'],
      relationshipToPatient: json['relationship_to_patient'],
    );
  }
}
