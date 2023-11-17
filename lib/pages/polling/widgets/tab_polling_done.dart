import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/components/chart_indicator.dart';
import '../../../common/constants/widgets/indicator.dart';
import '../../../bloc/polling/polling_done/polling_done_bloc.dart';
import '../../../bloc/polling/polling_result/polling_result_bloc.dart';
import '../../../common/constants/icons.dart';
import '../../../common/constants/styles.dart';
import '../../../common/constants/colors.dart';
import '../../../common/components/divider.dart';
import '../../../common/components/label.dart';

import '../../../datasources/polling/list_polling_completed.dart';

import '../../../models/polling/polling_completed.dart';

import 'container_select_option.dart';

class TabPollingDone extends StatefulWidget {
  const TabPollingDone({super.key});

  @override
  State<TabPollingDone> createState() => _TabPollingDoneState();
}

class _TabPollingDoneState extends State<TabPollingDone> {
  List<PollingCompletedModel> listPollingCompleted =
      ListPollingCompleted.getCompletedPolling();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocBuilder<PollingDoneBloc, PollingDoneState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return Container();
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (message) {
              return Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: Text(
                    'You haven\'t voted on the poll yet',
                    textAlign: TextAlign.center,
                    style: TextStyles.large(),
                  ));
            },
            loaded: (data) {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final pollingData = data[index];
                    final pollingDoneData = pollingData.polling;

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
                            child: Text(pollingDoneData.title,
                                style:
                                    TextStyles.h3(color: AppColors.secondary)),
                          ),
                          const SizedBox(height: 10),
                          if (pollingData.placement == "horizontal")
                            Row(
                              children: [
                                for (int i = 0;
                                    i < pollingData.pollingList.length;
                                    i++)
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: pollingData.answer ==
                                                    pollingData
                                                        .pollingList[i].id
                                                ? AppColors.primary
                                                : AppColors.info,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: pollingData.answer ==
                                                  pollingData.pollingList[i].id
                                              ? AppColors.primary
                                              : Colors.transparent,
                                        ),
                                        child: SelectOptionContainer(
                                          isActive: pollingData.answer ==
                                                  pollingData.pollingList[i].id
                                              ? true
                                              : false,
                                          pilihan:
                                              pollingData.pollingList[i].label,
                                        )),
                                  )),
                              ],
                            ),
                          if (pollingData.placement == "vertical")
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (int i = 0;
                                    i < pollingData.pollingList.length;
                                    i++)
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: pollingData.answer ==
                                                  pollingData.pollingList[i].id
                                              ? AppColors.primary
                                              : AppColors.info,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                        color: pollingData.answer ==
                                                pollingData.pollingList[i].id
                                            ? AppColors.primary
                                            : Colors.transparent,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      width: double.infinity,
                                      child: SelectOptionContainer(
                                          isActive: pollingData.answer ==
                                                  pollingData.pollingList[i].id
                                              ? true
                                              : false,
                                          pilihan: data[index]
                                              .pollingList[i]
                                              .label)),
                              ],
                            ),
                          CustomDividers.smallDivider(),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                final pollingTitle = pollingDoneData.title;
                                final pollingId = pollingData.polling.id;
                                showPieChartModal(
                                    context, pollingId, pollingTitle);
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
                  });
            },
          );
        },
      ),
    );
  }

  // SHOW MODAL
  void showPieChartModal(
      BuildContext context, int selectedPollingId, String pollingTitle) {
    context
        .read<PollingResultBloc>()
        .add(PollingResultEvent.getListPollingResult(selectedPollingId));

    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.white),
          child: Column(
            children: [
              const IndicatorModal(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 8, child: Container()),
                      Image.asset(
                        IconName.pieChart,
                        width: 60,
                      ),
                    ],
                  ),
                  LabelInput(
                      labelText: 'Hasil Polling',
                      labelStyle: TextStyles.h2(color: AppColors.secondary))
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<PollingResultBloc, PollingResultState>(
                  builder: (context, state) {
                    int totalVotes = 0;
                    int sumVotes = 0;
                    double percentVotes = 0.0;

                    return state.maybeWhen(
                      orElse: () {
                        return Container();
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      error: (message) {
                        return Text(message);
                      },
                      loaded: (data) {
                        List<PieChartSectionData> pieChartData = [];
                        List<Color> sectionColors = [
                          AppColors.info,
                          AppColors.primary,
                          AppColors.warning,
                          AppColors.success,
                          AppColors.secondary,
                          AppColors.black,
                          AppColors.light,
                          AppColors.bg,
                        ];

                        for (int index = 0; index < data.length; index++) {
                          sumVotes = sumVotes + data[index].count;
                        }

                        for (int i = 0; i < data.length; i++) {
                          totalVotes = totalVotes + data[i].count;
                          percentVotes = (data[i].count / sumVotes) * 100;

                          pieChartData.add(
                            PieChartSectionData(
                              value: data[i].count.toDouble(),
                              color: sectionColors[i % sectionColors.length],
                              radius: MediaQuery.of(context).size.width * 0.3,
                              title:
                                  "${percentVotes.toStringAsFixed(1)}% \n (${data[i].count})",
                              titleStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pollingTitle,
                              textAlign: TextAlign.left,
                              style: TextStyles.h4(color: AppColors.secondary),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${totalVotes.toString()} Votes',
                              textAlign: TextAlign.left,
                              style:
                                  TextStyles.medium(color: AppColors.secondary),
                            ),
                            CustomDividers.verySmallDivider(),
                            Expanded(
                              child: PieChart(
                                PieChartData(
                                  centerSpaceRadius: 0,
                                  sectionsSpace: 7,
                                  borderData: FlBorderData(show: false),
                                  sections: pieChartData,
                                ),
                              ),
                            ),
                            CustomDividers.verySmallDivider(),
                            Container(
                              alignment: Alignment.center,
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5.0,
                                    crossAxisSpacing: 5.0,
                                    mainAxisExtent: 30,
                                  ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    final label = data[index].label;
                                    return Indicator(
                                      text: label,
                                      color: sectionColors[
                                          index % sectionColors.length],
                                      isSquare: false,
                                    );
                                  }),
                            ),
                            CustomDividers.verySmallDivider(),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
