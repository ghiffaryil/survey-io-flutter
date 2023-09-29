// ignore_for_file: non_constant_identifier_names
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Import Component
import 'package:survey_io/components/input/input_label.dart';
import 'package:survey_io/components/text/text_component.dart';
import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/components/divider/divider_component.dart';

import 'package:survey_io/components/chart/indicator.dart';

class PollingPage extends StatefulWidget {
  const PollingPage({super.key});

  @override
  State<PollingPage> createState() => _PollingPageState();
}

class _PollingPageState extends State<PollingPage> {
  int Page = 1;
  @override
  void initState() => super.initState();

  void _handleTabChange(index) {
    if (index == 0) {
      print('Polling Baru selected');
    } else if (index == 1) {
      print('Polling Selesai selected');
    }
  }

  final List<Map<String, dynamic>> listPollingBaru = [
    {
      "pollingId": "1",
      "judulPolling": "Survei.io is easy to use",
      "jumlahPilihan": 2,
      "direction": "Horizontal",
      "arrayPilihan": ["Agree", "Disagree"],
    },
    {
      "pollingId": "2",
      "judulPolling": "How satisfied are you with Survei.io?",
      "jumlahPilihan": 3,
      "direction": "Vertical",
      "arrayPilihan": ["Satisfied", "Normal", "Disatisfied"],
    },
    {
      "pollingId": "3",
      "judulPolling": "Favorite Color Poll",
      "jumlahPilihan": 4,
      "direction": "Horizontal",
      "arrayPilihan": ["Red", "Blue", "Green", "Yellow"],
    },
    {
      "pollingId": "4",
      "judulPolling": "Coffee vs. Tea",
      "jumlahPilihan": 2,
      "direction": "Vertical",
      "arrayPilihan": ["Coffee", "Tea"],
    },
    {
      "pollingId": "5",
      "judulPolling": "Best Smartphone Brand",
      "jumlahPilihan": 5,
      "direction": "Horizontal",
      "arrayPilihan": ["Apple", "Samsung"],
    },
  ];

  final List<Map<String, dynamic>> listPollingSelesai = [
    {
      "pollingId": "1",
      "judulPolling": "Survei.io is easy to use",
      "jumlahPilihan": 2,
      "direction": "Horizontal",
      "arrayPilihan": ["Agree", "Disagree"],
      "arrayJawaban": "Agree"
    },
    {
      "pollingId": "2",
      "judulPolling": "How satisfied are you with Survei.io?",
      "jumlahPilihan": 3,
      "direction": "Vertical",
      "arrayPilihan": ["Satisfied", "Normal", "Disatisfied"],
      "arrayJawaban": "Satisfied"
    },
    {
      "pollingId": "3",
      "judulPolling": "Apakah Profesi Anda?",
      "jumlahPilihan": 2,
      "direction": "Horizontal",
      "arrayPilihan": ["Pegawai", "Pengusaha"],
      "arrayJawaban": "Pengusaha"
    },
  ];

  final List<Map<String, dynamic>> hasilPolling = [
    {
      "pollingId": "1",
      "judulPolling": "Survei.io is easy to use",
      "arrayPilihan": ["Agree", "Disagree"],
      "voter": "4000",
      "arrayJumlahPemilihPercent": ["80", "20"],
      "arrayJumlahPemilihValue": ["3200", "800"],
      "arrayWarna": ["blue", "red"],
      "mode": "pie",
    },
    {
      "pollingId": "2",
      "judulPolling": "How satisfied are you with Survei.io?",
      "votes": 3234,
      "arrayPilihan": ["Satisfied", "Normal", "Disatisfied"],
      "voter": "2.000",
      "arrayJumlahPemilihPercent": ["35", "15", "50"],
      "arrayJumlahPemilihValue": ["700", "300", "1000"],
      "arrayWarna": ["blue", "green", "red"],
      "mode": "bar",
    },
    {
      "pollingId": "3",
      "judulPolling": "Apakah Profesi Anda?",
      "jumlahPilihan": 2,
      "direction": "Horizontal",
      "arrayPilihan": ["Pegawai", "Pengusaha"],
      "voter": "1.212",
      "arrayJumlahPemilihPercent": ["75", "25"],
      "arrayJumlahPemilihValue": ["812", "400"],
      "arrayWarna": ["blue", "red"],
      "mode": "pie",
    },
  ];

  // Define a mapping of color names to colors
  Map<String, Color> colorMap = {
    "blue": AppColors.infoColor,
    "red": AppColors.primaryColor,
    "yellow": AppColors.warningColor,
    "green": AppColors.successColor,
    // Add more color mappings as needed
  };

