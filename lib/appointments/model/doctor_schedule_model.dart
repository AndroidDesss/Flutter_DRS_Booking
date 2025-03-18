class DoctorScheduleResponse {
  final String day;
  final String startTime;
  final String endTime;
  final String lunchStart;
  final String lunchEnd;
  final String slotLength;
  final String isDayOff;

  DoctorScheduleResponse({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.lunchStart,
    required this.lunchEnd,
    required this.slotLength,
    required this.isDayOff,
  });

  factory DoctorScheduleResponse.fromJson(Map<String, dynamic> json) {
    return DoctorScheduleResponse(
      day: json['day'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      lunchStart: json['lunch_start'],
      lunchEnd: json['lunch_end'],
      slotLength: json['slot_length'],
      isDayOff: json['is_day_off'],
    );
  }
}
