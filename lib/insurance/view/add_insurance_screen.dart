import 'package:dropdown_search/dropdown_search.dart';
import 'package:drs_booking/common/AppColors.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:drs_booking/common/shared_pref.dart';
import 'package:drs_booking/insurance/viewModel/add_insurance_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddInsuranceScreen extends StatefulWidget {
  const AddInsuranceScreen({super.key});

  @override
  AddInsuranceScreenState createState() => AddInsuranceScreenState();
}

class AddInsuranceScreenState extends State<AddInsuranceScreen> {
  final AddInsuranceViewModel addInsuranceViewModel = AddInsuranceViewModel();

  late String userId = '';

  @override
  void initState() {
    super.initState();
    _getSharedPrefData();
  }

  Future<void> _getSharedPrefData() async {
    await SharedPrefsHelper.init();
    userId = SharedPrefsHelper.getString('user_id') ?? '';
    addInsuranceViewModel.fetchInsuranceTitleList(context);
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
              AppStrings.addInsurances,
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
          body: ChangeNotifierProvider<AddInsuranceViewModel>(
            create: (BuildContext context) => addInsuranceViewModel,
            child: Consumer<AddInsuranceViewModel>(
                builder: (context, viewModel, child) {
              return Column(
                children: [
                  const SizedBox(height: 15),
                  Stack(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              AppStrings.title,
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.black,
                                fontFamily: 'MetrischSemiBold',
                              ),
                            ),
                            const SizedBox(height: 10),
                            DropdownSearch<String>(
                              items: (filter, infiniteScrollProps) =>
                                  viewModel.insuranceTitles,
                              decoratorProps: const DropDownDecoratorProps(
                                decoration: InputDecoration(
                                  labelText: AppStrings.searchInsurances,
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: 'MetrischSemiBold',
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    labelText: AppStrings.search,
                                    labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'MetrischSemiBold',
                                    ),
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                                menuProps: MenuProps(
                                  backgroundColor: Colors.white,
                                  elevation: 4,
                                ),
                              ),
                              onChanged: (value) {
                                print("Selected: $value");
                              },
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              AppStrings.frontSideDocument,
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.black,
                                fontFamily: 'MetrischSemiBold',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/dummy_image.jpg'), // Update the path
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(Icons.upload_file),
                                  color: Colors.black,
                                  onPressed: () {
                                    // Handle upload action
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Back Document
                            const Text(
                              AppStrings.backSideDocument,
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.black,
                                fontFamily: 'MetrischSemiBold',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/dummy_image.jpg'), // Update the path
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(Icons.upload_file),
                                  color: Colors.black,
                                  onPressed: () {
                                    // Handle upload action
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                  backgroundColor: AppColors.customLightGreen,
                                ),
                                child: const Text(
                                  AppStrings.addInsurance,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'MetrischSemiBold',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                ],
              );
            }),
          )),
    );
  }
}
