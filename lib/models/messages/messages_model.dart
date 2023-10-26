class MessagesModel {
  final int userId;
  final int id;
  final String title;
  final String description;
  final String image;
  final String createdAt;
  bool clicked;
  String status;

  MessagesModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.clicked,
    required this.status,
  });
}
