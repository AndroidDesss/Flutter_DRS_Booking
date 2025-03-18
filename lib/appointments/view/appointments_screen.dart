import 'package:drs_booking/appointments/model/time_model.dart';
import 'package:drs_booking/appointments/viewModel/doctor_appointment_view_model.dart';
import 'package:drs_booking/common/AppColors.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/shared_pref.dart';
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

  String isInsurance = '';

  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _getSharedPrefData();
  }

  Future<void> _getSharedPrefData() async {
    currentDate = CommonUtilities.getCurrentDate();
    await SharedPrefsHelper.init();
    isInsurance = SharedPrefsHelper.getString('is_insurance')!;
    getCurrentDayOfWeek();
  }

  void getCurrentDayOfWeek() {
    DateTime now = DateTime.now();
    String currentDateOfWeek = DateFormat('EEEE').format(now);
    doctorAppointmentViewModel.fetchDoctorsSchedule(
        widget.localDoctorId, currentDateOfWeek, context);
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
          body: ChangeNotifierProvider<DoctorAppointmentViewModel>(
            create: (BuildContext context) => doctorAppointmentViewModel,
            child: Consumer<DoctorAppointmentViewModel>(
                builder: (context, viewModel, child) {
              return Expanded(
                child: Stack(
                  children: [
                    Padding(
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
                                });
                                String dayOfWeek =
                                    _getDayOfWeek(selectedDay.weekday);
                                doctorAppointmentViewModel.fetchDoctorsSchedule(
                                    widget.localDoctorId, dayOfWeek, context);
                              },
                              calendarStyle: const CalendarStyle(
                                isTodayHighlighted: false,
                                selectedDecoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                weekendTextStyle: TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'MetrischBold',
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
                                  fontFamily: 'MetrischBold',
                                ),
                                titleCentered: true,
                              ),
                              daysOfWeekStyle: const DaysOfWeekStyle(
                                  weekdayStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily:
                                        'MetrischBold', // Set your custom font
                                    fontWeight: FontWeight.bold,
                                  ),
                                  weekendStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily:
                                        'MetrischBold', // Set your custom font
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                          const SizedBox(height: 8),
                          viewModel.notAvailable
                              ? const Center(
                                  child: Text(
                                    AppStrings.noSlotsAvailable,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'MetrischMedium',
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      const Text(
                                        AppStrings.slots,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'MetrischBold',
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
                                            fontFamily: 'MetrischBold',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            value: true,
                                            groupValue: true,
                                            onChanged: (value) {},
                                          ),
                                          const Text('Yes',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'MetrischBold',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(width: 20),
                                          Radio(
                                            value: false,
                                            groupValue: true,
                                            onChanged: (value) {},
                                          ),
                                          const Text('No',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'MetrischBold',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      )
                                    ])
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !viewModel.notAvailable,
                      child: Positioned(
                        bottom: 15,
                        left: 15,
                        right: 15,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return AppointmentsScreen(
                                      localDoctorId: widget.localDoctorId,
                                      localDoctorName: widget.localDoctorName,
                                      localDoctorCity: widget.localDoctorCity,
                                      localDoctorAgeLimit:
                                          widget.localDoctorAgeLimit,
                                    );
                                  },
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(
                                        1.0, 0.0); // Start from right to left
                                    const end =
                                        Offset.zero; // End at current position
                                    const curve =
                                        Curves.easeInOut; // Smooth transition
                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);
                                    return SlideTransition(
                                        position: offsetAnimation,
                                        child: child);
                                  },
                                ),
                              );
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
                      ),
                    ),
                  ],
                ),
              );
            }),
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
    );
  }
}

class DoctorAppointmentScreen extends StatelessWidget {
  final String doctorId;
  final String day;

  const DoctorAppointmentScreen({
    Key? key,
    required this.doctorId,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DoctorAppointmentViewModel(),
      child: Consumer<DoctorAppointmentViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Doctor Appointment"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display a message if the doctor is not available
                  viewModel.notAvailable
                      ? Center(
                          child: Text(
                            "Doctor is not available",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Slots ListView
                            Expanded(
                              child: ListView.builder(
                                itemCount: viewModel.totalSlot.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(viewModel.totalSlot[index]),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Text Input for "Have you visited?"
                            TextField(
                              decoration: InputDecoration(
                                labelText: "Have you visited before?",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Radio Buttons (Example)
                            Row(
                              children: [
                                Radio(
                                  value: true,
                                  groupValue: true,
                                  onChanged: (value) {},
                                ),
                                const Text("Yes"),
                                Radio(
                                  value: false,
                                  groupValue: false,
                                  onChanged: (value) {},
                                ),
                                const Text("No"),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Bottom Book Appointment Button
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Booking logic here
                                },
                                child: const Text("Book Appointment"),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
