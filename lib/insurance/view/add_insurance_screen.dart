import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:drs_booking/common/AppColors.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:drs_booking/common/common_utilities.dart';
import 'package:drs_booking/common/shared_pref.dart';
import 'package:drs_booking/insurance/viewModel/add_insurance_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AddInsuranceScreen extends StatefulWidget {
  const AddInsuranceScreen({super.key});

  @override
  AddInsuranceScreenState createState() => AddInsuranceScreenState();
}

class AddInsuranceScreenState extends State<AddInsuranceScreen> {
  final AddInsuranceViewModel addInsuranceViewModel = AddInsuranceViewModel();

  late String userId = '';

  late String insuranceTitle = '';

  File? _frontImage;

  File? _backImage;

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

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  Future<void> _pickImage(bool isFront) async {
    await requestCameraPermission();
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        if (isFront) {
          _frontImage = File(pickedFile.path);
        } else {
          _backImage = File(pickedFile.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Padding(
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
                          insuranceTitle = value!;
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
                                image: _frontImage != null
                                    ? DecorationImage(
                                        image: FileImage(_frontImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/dummy_image.jpg'),
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
                            onPressed: () => _pickImage(true),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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
                                image: _backImage != null
                                    ? DecorationImage(
                                        image: FileImage(_backImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/dummy_image.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.upload_file),
                            color: Colors.black,
                            onPressed: () => _pickImage(false),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_frontImage == null) {
                              CommonUtilities.showToast(context,
                                  message:
                                      'Please upload the front side document');
                              return;
                            } else if (_backImage == null) {
                              CommonUtilities.showToast(context,
                                  message:
                                      'Please upload the back side document');
                              return;
                            } else if (insuranceTitle.isEmpty) {
                              CommonUtilities.showToast(context,
                                  message:
                                      'Please select an insurance title..!');
                              return;
                            } else {
                              viewModel.addNewInsurance(context, userId,
                                  insuranceTitle, _frontImage, _backImage);
                            }
                          },
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
          );
        }),
      ),
    );
  }
}
