import 'package:flutter/material.dart';
import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/components/header/leading.dart';
import 'package:survey_io/components/input/input_label.dart';
import 'package:survey_io/components/padding/padding.dart';
import 'package:survey_io/components/text/text_component.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, dynamic>> listNotification = [
    {
      "id": 1,
      "date": "30-09-2023",
      "title": "Kamu mendapatkan 50 koin dari Survei",
      "status": "unread",
    },
    {
      "id": 2,
      "date": "30-09-2023",
      "title": "Kamu mendapatkan 50 koin dari Survei",
      "status": "unread",
    },
    {
      "id": 3,
      "date": "29-09-2023",
      "title": "Kamu mendapatkan 100 koin dari Polling",
      "status": "unread",
    },
    {
      "id": 4,
      "date": "28-09-2023",
      "title": "Kamu mendapatkan 150 koin dari Survei",
      "status": "unread",
    },
    {
      "id": 5,
      "date": "28-09-2023",
      "title": "Kamu mendapatkan 150 koin dari Polling",
      "status": "unread",
    },
    {
      "id": 6,
      "date": "26-09-2023",
      "title": "Kamu mendapatkan 50 koin dari Survei",
      "status": "unread",
    },
    {
      "id": 7,
      "date": "24-09-2023",
      "title": "Kamu mendapatkan 50 koin dari Survei",
      "status": "unread",
    },
    {
      "id": 8,
      "date": "24-09-2023",
      "title": "Kamu mendapatkan 50 koin dari Survei",
      "status": "unread",
    },
    {
      "id": 9,
      "date": "22-09-2023",
      "title": "Kamu mendapatkan 100 koin dari Polling",
      "status": "unread",
    },
    {
      "id": 10,
      "date": "22-09-2023",
      "title": "Kamu mendapatkan 150 koin dari Undang Teman",
      "status": "unread",
    },
  ];

  // Fungsi untuk mengelompokkan notifikasi berdasarkan tanggal
  Map<String, List<Map<String, dynamic>>> groupNotificationsByDate(
      List<Map<String, dynamic>> notifications) {
    Map<String, List<Map<String, dynamic>>> groupedNotifications = {};

    for (var notification in notifications) {
      final date = notification['date'];

      if (groupedNotifications.containsKey(date)) {
        groupedNotifications[date]!.add(notification);
      } else {
        groupedNotifications[date] = [notification];
      }
    }

    return groupedNotifications;
  }

  @override
  Widget build(BuildContext context) {
    final groupedNotifications = groupNotificationsByDate(listNotification);

    void markNotificationAsRead(int notificationId) {
      setState(() {
        for (var notification in listNotification) {
          if (notification['id'] == notificationId) {
            notification['status'] = 'read';
            print('$notificationId => read');
            break;
          }
        }
      });
    }

    return Scaffold(
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
        child: Column(
          children: [
            Container(
              padding: PaddingAll.p1,
              child: LabelInput(
                labelText: 'Notifikasi',
                labelStyle: TextStyles.h3(color: AppColors.secondaryColor),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: groupedNotifications.length,
              itemBuilder: (context, index) {
                final date = groupedNotifications.keys.elementAt(index);
                final notifications = groupedNotifications[date]!;

                return Column(
                  children: [
                    Container(
                      color: AppColors.bgDefault,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(13.0),
                      child: Text(
                        date,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: notifications.length,
                      itemBuilder: (context, innerIndex) {
                        final notification = notifications[innerIndex];

                        final notificationId = notification['id'];
                        final title = notification["title"];

                        return Dismissible(
                          key: Key(notificationId.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20.0),
                            color: AppColors.infoColor,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              print("Notifikasi $title diklik");
                              markNotificationAsRead(notificationId);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(notification['title'],
                                  style: notification['status'] == "read"
                                      ? TextStyles.regular(
                                          color: AppColors.secondaryLightColor)
                                      : TextStyles.regular(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.secondaryColor)),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(); // Replace Divider() with your custom separator widget if needed.
                      },
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
