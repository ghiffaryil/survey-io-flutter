class ReedemHistoryModel {
  final int id;
  final int user_id;
  final String reward_source;
  final int reward_id;
  final int point;
  final String product_name;
  final int amount;
  final String message;
  bool clicked;
  String status;
  final String datetime_created;

  ReedemHistoryModel({
    required this.id,
    required this.user_id,
    required this.reward_source,
    required this.reward_id,
    required this.point,
    required this.amount,
    required this.product_name,
    required this.message,
    required this.datetime_created,
    required this.clicked,
    required this.status,
  });
}
