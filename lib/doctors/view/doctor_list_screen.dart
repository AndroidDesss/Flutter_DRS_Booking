import 'package:drs_booking/common/AppStrings.dart';
import 'package:drs_booking/common/shared_pref.dart';
import 'package:drs_booking/doctors/model/doctor_list_model.dart';
import 'package:drs_booking/doctors/view/doctor_details_screen.dart';
import 'package:drs_booking/doctors/viewModel/doctor_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DoctorListScreen extends StatefulWidget {
  final String localSkillId;

  const DoctorListScreen({super.key, required this.localSkillId});

  @override
  DoctorListScreenState createState() => DoctorListScreenState();
}

class DoctorListScreenState extends State<DoctorListScreen> {
  final DoctorListViewModel doctorListViewModel = DoctorListViewModel();

  final TextEditingController _searchController = TextEditingController();

  late String dateOfBirth = '';

  @override
  void initState() {
    super.initState();
    _getSharedPrefData();
  }

  Future<void> _getSharedPrefData() async {
    await SharedPrefsHelper.init();
    dateOfBirth = SharedPrefsHelper.getString('dateOfBirth') ?? '';
    doctorListViewModel.fetchDoctorsList(
        widget.localSkillId, dateOfBirth, context);
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
              AppStrings.findYourDoctor,
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
          body: ChangeNotifierProvider<DoctorListViewModel>(
            create: (BuildContext context) => doctorListViewModel,
            child: Consumer<DoctorListViewModel>(
                builder: (context, viewModel, child) {
              return Column(
                children: [
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: TextFormField(
                              controller: _searchController,
                              onChanged: (value) {
                                viewModel.searchSkills(value);
                              },
                              style: const TextStyle(
                                color: Colors.black, // Text color
                                fontFamily: 'MetrischRegular',
                                fontSize: 16,
                              ),
                              decoration: const InputDecoration(
                                hintText: "Search",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MetrischRegular',
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  viewModel.noDoctors
                      ? Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('assets/noData/noData.json',
                                    width: 200, height: 200),
                                const Text(
                                  AppStrings.noDoctors,
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
                            itemCount: viewModel.doctorsList.length,
                            itemBuilder: (context, index) {
                              return ListViewCard(
                                  index: index,
                                  doctorListViewModel: doctorListViewModel,
                                  character: viewModel.doctorsList[index]);
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
      required this.doctorListViewModel,
      required this.character});

  final DoctorListResponse character;

  final int index;

  final DoctorListViewModel doctorListViewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return DoctorDetailsScreen(
                localDoctorId: character.id,
                localDoctorName: character.firstName,
                localDoctorAddress: character.address,
                localDoctorCity: character.city,
                localDoctorState: character.state,
                localDoctorEducation: character.education,
                localDoctorAbout: character.about,
                localDoctorContactNumber: character.contactNumber,
                localDoctorQualification: character.qualification,
                localDoctorSpecialties: character.specialties,
                localDoctorAwards: character.awards,
                localDoctorImage:
                    'http://drsbooking.desss-portfolio.com/assets/images/drs-booking/350/${character.bigImage}',
                localDoctorAgeLimit: character.ageLimit,
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0); // Start from right to left
              const end = Offset.zero; // End at current position
              const curve = Curves.easeInOut; // Smooth transition
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shadowColor: Colors.grey,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Row(
          children: [
            const SizedBox(width: 10),
            Image.network(
                "http://drsbooking.desss-portfolio.com/assets/images/drs-booking/250/${character.smallImage}",
                fit: BoxFit.cover,
                width: 80,
                height: 80, loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            }, errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.broken_image, size: 80, color: Colors.grey),
              );
            }),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    character.firstName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'MetrischSemiBold',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    character.address,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontFamily: 'MetrischRegular',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    character.contactNumber,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontFamily: 'MetrischRegular',
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
