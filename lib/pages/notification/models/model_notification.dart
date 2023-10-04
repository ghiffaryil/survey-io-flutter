class NotificationModel {
  final int id;
  final String title;
  String status;
  bool clicked;
  final String date;

  NotificationModel({
    required this.id,
    required this.title,
    required this.status,
    required this.clicked,
    required this.date,
  });
}
