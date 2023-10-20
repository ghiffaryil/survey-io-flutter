import 'package:flutter/material.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/pages/reedem/models/reedem_history_mdel.dart';
import '../../../common/components/label.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/imageSize.dart';
import '../../../common/constants/images.dart';
import '../../../common/constants/padding.dart';
import '../../../common/constants/styles.dart';
import '../../../common/extension/helper/date_helper.dart';
import '../../../common/components/appbar_plain.dart';
import '../../../common/constants/icons.dart';
import '../data/list_reedem_history.dart';
import 'widgets/item_reedem_history_card.dart';

class ReedemHistoryPage extends StatefulWidget {
  const ReedemHistoryPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ReedemHistoryPageState();
  }
}

class _ReedemHistoryPageState extends State<ReedemHistoryPage> {
  List<ReedemHistoryModel> reedemHistoryData =
      ListReedemHistory.getReedemHistory();

  void markNotificationAsRead(int reedemHistoryId) {
    setState(() {
      for (var data in reedemHistoryData) {
        if (data.id == reedemHistoryId) {
          data.status = 'read';
        }
      }
    });
  }

  void markNotificationAsClick(int reedemHistoryId) {
    setState(() {
      for (var data in reedemHistoryData) {
        if (data.id == reedemHistoryId) {
          data.clicked = true;
        }
      }
    });
  }

  Widget buildDismissibleNotification(int index) {
    final data = reedemHistoryData[index];
    final reedemHistoryId = data.id;

    return Dismissible(
      onDismissed: (DismissDirection direction) {
        setState(() {
          markNotificationAsRead(reedemHistoryId);
        });
        reedemHistoryData.removeAt(index);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        color: AppColors.info,
        child: Image.asset(
          IconName.trash,
          width: 25,
        ),
      ),
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      child: InkWell(
        onTap: () {
          markNotificationAsClick(reedemHistoryId);
        },
        child: ReedemHistoryCard(
          data: reedemHistoryData[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: PlainAppBar(
        leadingIcon: Icons.arrow_back_ios,
        iconSize: 35.0,
        iconColor: AppColors.secondary,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: CustomPadding.p2,
            child: LabelInput(
              labelText: 'Riwayat',
              labelStyle: TextStyles.h2(color: AppColors.secondary),
            ),
          ),
          reedemHistoryData.isEmpty
              ? Container(
                  padding: CustomPadding.p3,
                  child: Column(
                    children: [
                      Image.asset(
                        Images.emptyList,
                        width:
                            AppSizeWidth.imageSize(context, AppSizeWidth.large),
                      ),
                      CustomDividers.regularDivider(),
                      Text(
                        'Ups, riwayat hadiah masih kosong! Coba tukar koin kamu dengan Hadiah.',
                        textAlign: TextAlign.center,
                        style:
                            TextStyles.extraLarge(color: AppColors.secondary),
                      )
                    ],
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: reedemHistoryData.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool isSameDate = true;
                      final String dateString =
                          reedemHistoryData[index].datetime_created;
                      final DateTime date = DateTime.parse(dateString);

                      if (index == 0) {
                      } else {
                        final String prevDateString =
                            reedemHistoryData[index - 1].datetime_created;
                        final DateTime prevDate =
                            DateTime.parse(prevDateString);
                        isSameDate = date.isSameDate(prevDate);
                      }

                      if (index == 0 || !(isSameDate)) {
                        return Column(children: [
                          Container(
                              padding: const EdgeInsets.all(20.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                date.formatDate(),
                                style: TextStyles.h6ExtraBold(),
                              )),
                          buildDismissibleNotification(index),
                        ]);
                      } else {
                        return buildDismissibleNotification(index);
                      }
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
