import 'package:drs_booking/appointments/appointments_tab/model/appointments_tab_model.dart';
import 'package:drs_booking/appointments/appointments_tab/viewModel/onGoing_appointments_tab_view_model.dart';
import 'package:drs_booking/appointments/view/re_schedule_appointments_screen.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:drs_booking/common/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class OnGoingAppointmentsTab extends StatefulWidget {
  const OnGoingAppointmentsTab({super.key});

  @override
  OnGoingAppointmentsTabState createState() => OnGoingAppointmentsTabState();
}

class OnGoingAppointmentsTabState extends State<OnGoingAppointmentsTab> {
  final OngoingAppointmentsTabViewModel ongoingAppointmentsTabViewModel =
      OngoingAppointmentsTabViewModel();

  late String userId = '';

  @override
  void initState() {
    super.initState();
    _getSharedPrefData();
  }

  Future<void> _getSharedPrefData() async {
    await SharedPrefsHelper.init();
    userId = SharedPrefsHelper.getString('user_id') ?? '';
    ongoingAppointmentsTabViewModel.fetchAppointmentsList(userId, context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ChangeNotifierProvider<OngoingAppointmentsTabViewModel>(
            create: (BuildContext context) => ongoingAppointmentsTabViewModel,
            child: Consumer<OngoingAppointmentsTabViewModel>(
                builder: (context, viewModel, child) {
              return Column(
                children: [
                  const SizedBox(height: 15),
                  viewModel.noOnGoingAppointments
                      ? Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('assets/noData/noData.json',
                                    width: 200, height: 200),
                                const Text(
                                  AppStrings.noAppointments,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'MetrischRegular',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: viewModel.appointmentsList.length,
                            itemBuilder: (context, index) {
                              return ListViewCard(
                                  index: index,
                                  userId: userId,
                                  ongoingAppointmentsTabViewModel:
                                      ongoingAppointmentsTabViewModel,
                                  character: viewModel.appointmentsList[index]);
                            },
                          ),
                        ),
                  const SizedBox(height: 1),
                ],
              );
            }),
          )),
    );
  }
}

class ListViewCard extends StatelessWidget {
  const ListViewCard(
      {super.key,
      required this.index,
      required this.userId,
      required this.ongoingAppointmentsTabViewModel,
      required this.character});

  final AppointmentsTabResponse character;

  final int index;

  final String userId;

  final OngoingAppointmentsTabViewModel ongoingAppointmentsTabViewModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    "http://drsbooking.desss-portfolio.com/assets/images/drs-booking/${character.image}",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person, size: 100),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${character.firstName} ${character.lastName}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'MetrischSemiBold',
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        character.reasonToVisit,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontFamily: 'MetrischRegular',
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        character.address,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontFamily: 'MetrischRegular',
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.date_range,
                              color: Colors.grey, size: 18),
                          const SizedBox(width: 5),
                          Text(
                            character.date,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontFamily: 'MetrischRegular',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              color: Colors.grey, size: 18),
                          const SizedBox(width: 5),
                          Text(
                            character.time,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontFamily: 'MetrischRegular',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: ReScheduleAppointmentsScreen(
                        localAppointmentId: character.id,
                        localDoctorId: character.doctorId,
                        localAppointmentDate: character.date,
                        localAppointmentTime: character.time,
                        localAppointmentReason: character.reasonToVisit,
                        localDoctorVisit: character.visitDoctor,
                        localFirstName: character.firstName,
                        localState: character.state,
                      ),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(AppStrings.reSchedule,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'MetrischSemiBold',
                      )),
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool? cancel = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text(
                          "Are you sure you want to cancel?",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'MetrischRegular',
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text(
                              "No",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MetrischRegular',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop(true);
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MetrischRegular',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                    if (cancel == true) {
                      ongoingAppointmentsTabViewModel.cancelAppointments(
                          userId, character.id, context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(AppStrings.cancel,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'MetrischSemiBold',
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
