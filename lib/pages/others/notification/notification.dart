import 'package:survey_io/utils/color/color_component.dart';
import 'package:survey_io/utils/header/leading.dart';
import 'package:survey_io/utils/input/input_label.dart';
import 'package:survey_io/utils/padding/padding.dart';
import 'package:survey_io/utils/text/text_component.dart';
import 'package:survey_io/services/models/notification/model_notification.dart';
import 'package:survey_io/services/data/notification/list_notification.dart';
import 'package:survey_io/widgets/features/notification/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  Widget _buildDismissibleNotification(int index) {
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
                              _buildDismissibleNotification(index),
                            ]);
                          } else {
                            return _buildDismissibleNotification(index);
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

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat('d MMM y', 'en_US');
    return formatter.format(this).toUpperCase();
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