  // SELECTED VALUES
  Map<int, String> pollingBaruSelectedValues = {};

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
          var selectedIndexPollingBaru = pollingBaruSelectedValues[index] ?? '';

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
                                pollingBaruSelectedValues[index] =
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
                              pollingBaruSelectedValues[index] =
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
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        final pollingId = dataPollingSelesai["pollingId"];
                        print(pollingId);
                        showPieChartModal(context, pollingId);
                      },
                      child: const Text(
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
                  ),
                  CustomDividers.verySmallDivider()
                ],
              ),
            );
          }),
    );
  }

  // SHOW MODAL
  void showPieChartModal(BuildContext context, String selectedPollingId) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        var selectedPolling = hasilPolling.firstWhere(
          (item) => item["pollingId"] == selectedPollingId,
          // orElse: () => null,
        );

        int touchedIndex = 1;

        // PIE CHART
        List<PieChartSectionData> pieChartData = [];

        // BAR CHART
        List<BarChartGroupData> barChartData = [];

        // Create PieChartSectionData for each option
        for (int i = 0; i < selectedPolling["arrayPilihan"].length; i++) {
          double dataValue =
              double.parse(selectedPolling["arrayJumlahPemilihValue"][i]);
          double percentage =
              double.parse(selectedPolling["arrayJumlahPemilihPercent"][i]);

          // Format the value and percentage as strings
          String formattedValue = dataValue.toStringAsFixed(0);
          String formattedPercentage = percentage.toStringAsFixed(1);
          String title = '$formattedPercentage% \n ($formattedValue)';

          // Use the color mapping to get the corresponding color
          String colorName = selectedPolling["arrayWarna"][i];
          Color sectionColor = colorMap[colorName] ?? Colors.black;

          barChartData.add(
            BarChartGroupData(
              x: i,
              barsSpace: 5,
              groupVertically: true,
              barRods: [
                BarChartRodData(
                  fromY: dataValue,
                  color: sectionColor,
                  width: 30,
                  borderRadius: BorderRadius.circular(0),
                  toY: 0,
                  // borderSide:
                  //     BorderSide(strokeAlign: BorderSide.strokeAlignInside),
                ),
              ],
            ),
          );

          pieChartData.add(
            PieChartSectionData(
              title: title,
              value: dataValue,
              color: sectionColor,
              titleStyle: TextStyles.regular(
                  color: Colors.white, fontWeight: FontWeight.bold),
              radius: MediaQuery.of(context).size.width * 0.3,
            ),
          );
        }

        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: AppColors.indicatorColor, // Indicator color
                  ),
                  height: 5, // Indicator height
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 8, child: Container()),
                      Image.asset(
                        'assets/images/icons/undraw_pie_chart_re_bgs_8_1.png',
                        width: 60,
                      ),
                    ],
                  ),
                  LabelInput(
                      labelText: 'Hasil Polling',
                      labelStyle:
                          TextStyles.h2(color: AppColors.secondaryColor))
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "${selectedPolling["judulPolling"]}",
                textAlign: TextAlign.left,
                style: TextStyles.h4(color: AppColors.secondaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${selectedPolling["voter"]} Votes",
                textAlign: TextAlign.left,
                style: TextStyles.medium(color: AppColors.secondaryColor),
              ),
              CustomDividers.smallDivider(),
              Center(
                child: SizedBox(
                    height: 300,
                    child: selectedPolling["mode"] == "pie"
                        ? PieChart(
                            PieChartData(
                              centerSpaceRadius: 0,
                              sectionsSpace: 7,
                              borderData: FlBorderData(show: true),
                              sections: pieChartData,
                            ),
                          )
                        : BarChart(BarChartData(
                            barGroups: barChartData,
                            groupsSpace: 10,
                            alignment: BarChartAlignment.center,
                            gridData: const FlGridData(show: false),
                            borderData: FlBorderData(
                                border: const Border(
                              bottom: BorderSide(
                                color: AppColors
                                    .secondaryColor, // Specify the border color
                                width: 2.0, // Specify the border width
                              ),
                            )),
                            minY: 0,
                            maxY: 1500,
                            titlesData: FlTitlesData(
                              bottomTitles: const AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  String text = '';
                                  List<String> percentArray = selectedPolling[
                                      "arrayJumlahPemilihPercent"];
                                  switch (value.toInt()) {
                                    case 0:
                                      text = '${percentArray[0]}%';
                                      break;
                                    case 1:
                                      text = '${percentArray[1]}%';
                                      break;
                                    case 2:
                                      text = '${percentArray[2]}%';
                                      break;
                                  }

                                  return Text(text);
                                },
                              )),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            )))),
              ),
              CustomDividers.mediumDivider(),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      selectedPolling["arrayPilihan"].length,
                      (index) {
                        String colorName = selectedPolling["arrayWarna"][index];
                        Color indicatorColor =
                            colorMap[colorName] ?? Colors.black;

                        String indicatorText =
                            selectedPolling["arrayPilihan"][index];

                        return Indicator(
                          color: indicatorColor,
                          text: indicatorText,
                          isSquare: false,
                          size: 14,
                          textColor: touchedIndex == index
                              ? indicatorColor // Use the same color as the indicator when touched
                              : AppColors.secondaryColor,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
