// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:survey_io/common/components/modal_indicator.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';

import '../../../common/components/appbar_plain.dart';

class PollingPage extends StatefulWidget {
  const PollingPage({super.key});

  @override
  State<PollingPage> createState() => _PollingPageState();
}

class _PollingPageState extends State<PollingPage> {
  int Page = 1;
  @override
  void initState() => super.initState();

  final List<Map<String, dynamic>> listPollingNew = [
    {
      "pollingId": "1",
      "pollingTitle": "Survei.io is easy to use",
      "direction": "Horizontal",
      "optionNumber": 2,
      "arrayOption": ["Agree", "Disagree"],
    },
    {
      "pollingId": "2",
      "pollingTitle": "How satisfied are you with Survei.io?",
      "direction": "Vertical",
      "optionNumber": 3,
      "arrayOption": ["Satisfied", "Normal", "Disatisfied"],
    },
    {
      "pollingId": "3",
      "pollingTitle": "Favorite Color Poll",
      "direction": "Horizontal",
      "optionNumber": 4,
      "arrayOption": ["Red", "Blue", "Green", "Yellow"],
    },
    {
      "pollingId": "4",
      "pollingTitle": "Coffee vs. Tea",
      "direction": "Vertical",
      "optionNumber": 2,
      "arrayOption": ["Coffee", "Tea"],
    },
    {
      "pollingId": "5",
      "pollingTitle": "Best Smartphone Brand",
      "direction": "Horizontal",
      "optionNumber": 5,
      "arrayOption": ["Apple", "Samsung"],
    },
  ];

  final List<Map<String, dynamic>> listPollingCompleted = [
    {
      "pollingId": "1",
      "pollingTitle": "Survei.io is easy to use",
      "optionNumber": 2,
      "direction": "Horizontal",
      "arrayOption": ["Agree", "Disagree"],
      "arrayAnswer": "Agree"
    },
    {
      "pollingId": "2",
      "pollingTitle": "How satisfied are you with Survei.io?",
      "optionNumber": 3,
      "direction": "Vertical",
      "arrayOption": ["Satisfied", "Normal", "Disatisfied"],
      "arrayAnswer": "Satisfied"
    },
    {
      "pollingId": "3",
      "pollingTitle": "Apakah Profesi Anda?",
      "optionNumber": 2,
      "direction": "Horizontal",
      "arrayOption": ["Pegawai", "Pengusaha"],
      "arrayAnswer": "Pengusaha"
    },
  ];

  final List<Map<String, dynamic>> hasilPolling = [
    {
      "pollingId": "1",
      "pollingTitle": "Survei.io is easy to use",
      "arrayOption": ["Agree", "Disagree"],
      "voter": "4000",
      "arrayVotersPercent": ["80", "20"],
      "arrayVoterCount": ["3200", "800"],
      "arrayPollingColor": ["blue", "red"],
      "mode": "pie",
    },
    {
      "pollingId": "2",
      "pollingTitle": "How satisfied are you with Survei.io?",
      "votes": 3234,
      "arrayOption": ["Satisfied", "Normal", "Disatisfied"],
      "voter": "2.000",
      "arrayVotersPercent": ["35", "15", "50"],
      "arrayVoterCount": ["700", "300", "1000"],
      "arrayPollingColor": ["blue", "green", "red"],
      "mode": "bar",
    },
    {
      "pollingId": "3",
      "pollingTitle": "Apakah Profesi Anda?",
      "optionNumber": 2,
      "direction": "Horizontal",
      "arrayOption": ["Pegawai", "Pengusaha"],
      "voter": "1.212",
      "arrayVotersPercent": ["75", "25"],
      "arrayVoterCount": ["812", "400"],
      "arrayPollingColor": ["blue", "red"],
      "mode": "pie",
    },
  ];

  // Define a mapping of color names to colors
  Map<String, Color> colorMap = {
    "blue": AppColors.info,
    "red": AppColors.primary,
    "yellow": AppColors.warning,
    "green": AppColors.success,
    // Add more color mappings as needed
  };

