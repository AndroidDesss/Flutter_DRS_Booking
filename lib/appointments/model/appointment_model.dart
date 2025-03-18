class AppointmentResponse {
  String? id;
  String? websiteId;
  String? pageId;
  String? doctorId;
  String? time;
  String? date;
  String? actualTime;
  String? patientId;
  String? reasonToVisit;
  String? reasonToInsurance;
  String? byInsurance;
  String? procedureToVisit;
  String? visitDoctor;
  String? status;
  String? visited;
  String? visited12345;
  String? note;
  String? checkinNumber;
  String? checkinStatus;
  String? createdAt;
  String? updatedAt;
  String? isDeleted;
  String? bookedFrom;
  String? lab;
  String? mri;
  String? radiology;
  String? appointmentType;

  AppointmentResponse({
    this.id,
    this.websiteId,
    this.pageId,
    this.doctorId,
    this.time,
    this.date,
    this.actualTime,
    this.patientId,
    this.reasonToVisit,
    this.reasonToInsurance,
    this.byInsurance,
    this.procedureToVisit,
    this.visitDoctor,
    this.status,
    this.visited,
    this.visited12345,
    this.note,
    this.checkinNumber,
    this.checkinStatus,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.bookedFrom,
    this.lab,
    this.mri,
    this.radiology,
    this.appointmentType,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentResponse(
      id: json['id'],
      websiteId: json['website_id'],
      pageId: json['page_id'],
      doctorId: json['doctor_id'],
      time: json['time'],
      date: json['date'],
      actualTime: json['actual_time'],
      patientId: json['patient_id'],
      reasonToVisit: json['reason_to_visit'],
      reasonToInsurance: json['reason_to_insurance'],
      byInsurance: json['by_insurance'],
      procedureToVisit: json['procedure_to_visit'],
      visitDoctor: json['visitdoctor'],
      status: json['status'],
      visited: json['visited'],
      visited12345: json['visited12345'],
      note: json['note'],
      checkinNumber: json['checkin_number'],
      checkinStatus: json['checkin_status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isDeleted: json['is_deleted'],
      bookedFrom: json['booked_from'],
      lab: json['lab'],
      mri: json['mri'],
      radiology: json['radiology'],
      appointmentType: json['appointment_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'website_id': websiteId,
      'page_id': pageId,
      'doctor_id': doctorId,
      'time': time,
      'date': date,
      'actual_time': actualTime,
      'patient_id': patientId,
      'reason_to_visit': reasonToVisit,
      'reason_to_insurance': reasonToInsurance,
      'by_insurance': byInsurance,
      'procedure_to_visit': procedureToVisit,
      'visitdoctor': visitDoctor,
      'status': status,
      'visited': visited,
      'visited12345': visited12345,
      'note': note,
      'checkin_number': checkinNumber,
      'checkin_status': checkinStatus,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_deleted': isDeleted,
      'booked_from': bookedFrom,
      'lab': lab,
      'mri': mri,
      'radiology': radiology,
      'appointment_type': appointmentType,
    };
  }
}
