// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

// Import Component
import 'package:survey_io/components/input/input_label.dart';
import 'package:survey_io/components/padding/padding_horizontal.dart';
import 'package:survey_io/components/padding/padding_vertical.dart';
import 'package:survey_io/components/text/text_component.dart';
import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/components/image/image_component.dart';
import 'package:survey_io/components/divider/divider_component.dart';
import 'package:survey_io/components/button/text_button_component.dart';
import 'package:survey_io/components/navigation/navigation_bottom_bar.dart';
import 'package:survey_io/components/navigation/navigation_floating_icon.dart';

class ListPollingPage extends StatefulWidget {
  const ListPollingPage({super.key});

  @override
  State<ListPollingPage> createState() => _ListPollingPageState();
}

class _ListPollingPageState extends State<ListPollingPage> {
  int Page = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _handleTabChange(index) {
    if (index == 0) {
      print('Polling Baru selected');
    } else if (index == 1) {
      print('Polling Selesai selected');
    }
  }

  final List<Map<String, dynamic>> listPolling = [
    {
      "judulPolling": "Survei.io is easy to use",
      "jumlahPilihan": 2,
      "direction": "Horizontal",
      "arrayPilihan": ["Agree", "Disagree"],
    },
    {
      "judulPolling": "How satisfied are you with Survei.io?",
      "jumlahPilihan": 3,
      "direction": "Vertical",
      "arrayPilihan": ["Satisfied", "Normal", "Disatisfied"],
    },
  ];

  // SELECTED VALUES
  Map<int, String> selectedValues = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.secondaryColor,
            )),
        toolbarHeight: 70.0,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: PaddingHorizontal.px2,
                child: LabelInput(
                    labelText: 'Polling',
                    labelStyle: TextStyles.h2ExtraBold(
                        color: AppColors.secondaryColor)),
              ),
            ),
            Container(
              height: 10,
              color: Colors.white,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color:
                                AppColors.secondaryLightColor.withOpacity(0.2),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: TabBar(
                        unselectedLabelColor:
                            AppColors.secondaryLightColor.withOpacity(0.5),
                        labelColor: AppColors.primaryColor,
                        indicatorColor: AppColors.primaryColor,
                        indicator: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.primaryColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        tabs: [
                          Tab(
                            child: Text(
                              'Polling Baru',
                              style: TextStyles.medium(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Selesai',
                              style: TextStyles.medium(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        onTap: (index) {
                          _handleTabChange(index);
                        },
                        unselectedLabelStyle: TextStyle(
                          color: AppColors.secondaryLightColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          PollingBaru(), // Widget for the Event page
                          PollingSelesai(), // Widget for the Project page
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget PollingBaru() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: listPolling.length,
        itemBuilder: (context, index) {
          // Declaration Polling variabel
          final polling = listPolling[index];

          // Declaration Selected Values
          var selectedIndexValues = selectedValues[index] ?? '';

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(width: 0.5, color: AppColors.secondaryLightColor),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(polling["judulPolling"],
                      style: TextStyles.h3(color: AppColors.secondaryColor)),
                ),
                const SizedBox(height: 10),
                if (polling["direction"] == "Horizontal")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // for (String pilihan in polling["arrayPilihan"])
                      for (int i = 0; i < polling["arrayPilihan"].length; i++)
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: GestureDetector(
                            onTap: () {
                              print(polling["arrayPilihan"][i]);
                              setState(() {
                                selectedValues[index] =
                                    polling["arrayPilihan"][i];
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: selectedIndexValues ==
                                            polling["arrayPilihan"][i]
                                        ? AppColors.primaryColor
                                        : AppColors.infoColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                  color: selectedIndexValues ==
                                          polling["arrayPilihan"][i]
                                      ? AppColors.primaryColor
                                      : Colors.transparent,
                                ),
                                child: SelectOptionContainer(
                                  isActive: selectedIndexValues ==
                                          polling["arrayPilihan"][i]
                                      ? true
                                      : false,
                                  pilihan: polling["arrayPilihan"][i],
                                )),
                          ),
                        )),
                    ],
                  ),
                if (polling["direction"] == "Vertical")
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0; i < polling["arrayPilihan"].length; i++)
                        GestureDetector(
                          onTap: () {
                            print(polling["arrayPilihan"][i]);
                            setState(() {
                              selectedValues[index] =
                                  polling["arrayPilihan"][i];
                            });
                          },
                          child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedIndexValues ==
                                          polling["arrayPilihan"][i]
                                      ? AppColors.primaryColor
                                      : AppColors.infoColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                color: selectedIndexValues ==
                                        polling["arrayPilihan"][i]
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              width: double.infinity,
                              child: SelectOptionContainer(
                                  isActive: selectedIndexValues ==
                                          polling["arrayPilihan"][i]
                                      ? true
                                      : false,
                                  pilihan: polling["arrayPilihan"][i])),
                        ),
                    ],
                  ),
                CustomDividers.mediumDivider(),
                const Center(
                  child: Text(
                    'Lihat Hasil',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.infoColor,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationThickness: 1.0,
                        color: AppColors.infoColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
                CustomDividers.verySmallDivider()
              ],
            ),
          );
        },
      ),
    );
  }

  Widget PollingSelesai() {
    return Container(
      padding: const EdgeInsets.all(15),
    );
  }
}

class SelectOptionContainer extends StatelessWidget {
  final String pilihan;
  final bool isActive;

  const SelectOptionContainer({
    Key? key,
    required this.pilihan,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      pilihan,
      textAlign: TextAlign.center,
      style: TextStyles.regular(
          color: isActive ? Colors.white : AppColors.secondaryColor,
          fontWeight: FontWeight.w700),
    );
  }
}
