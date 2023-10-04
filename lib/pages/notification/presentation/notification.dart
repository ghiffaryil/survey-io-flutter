import 'package:flutter/material.dart';
import 'package:survey_io/common/components/appbar_leading.dart';
import 'package:survey_io/common/components/label_input.dart';

import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/extension/helper/date_helper.dart';
import 'package:survey_io/pages/notification/models/model_notification.dart';
import 'package:survey_io/pages/notification/data/list_notification.dart';
import 'package:survey_io/pages/notification/presentation/widgets/notification_card.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NotificationPageState();
  }
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel> notifications = NotificationList.getNotification();

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

  Widget buildDismissibleNotification(int index) {
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
        color: AppColors.infoColor,
        child:
            Image.asset('assets/images/icons/not_delete_icon.png', width: 25),
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
        backgroundColor: AppColors.bgDefault,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: LeadingHeader(
              iconSize: 30,
              onPressed: () {
                Navigator.pop(context);
              },
              textColor: AppColors.secondaryColor,
              leadingIcon: Icons.arrow_back_ios),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: notifications.isNotEmpty
                ? Column(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: PaddingAll.p2,
                        child: LabelInput(
                          labelText: 'Notifikasi',
                          labelStyle:
                              TextStyles.h2(color: AppColors.secondaryColor),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                              buildDismissibleNotification(index),
                            ]);
                          } else {
                            return buildDismissibleNotification(index);
                          }
                        },
                      ),
                    ],
                  )
                : const Center(child: Text('No Items')),
          ),
        ));
  }
}
