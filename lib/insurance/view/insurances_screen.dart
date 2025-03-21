import 'package:drs_booking/common/AppColors.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:drs_booking/common/shared_pref.dart';
import 'package:drs_booking/insurance/view/add_insurance_screen.dart';
import 'package:drs_booking/insurance/model/insurance_model.dart';
import 'package:drs_booking/insurance/view/insurance_detail_screen.dart';
import 'package:drs_booking/insurance/viewModel/insurance_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class InsurancesScreen extends StatefulWidget {
  const InsurancesScreen({super.key});

  @override
  InsurancesScreenState createState() => InsurancesScreenState();
}

class InsurancesScreenState extends State<InsurancesScreen> {
  final InsuranceViewModel insuranceViewModel = InsuranceViewModel();

  late String userId = '';

  @override
  void initState() {
    super.initState();
    _getSharedPrefData();
  }

  Future<void> _getSharedPrefData() async {
    await SharedPrefsHelper.init();
    userId = SharedPrefsHelper.getString('user_id') ?? '';
    insuranceViewModel.fetchInsuranceList(userId, context);
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
              AppStrings.insurance,
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
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.black,
                  size: 30.0,
                ),
                onPressed: () async {
                  bool? isAdded = await Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const AddInsuranceScreen();
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                            position: offsetAnimation, child: child);
                      },
                    ),
                  );
                  // Refresh data if updated
                  if (isAdded == true) {
                    insuranceViewModel.fetchInsuranceList(userId, context);
                  }
                },
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: ChangeNotifierProvider<InsuranceViewModel>(
            create: (BuildContext context) => insuranceViewModel,
            child: Consumer<InsuranceViewModel>(
                builder: (context, viewModel, child) {
              return Column(
                children: [
                  const SizedBox(height: 15),
                  viewModel.noInsurance
                      ? Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('assets/noData/noData.json',
                                    width: 200, height: 200),
                                const Text(
                                  AppStrings.noInsurances,
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
                            itemCount: viewModel.insuranceList.length,
                            itemBuilder: (context, index) {
                              return ListViewCard(
                                  index: index,
                                  insuranceViewModel: insuranceViewModel,
                                  character: viewModel.insuranceList[index]);
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
      required this.insuranceViewModel,
      required this.character});

  final InsuranceResponse character;

  final int index;

  final InsuranceViewModel insuranceViewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool? isUpdated = await Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return InsuranceDetailScreen(
                localInsuranceId: character.id,
                localFrontImage: character.frontImage,
                localBackImage: character.backImage,
                localIsActive: character.isActive,
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );

        // Refresh data if updated
        if (isUpdated == true) {
          insuranceViewModel.fetchInsuranceList(character.userId, context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          color: AppColors.customLightGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    character.name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'MetrischRegular',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_forever_outlined,
                      color: Colors.red),
                  onPressed: () async {
                    bool? delete = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text(
                          "Are you sure you want to delete?",
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
                    if (delete == true) {
                      insuranceViewModel.deleteInsuranceApiById(
                          character.id, character.userId, context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
