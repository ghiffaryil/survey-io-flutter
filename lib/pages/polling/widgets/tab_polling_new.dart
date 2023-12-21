// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/common/components/shimmer_card.dart';
import '../../reedem/reedem_gift_card.dart';
import '../../../bloc/polling/polling_participate/polling_participate_bloc.dart';
import '../../../common/constants/icons.dart';
import '../../../bloc/polling/polling/polling_bloc.dart';
import '../../../common/components/elevated_button.dart';
import '../../../common/constants/padding.dart';
import '../../../common/constants/styles.dart';
import '../../../common/constants/colors.dart';
import 'container_select_option.dart';

class TabNewPolling extends StatefulWidget {
  const TabNewPolling({super.key});

  @override
  State<TabNewPolling> createState() => _TabNewPollingState();
}

class _TabNewPollingState extends State<TabNewPolling> {
  // SELECTED VALUES
  Map<int, String> newPollingSelectedValues = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocBuilder<PollingBloc, PollingState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return Container();
          }, loading: () {
            return ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const ShimmerPolling(
                    tab: 'New',
                  );
                });
          }, error: (message) {
            return Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Text(
                  'Tidak ada Polling tersedia',
                  textAlign: TextAlign.center,
                  style: TextStyles.large(),
                ));
          }, loaded: (data) {
            bool allPollingVoted =
                data.every((pollingData) => pollingData.allowed == false);

            if (allPollingVoted) {
              return Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: Text(
                    'Kamu telah menyelesaikan semua Polling',
                    textAlign: TextAlign.center,
                    style: TextStyles.large(),
                  ));
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final pollingData = data[index];
                  var selectedIndexNewPolling =
                      newPollingSelectedValues[index] ?? '';
                  if (pollingData.allowed == false) {
                    return Container();
                  } else {
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
                            child: Text(pollingData.polling.title,
                                style:
                                    TextStyles.h3(color: AppColors.secondary)),
                          ),
                          const SizedBox(height: 10),
                          if (pollingData.placement == 'horizontal')
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0;
                                      i < pollingData.pollingList.length;
                                      i++)
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              newPollingSelectedValues[index] =
                                                  pollingData
                                                      .pollingList[i].label;
                                            });
                                            print(newPollingSelectedValues);
                                            _showPollingParticipateModal(
                                              context,
                                              pollingData.pollingList[i].id,
                                              pollingData.polling.point,
                                              pollingData.pollingList[i].label,
                                              (value) {
                                                newPollingSelectedValues[
                                                    index] = value;
                                              },
                                            );
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.all(10),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      selectedIndexNewPolling ==
                                                              pollingData
                                                                  .pollingList[
                                                                      i]
                                                                  .label
                                                          ? AppColors.primary
                                                          : AppColors.info,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color:
                                                    selectedIndexNewPolling ==
                                                            pollingData
                                                                .pollingList[i]
                                                                .label
                                                        ? AppColors.primary
                                                        : Colors.transparent,
                                              ),
                                              child: SelectOptionContainer(
                                                isActive:
                                                    selectedIndexNewPolling ==
                                                            pollingData
                                                                .pollingList[i]
                                                                .label
                                                        ? true
                                                        : false,
                                                pilihan: pollingData
                                                    .pollingList[i].label,
                                              )),
                                        ),
                                      ),
                                    )
                                ])
                          else
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (int i = 0;
                                    i < pollingData.pollingList.length;
                                    i++)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        newPollingSelectedValues[index] =
                                            pollingData.pollingList[i].label;
                                      });
                                      print(newPollingSelectedValues);
                                      _showPollingParticipateModal(
                                        context,
                                        pollingData.pollingList[i].id,
                                        pollingData.polling.point,
                                        pollingData.pollingList[i].label,
                                        (value) {
                                          // Update the selected value in the list.
                                          newPollingSelectedValues[index] =
                                              value;
                                        },
                                      );
                                    },
                                    child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: selectedIndexNewPolling ==
                                                    pollingData
                                                        .pollingList[i].label
                                                ? AppColors.primary
                                                : AppColors.info,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: selectedIndexNewPolling ==
                                                  pollingData
                                                      .pollingList[i].label
                                              ? AppColors.primary
                                              : Colors.transparent,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 15),
                                        width: double.infinity,
                                        child: SelectOptionContainer(
                                            isActive: selectedIndexNewPolling ==
                                                    pollingData
                                                        .pollingList[i].label
                                                ? true
                                                : false,
                                            pilihan: pollingData
                                                .pollingList[i].label)),
                                  ),
                              ],
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        IconName.point,
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        pollingData.polling.point.toString(),
                                        style: TextStyles.regular(),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        IconName.account,
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        pollingData.totalVote.toString(),
                                        style: TextStyles.regular(),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              );
            }
          });
        },
      ),
    );
  }

  void _showPollingParticipateModal(
      BuildContext context,
      int selectedPollingListId,
      int point,
      String selectedItemLabel,
      Function(String) onSelectedValueChange) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  onSelectedValueChange('');
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  size: 30,
                  color: AppColors.secondary,
                )),
          ),
          content: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text:
                        'Pilihan tidak dapat diubah ketika anda menekan tombol',
                    style: TextStyles.extraLarge(color: AppColors.secondary)),
                TextSpan(
                  text: ' Submit ',
                  style: TextStyles.extraLarge(color: AppColors.primary),
                ),
                TextSpan(
                    text: ', anda yakin tetap ingin memilih',
                    style: TextStyles.extraLarge(color: AppColors.secondary)),
                TextSpan(
                  text: ' "$selectedItemLabel"',
                  style: TextStyles.extraLarge(color: AppColors.primary),
                ),
                TextSpan(
                    text: '?',
                    style: TextStyles.extraLarge(color: AppColors.secondary)),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: CustomPadding.p1,
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: ButtonOutlined.secondary(
                      text: 'Batal',
                      height: 40,
                      onPressed: () {
                        setState(() {
                          onSelectedValueChange('');
                          newPollingSelectedValues = {};
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 5,
                    child: ButtonFilled.primary(
                      text: 'Submit',
                      height: 40,
                      onPressed: () async {
                        context.read<PollingParticipateBloc>().add(
                            PollingParticipateEvent.setPollingParticipate(
                                selectedPollingListId));
                        onSelectedValueChange(selectedItemLabel);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ReedemGiftCard(point: point)));
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
