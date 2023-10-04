import 'package:survey_io/pages/notification/models/model_notification.dart';

// GET DATA FROM API
class NotificationList {
  static List<NotificationModel> getNotification() {
    return [
      NotificationModel(
        id: 1,
        title: 'Kamu mendapatkan 50 koin dari Survei',
        status: 'unread',
        clicked: false,
        date: '2023-10-01',
      ),
      NotificationModel(
        id: 2,
        title: 'Kamu mendapatkan 50 koin dari Survei',
        status: 'unread',
        clicked: false,
        date: '2023-09-30',
      ),
      NotificationModel(
        id: 3,
        title: 'Kamu mendapatkan 100 koin dari Polling',
        status: 'unread',
        clicked: false,
        date: '2023-09-30',
      ),
      NotificationModel(
        id: 4,
        title: 'Kamu mendapatkan 150 koin dari Survei',
        status: 'unread',
        clicked: false,
        date: '2023-09-30',
      ),
      NotificationModel(
        id: 5,
        title: 'Kamu mendapatkan 150 koin dari Polling',
        status: 'unread',
        clicked: false,
        date: '2023-09-28',
      ),
      NotificationModel(
        id: 6,
        title: 'Kamu mendapatkan 50 koin dari Survei',
        status: 'unread',
        clicked: false,
        date: '2023-09-26',
      ),
      NotificationModel(
        id: 7,
        title: 'Kamu mendapatkan 50 koin dari Survei',
        status: 'unread',
        clicked: false,
        date: '2023-09-24',
      ),
      NotificationModel(
        id: 8,
        title: 'Kamu mendapatkan 50 koin dari Survei',
        status: 'unread',
        clicked: false,
        date: '2023-09-24',
      ),
      NotificationModel(
        id: 9,
        title: 'Kamu mendapatkan 100 koin dari Polling',
        status: 'unread',
        clicked: false,
        date: '2023-09-23',
      ),
      NotificationModel(
        id: 10,
        title: 'Kamu mendapatkan 150 koin dari Undang Teman',
        status: 'unread',
        clicked: true,
        date: '2023-09-22',
      ),
    ];
  }
}
