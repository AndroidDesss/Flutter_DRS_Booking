import 'package:drs_booking/common/AppColors.dart';
import 'package:drs_booking/common/AppStrings.dart';
import 'package:drs_booking/insurance/viewModel/edit_insurance_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InsuranceDetailScreen extends StatefulWidget {
  final String localInsuranceId;
  final String localFrontImage;
  final String localBackImage;
  final String localIsActive;

  const InsuranceDetailScreen(
      {super.key,
      required this.localInsuranceId,
      required this.localFrontImage,
      required this.localBackImage,
      required this.localIsActive});

  @override
  InsuranceDetailScreenState createState() => InsuranceDetailScreenState();
}

class InsuranceDetailScreenState extends State<InsuranceDetailScreen> {
  final EditInsuranceViewModel editInsuranceViewModel =
      EditInsuranceViewModel();

  bool isSwitched = false;

  @override
  void initState() {
    super.initState();

    if (widget.localIsActive == "1") {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  void showFullImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                Center(
                  child: InteractiveViewer(
                    child: Image.network(imageUrl, fit: BoxFit.contain),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      'assets/images/close_image.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
              AppStrings.insuranceDetails,
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
          body: ChangeNotifierProvider<EditInsuranceViewModel>(
            create: (BuildContext context) => editInsuranceViewModel,
            child: Consumer<EditInsuranceViewModel>(
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
                            const SizedBox(height: 10),
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
                                SizedBox(
                                  width: 250,
                                  height: 200,
                                  child: Image.network(widget.localFrontImage,
                                      fit: BoxFit.cover, loadingBuilder:
                                          (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ));
                                  }, errorBuilder:
                                          (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(Icons.broken_image,
                                          size: 50, color: Colors.grey),
                                    );
                                  }),
                                ),
                                const SizedBox(width: 10),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showFullImage(
                                          context, widget.localFrontImage);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.customLightGreen,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text(AppStrings.view,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontFamily: 'MetrischSemiBold',
                                        )),
                                  ),
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
                                SizedBox(
                                  width: 250,
                                  height: 200,
                                  child: Image.network(widget.localBackImage,
                                      fit: BoxFit.cover, loadingBuilder:
                                          (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ));
                                  }, errorBuilder:
                                          (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(Icons.broken_image,
                                          size: 50, color: Colors.grey),
                                    );
                                  }),
                                ),
                                const SizedBox(width: 10),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showFullImage(
                                          context, widget.localBackImage);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.customLightGreen,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text(AppStrings.view,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontFamily: 'MetrischSemiBold',
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      AppStrings.isActive,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'MetrischSemiBold',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 10),
                                    Switch(
                                      value: isSwitched,
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitched = value;
                                        });
                                        editInsuranceViewModel
                                            .updateInsuranceStatusById(
                                                widget.localInsuranceId,
                                                isSwitched ? "1" : "0",
                                                context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
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