  // SELECTED VALUES
  Map<int, String> pollingBaruSelectedValues = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: PlainAppBar(
        height: 70.0,
        leadingIcon: Icons.arrow_back_ios,
        iconSize: 35.0,
        textColor: AppColors.secondary,
        onPressed: () {
          Navigator.pop(context);
        },
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
                      TextStyles.h2ExtraBold(color: AppColors.secondary)),
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
                    unselectedLabelColor: AppColors.light.withOpacity(0.5),
                    labelColor: AppColors.primary,
                    indicator: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.primary,
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
        itemCount: listPollingNew.length,
        itemBuilder: (context, index) {
          // Declaration Polling variabel
          final dataPollingBaru = listPollingNew[index];

          // Declaration SelectselectedIndexPollingBarued Values
          var selectedIndexPollingBaru = pollingBaruSelectedValues[index] ?? '';

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 0.5, color: AppColors.light),
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
                  child: Text(dataPollingBaru["pollingTitle"],
                      style: TextStyles.h3(color: AppColors.secondary)),
                ),
                const SizedBox(height: 10),
                if (dataPollingBaru["direction"] == "Horizontal")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // for (String pilihan in dataPollingBaru["arrayOption"])
                      for (int i = 0;
                          i < dataPollingBaru["arrayOption"].length;
                          i++)
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: GestureDetector(
                            onTap: () {
                              // print(dataPollingBaru["arrayOption"][i]);
                              setState(() {
                                pollingBaruSelectedValues[index] =
                                    dataPollingBaru["arrayOption"][i];
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: selectedIndexPollingBaru ==
                                            dataPollingBaru["arrayOption"][i]
                                        ? AppColors.primary
                                        : AppColors.info,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                  color: selectedIndexPollingBaru ==
                                          dataPollingBaru["arrayOption"][i]
                                      ? AppColors.primary
                                      : Colors.transparent,
                                ),
                                child: SelectOptionContainer(
                                  isActive: selectedIndexPollingBaru ==
                                          dataPollingBaru["arrayOption"][i]
                                      ? true
                                      : false,
                                  pilihan: dataPollingBaru["arrayOption"][i],
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
                          i < dataPollingBaru["arrayOption"].length;
                          i++)
                        GestureDetector(
                          onTap: () {
                            // print(dataPollingBaru["arrayOption"][i]);
                            setState(() {
                              pollingBaruSelectedValues[index] =
                                  dataPollingBaru["arrayOption"][i];
                            });
                          },
                          child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedIndexPollingBaru ==
                                          dataPollingBaru["arrayOption"][i]
                                      ? AppColors.primary
                                      : AppColors.info,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                color: selectedIndexPollingBaru ==
                                        dataPollingBaru["arrayOption"][i]
                                    ? AppColors.primary
                                    : Colors.transparent,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              width: double.infinity,
                              child: SelectOptionContainer(
                                  isActive: selectedIndexPollingBaru ==
                                          dataPollingBaru["arrayOption"][i]
                                      ? true
                                      : false,
                                  pilihan: dataPollingBaru["arrayOption"][i])),
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
          itemCount: listPollingCompleted.length,
          itemBuilder: (context, index) {
            final dataPollingSelesai = listPollingCompleted[index];

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.5, color: AppColors.light),
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
                    child: Text(dataPollingSelesai["pollingTitle"],
                        style: TextStyles.h3(color: AppColors.secondary)),
                  ),
                  const SizedBox(height: 10),
                  if (dataPollingSelesai["direction"] == "Horizontal")
                    Row(
                      children: [
                        for (int i = 0;
                            i < dataPollingSelesai["arrayOption"].length;
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
                                    color: dataPollingSelesai["arrayAnswer"] ==
                                            dataPollingSelesai["arrayOption"][i]
                                        ? AppColors.primary
                                        : AppColors.info,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                  color: dataPollingSelesai["arrayAnswer"] ==
                                          dataPollingSelesai["arrayOption"][i]
                                      ? AppColors.primary
                                      : Colors.transparent,
                                ),
                                child: SelectOptionContainer(
                                  isActive: dataPollingSelesai["arrayAnswer"] ==
                                          dataPollingSelesai["arrayOption"][i]
                                      ? true
                                      : false,
                                  pilihan: dataPollingSelesai["arrayOption"][i],
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
                            i < dataPollingSelesai["arrayOption"].length;
                            i++)
                          Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: dataPollingSelesai["arrayAnswer"] ==
                                          dataPollingSelesai["arrayOption"][i]
                                      ? AppColors.primary
                                      : AppColors.info,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                color: dataPollingSelesai["arrayAnswer"] ==
                                        dataPollingSelesai["arrayOption"][i]
                                    ? AppColors.primary
                                    : Colors.transparent,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              width: double.infinity,
                              child: SelectOptionContainer(
                                  isActive: dataPollingSelesai["arrayAnswer"] ==
                                          dataPollingSelesai["arrayOption"][i]
                                      ? true
                                      : false,
                                  pilihan: dataPollingSelesai["arrayOption"]
                                      [i])),
                      ],
                    ),
                  CustomDividers.mediumDivider(),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        final pollingId = dataPollingSelesai["pollingId"];
                        // print(pollingId);
                        showPieChartModal(context, pollingId);
                      },
                      child: const Text(
                        'Lihat Hasil',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.info,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationThickness: 1.0,
                            color: AppColors.info,
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
        for (int i = 0; i < selectedPolling["arrayOption"].length; i++) {
          double dataValue =
              double.parse(selectedPolling["arrayVoterCount"][i]);
          double percentage =
              double.parse(selectedPolling["arrayVotersPercent"][i]);

          // Format the value and percentage as strings
          String formattedValue = dataValue.toStringAsFixed(0);
          String formattedPercentage = percentage.toStringAsFixed(1);
          String title = '$formattedPercentage% \n ($formattedValue)';

          // Use the color mapping to get the corresponding color
          String colorName = selectedPolling["arrayPollingColor"][i];
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
                  width: MediaQuery.of(context).size.width * 0.1,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: AppColors.indicator, // Indicator color
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
                        'assets/icons/icon_pie_chart',
                        width: 60,
                      ),
                    ],
                  ),
                  LabelInput(
                      labelText: 'Hasil Polling',
                      labelStyle: TextStyles.h2(color: AppColors.secondary))
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "${selectedPolling["pollingTitle"]}",
                textAlign: TextAlign.left,
                style: TextStyles.h4(color: AppColors.secondary),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${selectedPolling["voter"]} Votes",
                textAlign: TextAlign.left,
                style: TextStyles.medium(color: AppColors.secondary),
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
                                    .secondary, // Specify the border color
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
                                  List<String> percentArray =
                                      selectedPolling["arrayVotersPercent"];
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
                      selectedPolling["arrayOption"].length,
                      (index) {
                        String colorName =
                            selectedPolling["arrayPollingColor"][index];
                        Color indicator = colorMap[colorName] ?? Colors.black;

                        String indicatorText =
                            selectedPolling["arrayOption"][index];

                        return Indicator(
                          color: indicator,
                          text: indicatorText,
                          isSquare: false,
                          size: 14,
                          textColor: touchedIndex == index
                              ? indicator // Use the same color as the indicator when touched
                              : AppColors.secondary,
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
          color: isActive ? Colors.white : AppColors.secondary,
          fontWeight: FontWeight.w700),
    );
  }
}
