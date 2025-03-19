import 'package:drs_booking/common/AppColors.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:drs_booking/common/shared_pref.dart';
import 'package:drs_booking/doctors/model/doctor_list_model.dart';
import 'package:drs_booking/doctors/view/doctor_details_screen.dart';
import 'package:drs_booking/search/model/search_doctor_model.dart';
import 'package:drs_booking/search/viewModel/search_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  late SearchScreenViewModel searchScreenViewModel = SearchScreenViewModel();

  final TextEditingController _specializationSearchController =
      TextEditingController();

  final TextEditingController _cityStateSearchController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    searchScreenViewModel = SearchScreenViewModel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchScreenViewModel.fetchSkillsList(context);
    });
  }

  late String dateOfBirth = '';

  String? selectedSkill;

  String? selectedCityState;

  String? cityId;

  String? skillId;

  Future<void> _getSharedPrefData(String skillId, String cityStateZip) async {
    await SharedPrefsHelper.init();
    dateOfBirth = SharedPrefsHelper.getString('dateOfBirth') ?? '';
    searchScreenViewModel.fetchDoctorsListBySkillStateCity(
        cityStateZip, skillId, dateOfBirth, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider<SearchScreenViewModel>(
        create: (BuildContext context) => searchScreenViewModel,
        child: Consumer<SearchScreenViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
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
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedSkill,
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.black),
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'MetrischRegular',
                        fontSize: 16,
                      ),
                      hint: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.black),
                          SizedBox(width: 5),
                          Text(
                            "Search Specialization",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'MetrischRegular',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      items: searchScreenViewModel.skillsList.map((skill) {
                        return DropdownMenuItem<String>(
                          value: skill.name,
                          child: Text(skill.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'MetrischRegular',
                                fontSize: 16,
                              )),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSkill = value;
                          _specializationSearchController.text = value!;
                          skillId = searchScreenViewModel.skillsList
                              .firstWhere((skill) => skill.name == value)
                              .id
                              .toString();
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
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
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedCityState,
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.black),
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'MetrischRegular',
                        fontSize: 16,
                      ),
                      hint: const Row(
                        children: [
                          Icon(Icons.location_city, color: Colors.black),
                          SizedBox(width: 5),
                          Text(
                            "Select City/State",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'MetrischRegular',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      items: searchScreenViewModel.cityStateList.map((city) {
                        return DropdownMenuItem<String>(
                          value: city.cityName,
                          child: Text(city.cityName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'MetrischRegular',
                                fontSize: 16,
                              )),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCityState = value;
                          _cityStateSearchController.text = value!;
                          cityId = searchScreenViewModel.cityStateList
                              .firstWhere((city) => city.cityName == value)
                              .id
                              .toString();
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _getSharedPrefData(selectedSkill!, selectedCityState!);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.customLightGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(AppStrings.search,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: 'MetrischSemiBold',
                        )),
                  ),
                ),
                const SizedBox(height: 10),
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
                                searchScreenViewModel: searchScreenViewModel,
                                character: viewModel.doctorsList[index]);
                          },
                        ),
                      ),
                const SizedBox(height: 1),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ListViewCard extends StatelessWidget {
  const ListViewCard(
      {super.key,
      required this.index,
      required this.searchScreenViewModel,
      required this.character});

  final SearchDoctorResponse character;

  final int index;

  final SearchScreenViewModel searchScreenViewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: DoctorDetailsScreen(
            localDoctorId: character.id,
            localDoctorName: character.firstName,
            localDoctorAddress: character.address,
            localDoctorCity: character.city,
            localDoctorState: character.state,
            localDoctorEducation: character.education,
            localDoctorAbout: character.aboutOf,
            localDoctorContactNumber: character.contactNumber,
            localDoctorQualification: character.qualification,
            localDoctorSpecialties: character.specialties,
            localDoctorAwards: character.awards,
            localDoctorImage:
                'http://drsbooking.desss-portfolio.com/assets/images/drs-booking/350/${character.bigImage}',
            localDoctorAgeLimit: character.ageLimit,
          ),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
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
