import 'package:drs_booking/appointments/model/time_model.dart';
import 'package:drs_booking/appointments/viewModel/doctor_appointment_view_model.dart';
import 'package:drs_booking/authentication/view/login_screen.dart';
import 'package:drs_booking/common/AppColors.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/shared_pref.dart';
import 'package:drs_booking/dashboard/dash_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentsScreen extends StatefulWidget {
  final String localDoctorId;
  final String localDoctorName;
  final String localDoctorCity;
  final String localDoctorAgeLimit;

  const AppointmentsScreen(
      {super.key,
      required this.localDoctorId,
      required this.localDoctorName,
      required this.localDoctorCity,
      required this.localDoctorAgeLimit});

  @override
  AppointmentsScreenState createState() => AppointmentsScreenState();
}

class AppointmentsScreenState extends State<AppointmentsScreen> {
  final DoctorAppointmentViewModel doctorAppointmentViewModel =
      DoctorAppointmentViewModel();

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  String currentDate = '';

  String userId = '';

  String isInsurance = '';

  int selectedIndex = -1;

  String userAgeLimit = '';

  String selectedVisitOption = 'yes';

  late TextEditingController _reasonToVisitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getSharedPrefData();
    _reasonToVisitController = TextEditingController();
  }

  Future<void> _getSharedPrefData() async {
    currentDate = CommonUtilities.getCurrentDate();
    await SharedPrefsHelper.init();
    userId = SharedPrefsHelper.getString('user_id') ?? '';
    isInsurance = SharedPrefsHelper.getString('is_insurance') ?? '';
    userAgeLimit = SharedPrefsHelper.getString('ageLimit') ?? '';
    getCurrentDayOfWeek(currentDate);
  }

  void getCurrentDayOfWeek(String currentDate) {
    DateTime now = DateTime.now();
    String currentDateOfWeek = DateFormat('EEEE').format(now);
    doctorAppointmentViewModel.fetchDoctorsSchedule(
        widget.localDoctorId, currentDateOfWeek, currentDate, context);
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              AppStrings.makeAppointment,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'MetrischSemiBold',
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: ChangeNotifierProvider<DoctorAppointmentViewModel>(
                    create: (BuildContext context) =>
                        doctorAppointmentViewModel,
                    child: Consumer<DoctorAppointmentViewModel>(
                      builder: (context, viewModel, child) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.white,
                                child: TableCalendar(
                                  firstDay: DateTime.now(),
                                  lastDay: DateTime(2030),
                                  focusedDay: _focusedDay,
                                  selectedDayPredicate: (day) =>
                                      isSameDay(_selectedDay, day),
                                  onDaySelected: (selectedDay, focusedDay) {
                                    setState(() {
                                      _selectedDay = selectedDay;
                                      _focusedDay = focusedDay;
                                      currentDate = DateFormat('MM-dd-yyyy')
                                          .format(selectedDay);
                                    });
                                    String dayOfWeek =
                                        _getDayOfWeek(selectedDay.weekday);
                                    doctorAppointmentViewModel
                                        .fetchDoctorsSchedule(
                                            widget.localDoctorId,
                                            dayOfWeek,
                                            currentDate,
                                            context);
                                  },
                                  calendarStyle: const CalendarStyle(
                                    isTodayHighlighted: false,
                                    selectedDecoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    weekendTextStyle: TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'MetrischSemiBold',
                                        fontWeight: FontWeight.bold),
                                    defaultTextStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'MetrischRegular',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  headerStyle: const HeaderStyle(
                                    formatButtonVisible: false,
                                    titleTextStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'MetrischSemiBold',
                                    ),
                                    titleCentered: true,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              viewModel.notAvailable
                                  ? const Center(
                                      child: Text(
                                        AppStrings.noSlotsAvailable,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'MetrischRegular',
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          AppStrings.slots,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'MetrischSemiBold',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5),
                                        SizedBox(
                                          height: 50,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                viewModel.timeModelsList.length,
                                            itemBuilder: (context, index) {
                                              return ListViewCard(
                                                index: index,
                                                doctorAppointmentViewModel:
                                                    doctorAppointmentViewModel,
                                                character:
                                                    doctorAppointmentViewModel
                                                        .timeModelsList[index],
                                                isSelected:
                                                    index == selectedIndex,
                                                onTap: () {
                                                  setState(() {
                                                    selectedIndex = index;
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        TextField(
                                          controller: _reasonToVisitController,
                                          style: const TextStyle(
                                            fontFamily: 'MetrischRegular',
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: AppStrings.reasonToVisit,
                                            hintStyle: const TextStyle(
                                              fontFamily: 'MetrischRegular',
                                              color: Colors.blueGrey,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          AppStrings.visit,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'MetrischSemiBold',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                              value: 'yes',
                                              groupValue: selectedVisitOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedVisitOption = value!;
                                                });
                                              },
                                            ),
                                            const Text('Yes',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily:
                                                        'MetrischSemiBold',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(width: 20),
                                            Radio(
                                              value: 'no',
                                              groupValue: selectedVisitOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedVisitOption = value!;
                                                });
                                              },
                                            ),
                                            const Text('No',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily:
                                                        'MetrischSemiBold',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                      ],
                                    ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Bottom Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () async {
                    await SharedPrefsHelper.init();
                    userId = SharedPrefsHelper.getString('user_id') ?? '';
                    isInsurance =
                        SharedPrefsHelper.getString('is_insurance') ?? '';
                    userAgeLimit =
                        SharedPrefsHelper.getString('ageLimit') ?? '';

                    if (selectedIndex == -1) {
                      CommonUtilities.showToast(context,
                          message: 'Please select a time slot!');
                      return;
                    } else if (_reasonToVisitController.text.trim().isEmpty) {
                      CommonUtilities.showToast(context,
                          message: 'Please enter a reason for the visit!');
                      return;
                    } else {
                      if (userId == "" && userId.isEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      } else {
                        if (int.parse(userAgeLimit) <=
                            int.parse(widget.localDoctorAgeLimit)) {
                          String selectedTime = doctorAppointmentViewModel
                              .timeModelsList[selectedIndex].time;
                          doctorAppointmentViewModel.bookAppointments(
                              widget.localDoctorId,
                              userId,
                              selectedTime,
                              currentDate,
                              _reasonToVisitController.text.trim(),
                              selectedVisitOption,
                              context);
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: AppColors.customLightGreen,
                  ),
                  child: const Text(
                    AppStrings.bookAppointment,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'MetrischSemiBold',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class ListViewCard extends StatelessWidget {
  const ListViewCard({
    super.key,
    required this.index,
    required this.doctorAppointmentViewModel,
    required this.character,
    required this.isSelected,
    required this.onTap,
  });

  final TimeResponse character;
  final int index;
  final DoctorAppointmentViewModel doctorAppointmentViewModel;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          margin: const EdgeInsets.only(left: 5),
          width: 120,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              character.time,
              style: TextStyle(
                fontFamily: 'MetrischSemiBold',
                fontSize: 16,
                color: isSelected ? Colors.white : const Color(0xFF000000),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
