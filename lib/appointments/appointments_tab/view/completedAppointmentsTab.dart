import 'package:drs_booking/appointments/appointments_tab/model/appointments_tab_model.dart';
import 'package:drs_booking/appointments/appointments_tab/viewModel/completed_appointments_tab_view_model.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:drs_booking/common/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CompletedAppointmentsTab extends StatefulWidget {
  const CompletedAppointmentsTab({super.key});

  @override
  CompletedAppointmentsTabState createState() =>
      CompletedAppointmentsTabState();
}

class CompletedAppointmentsTabState extends State<CompletedAppointmentsTab> {
  final CompletedAppointmentsTabViewModel completedAppointmentsTabViewModel =
      CompletedAppointmentsTabViewModel();

  late String userId = '';

  @override
  void initState() {
    super.initState();
    _getSharedPrefData();
  }

  Future<void> _getSharedPrefData() async {
    await SharedPrefsHelper.init();
    userId = SharedPrefsHelper.getString('user_id') ?? '';
    completedAppointmentsTabViewModel.fetchAppointmentsList(userId, context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ChangeNotifierProvider<CompletedAppointmentsTabViewModel>(
            create: (BuildContext context) => completedAppointmentsTabViewModel,
            child: Consumer<CompletedAppointmentsTabViewModel>(
                builder: (context, viewModel, child) {
              return Column(
                children: [
                  const SizedBox(height: 15),
                  viewModel.noCompletedAppointments
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
                                  completedAppointmentsTabViewModel:
                                      completedAppointmentsTabViewModel,
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
      required this.completedAppointmentsTabViewModel,
      required this.character});

  final AppointmentsTabResponse character;

  final int index;

  final CompletedAppointmentsTabViewModel completedAppointmentsTabViewModel;

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
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
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
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range,
                        size: 20,
                        color: Colors.grey,
                      ),
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
                      const Icon(
                        Icons.access_time,
                        size: 20,
                        color: Colors.grey,
                      ),
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
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
