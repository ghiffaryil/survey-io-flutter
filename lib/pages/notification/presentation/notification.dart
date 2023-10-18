import 'package:flutter/material.dart';

import '../../../common/components/divider.dart';
import '../../../common/components/label.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/imageSize.dart';
import '../../../common/constants/padding.dart';
import '../../../common/constants/styles.dart';
import '../../../common/extension/helper/date_helper.dart';
import '../../../common/components/appbar_plain.dart';
import '../../../common/constants/icons.dart';
import '../models/model_notification.dart';
import '../data/list_notification.dart';
import 'widgets/notification_card.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NotificationPageState();
  }
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel> notifications = ListNotification.getNotification();

  void markNotificationAsRead(int notificationId) {
    setState(() {
      for (var dataNotification in notifications) {
        if (dataNotification.id == notificationId) {
          dataNotification.status = 'read';
        }
      }
    });
  }

  void markNotificationAsClick(int notificationId) {
    setState(() {
      for (var dataNotification in notifications) {
        if (dataNotification.id == notificationId) {
          dataNotification.clicked = true;
        }
      }
    });
  }

  Widget dismissibleNotification(int index) {
    final dataNotification = notifications[index];
    final notificationId = dataNotification.id;

    return Dismissible(
      onDismissed: (DismissDirection direction) {
        setState(() {
          markNotificationAsRead(notificationId);
        });
        notifications.removeAt(index);
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
          markNotificationAsClick(notificationId);
        },
        child: NotificationCard(
          notification: notifications[index],
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
              labelText: 'Notifikasi',
              labelStyle: TextStyles.h2(color: AppColors.secondary),
            ),
          ),
          notifications.isEmpty
              ? Container(
                  padding: CustomPadding.p3,
                  child: Column(
                    children: [
                      Image.asset(
                        IconName.iconEmptyList,
                        width:
                            AppSizeWidth.imageSize(context, AppSizeWidth.large),
                      ),
                      CustomDividers.regularDivider(),
                      Text(
                        'Ups, notifikasi masih kosong! Coba isi survei pertama kamu di menu Survei.',
                        textAlign: TextAlign.center,
                        style:
                            TextStyles.extraLarge(color: AppColors.secondary),
                      )
                    ],
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool isSameDate = true;
                      final String dateString = notifications[index].date;
                      final DateTime date = DateTime.parse(dateString);

                      if (index == 0) {
                      } else {
                        final String prevDateString =
                            notifications[index - 1].date;
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
                          dismissibleNotification(index),
                        ]);
                      } else {
                        return dismissibleNotification(index);
                      }
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
