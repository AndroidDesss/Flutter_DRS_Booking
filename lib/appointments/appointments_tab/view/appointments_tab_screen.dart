import 'package:drs_booking/appointments/appointments_tab/view/completedAppointmentsTab.dart';
import 'package:drs_booking/appointments/appointments_tab/view/missedAppointmentsTab.dart';
import 'package:drs_booking/appointments/appointments_tab/view/onGoingAppointmentsTab.dart';
import 'package:drs_booking/common/AppColors.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:flutter/material.dart';

class AppointmentsTabScreen extends StatefulWidget {
  const AppointmentsTabScreen({super.key});

  @override
  AppointmentsTabScreenState createState() => AppointmentsTabScreenState();
}

class AppointmentsTabScreenState extends State<AppointmentsTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
            child: Text('Appointments',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'MetrischSemiBold',
                    fontWeight: FontWeight.bold,
                    fontSize: 20))),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.customLightGreen,
          labelColor: AppColors.customLightGreen,
          unselectedLabelColor: Colors.black,
          indicatorWeight: 4.0,
          labelStyle: const TextStyle(
            fontFamily: 'MetrischSemiBold', // Custom font for selected tab
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          tabs: const [
            Tab(text: AppStrings.onGoing),
            Tab(text: AppStrings.missed),
            Tab(text: AppStrings.completed),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          OnGoingAppointmentsTab(),
          MissedAppointmentsTab(),
          CompletedAppointmentsTab(),
        ],
      ),
    );
  }
}
