import 'package:drs_booking/appointments/view/appointments_screen.dart';
import 'package:drs_booking/common/AppColors.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:flutter/material.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final String localDoctorId;
  final String localDoctorName;
  final String localDoctorAddress;
  final String localDoctorCity;
  final String localDoctorState;
  final String localDoctorEducation;
  final String localDoctorAbout;
  final String localDoctorContactNumber;
  final String localDoctorQualification;
  final String localDoctorSpecialties;
  final String localDoctorAwards;
  final String localDoctorImage;
  final String localDoctorAgeLimit;

  const DoctorDetailsScreen(
      {super.key,
      required this.localDoctorId,
      required this.localDoctorName,
      required this.localDoctorAddress,
      required this.localDoctorCity,
      required this.localDoctorState,
      required this.localDoctorEducation,
      required this.localDoctorAbout,
      required this.localDoctorContactNumber,
      required this.localDoctorQualification,
      required this.localDoctorSpecialties,
      required this.localDoctorAwards,
      required this.localDoctorImage,
      required this.localDoctorAgeLimit});

  @override
  DoctorDetailsScreenState createState() => DoctorDetailsScreenState();
}

class DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SizedBox(
                height: 210,
                width: double.infinity,
                child: Stack(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.zero, // Remove card margin
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox.expand(
                          child: Image.network(
                            widget.localDoctorImage,
                            fit: BoxFit.fill,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 100,
                                  color: Colors.black,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.localDoctorName,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'MetrischSemiBold',
                            )),
                        const SizedBox(height: 5),
                        const Text(AppStrings.qualification,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'MetrischSemiBold',
                            )),
                        Text(widget.localDoctorQualification,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontFamily: 'MetrischRegular',
                            )),
                        const SizedBox(height: 10),
                        const Text(AppStrings.specialties,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'MetrischSemiBold',
                            )),
                        Text(widget.localDoctorSpecialties,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontFamily: 'MetrischRegular',
                            )),
                        const SizedBox(height: 10),
                        const Text(AppStrings.awards,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'MetrischSemiBold',
                            )),
                        Text(widget.localDoctorAwards,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontFamily: 'MetrischRegular',
                            )),
                        const SizedBox(height: 10),
                        const Text(AppStrings.about,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'MetrischSemiBold',
                            )),
                        Text(widget.localDoctorAbout,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontFamily: 'MetrischRegular',
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return AppointmentsScreen(
                            localDoctorId: widget.localDoctorId,
                            localDoctorName: widget.localDoctorName,
                            localDoctorCity: widget.localDoctorCity,
                            localDoctorAgeLimit: widget.localDoctorAgeLimit,
                          );
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin =
                              Offset(1.0, 0.0); // Start from right to left
                          const end = Offset.zero; // End at current position
                          const curve = Curves.easeInOut; // Smooth transition
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: AppColors.customLightGreen,
                  ),
                  child: const Text(
                    AppStrings.makeAppointment,
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
