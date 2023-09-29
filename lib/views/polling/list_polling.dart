// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

// Import Component
import 'package:survey_io/components/input/input_label.dart';
import 'package:survey_io/components/text/text_component.dart';
import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/components/divider/divider_component.dart';

class PollingPage extends StatefulWidget {
  const PollingPage({super.key});

  @override
  State<PollingPage> createState() => _PollingPageState();
}

class _PollingPageState extends State<PollingPage> {
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

  final List<Map<String, dynamic>> listPollingBaru = [
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
    {
      "judulPolling": "Favorite Color Poll",
      "jumlahPilihan": 4,
      "direction": "Horizontal",
      "arrayPilihan": ["Red", "Blue", "Green", "Yellow"],
    },
    {
      "judulPolling": "Coffee vs. Tea",
      "jumlahPilihan": 2,
      "direction": "Vertical",
      "arrayPilihan": ["Coffee", "Tea"],
    },
    {
      "judulPolling": "Best Smartphone Brand",
      "jumlahPilihan": 5,
      "direction": "Horizontal",
      "arrayPilihan": ["Apple", "Samsung"],
    },
  ];

  final List<Map<String, dynamic>> listPollingSelesai = [
    {
      "judulPolling": "Survei.io is easy to use",
      "jumlahPilihan": 2,
      "direction": "Horizontal",
      "arrayPilihan": ["Agree", "Disagree"],
      "arrayJawaban": "Agree"
    },
    {
      "judulPolling": "How satisfied are you with Survei.io?",
      "jumlahPilihan": 3,
      "direction": "Vertical",
      "arrayPilihan": ["Satisfied", "Normal", "Disatisfied"],
      "arrayJawaban": "Satisfied"
    },
    {
      "judulPolling": "Apakah Profesi Anda?",
      "jumlahPilihan": 2,
      "direction": "Horizontal",
      "arrayPilihan": ["Pegawai", "Pengusaha"],
      "arrayJawaban": "Pengusaha"
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
        // toolbarHeight: 70.0,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: LabelInput(
                  labelText: 'Polling',
                  labelStyle:
                      TextStyles.h2ExtraBold(color: AppColors.secondaryColor)),
            ),
          ),
          Container(
            height: 10,
            color: Colors.white,
          ),
          Expanded(
              // height: MediaQuery.of(context).size.height,
              child: DefaultTabController(
            length: 2, // Number of tabs
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
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
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Content for Tab 1
                      PollingBaru(),
                      // Content for Tab 2
                      PollingSelesai()
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget PollingBaru() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: listPollingBaru.length,
        itemBuilder: (context, index) {
          // Declaration Polling variabel
          final dataPollingBaru = listPollingBaru[index];

          // Declaration SelectselectedIndexPollingBarued Values
          var selectedIndexPollingBaru = selectedValues[index] ?? '';

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
                  child: Text(dataPollingBaru["judulPolling"],
                      style: TextStyles.h3(color: AppColors.secondaryColor)),
                ),
                const SizedBox(height: 10),
                if (dataPollingBaru["direction"] == "Horizontal")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // for (String pilihan in dataPollingBaru["arrayPilihan"])
                      for (int i = 0;
                          i < dataPollingBaru["arrayPilihan"].length;
                          i++)
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: GestureDetector(
                            onTap: () {
                              print(dataPollingBaru["arrayPilihan"][i]);
                              setState(() {
                                selectedValues[index] =
                                    dataPollingBaru["arrayPilihan"][i];
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: selectedIndexPollingBaru ==
                                            dataPollingBaru["arrayPilihan"][i]
                                        ? AppColors.primaryColor
                                        : AppColors.infoColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                  color: selectedIndexPollingBaru ==
                                          dataPollingBaru["arrayPilihan"][i]
                                      ? AppColors.primaryColor
                                      : Colors.transparent,
                                ),
                                child: SelectOptionContainer(
                                  isActive: selectedIndexPollingBaru ==
                                          dataPollingBaru["arrayPilihan"][i]
                                      ? true
                                      : false,
                                  pilihan: dataPollingBaru["arrayPilihan"][i],
                                )),
                          ),
                        )),
                    ],
                  ),
                if (dataPollingBaru["direction"] == "Vertical")
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0;
                          i < dataPollingBaru["arrayPilihan"].length;
                          i++)
                        GestureDetector(
                          onTap: () {
                            print(dataPollingBaru["arrayPilihan"][i]);
                            setState(() {
                              selectedValues[index] =
                                  dataPollingBaru["arrayPilihan"][i];
                            });
                          },
                          child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedIndexPollingBaru ==
                                          dataPollingBaru["arrayPilihan"][i]
                                      ? AppColors.primaryColor
                                      : AppColors.infoColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                color: selectedIndexPollingBaru ==
                                        dataPollingBaru["arrayPilihan"][i]
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              width: double.infinity,
                              child: SelectOptionContainer(
                                  isActive: selectedIndexPollingBaru ==
                                          dataPollingBaru["arrayPilihan"][i]
                                      ? true
                                      : false,
                                  pilihan: dataPollingBaru["arrayPilihan"][i])),
                        ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget PollingSelesai() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
          itemCount: listPollingSelesai.length,
          itemBuilder: (context, index) {
            // Declaration Polling variabel
            final dataPollingSelesai = listPollingSelesai[index];

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: 0.5, color: AppColors.secondaryLightColor),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(dataPollingSelesai["judulPolling"],
                        style: TextStyles.h3(color: AppColors.secondaryColor)),
                  ),
                  const SizedBox(height: 10),
                  if (dataPollingSelesai["direction"] == "Horizontal")
                    Row(
                      children: [
                        for (int i = 0;
                            i < dataPollingSelesai["arrayPilihan"].length;
                            i++)
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: dataPollingSelesai["arrayJawaban"] ==
                                            dataPollingSelesai["arrayPilihan"]
                                                [i]
                                        ? AppColors.primaryColor
                                        : AppColors.infoColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                  color: dataPollingSelesai["arrayJawaban"] ==
                                          dataPollingSelesai["arrayPilihan"][i]
                                      ? AppColors.primaryColor
                                      : Colors.transparent,
                                ),
                                child: SelectOptionContainer(
                                  isActive:
                                      dataPollingSelesai["arrayJawaban"] ==
                                              dataPollingSelesai["arrayPilihan"]
                                                  [i]
                                          ? true
                                          : false,
                                  pilihan: dataPollingSelesai["arrayPilihan"]
                                      [i],
                                )),
                          )),
                      ],
                    ),
                  if (dataPollingSelesai["direction"] == "Vertical")
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int i = 0;
                            i < dataPollingSelesai["arrayPilihan"].length;
                            i++)
                          Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: dataPollingSelesai["arrayJawaban"] ==
                                          dataPollingSelesai["arrayPilihan"][i]
                                      ? AppColors.primaryColor
                                      : AppColors.infoColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                color: dataPollingSelesai["arrayJawaban"] ==
                                        dataPollingSelesai["arrayPilihan"][i]
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              width: double.infinity,
                              child: SelectOptionContainer(
                                  isActive:
                                      dataPollingSelesai["arrayJawaban"] ==
                                              dataPollingSelesai["arrayPilihan"]
                                                  [i]
                                          ? true
                                          : false,
                                  pilihan: dataPollingSelesai["arrayPilihan"]
                                      [i])),
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
          }),
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
