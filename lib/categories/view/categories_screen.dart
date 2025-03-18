import 'package:drs_booking/categories/model/categories_model.dart';
import 'package:drs_booking/categories/viewModel/categories_view_model.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:drs_booking/doctors/view/doctor_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesViewModel categoriesViewModel = CategoriesViewModel();

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    categoriesViewModel.fetchSkillsList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider<CategoriesViewModel>(
        create: (BuildContext context) => categoriesViewModel,
        child: Consumer<CategoriesViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/categories_header_background.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: const Text(
                    AppStrings.categoriesContent,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'MetrischSemiBold',
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
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
                const SizedBox(height: 15),
                viewModel.noSkills
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
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: viewModel.skillsList.length,
                          itemBuilder: (context, index) {
                            return GridViewCard(
                                index: index,
                                categoriesViewModel: categoriesViewModel,
                                character: viewModel.skillsList[index]);
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

class GridViewCard extends StatelessWidget {
  const GridViewCard(
      {super.key,
      required this.index,
      required this.categoriesViewModel,
      required this.character});

  final CategoriesScreenResponse character;

  final int index;

  final CategoriesViewModel categoriesViewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: DoctorListScreen(localSkillId: character.id),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Column(
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: Image.network(
                "http://drsbooking.desss-portfolio.com/assets/images/drs-booking/drsnewicon/${character.image}",
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            }, errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
              );
            }),
          ),
          const SizedBox(height: 5),
          Text(
            character.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontFamily: 'MetrischRegular',
            ),
          ),
        ],
      ),
    );
  }
}
