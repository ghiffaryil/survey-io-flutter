import '../../models/messages/messages_model.dart';

class ListMessage {
  static List<MessagesModel> getMessage() {
    return [
      MessagesModel(
        createdAt: "2023-06-18T17:31:25.029Z",
        title: "title 5",
        description: "description 5",
        image:
            "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80",
        id: 920,
        userId: 5,
        clicked: false,
        status: "unread",
      ),
      MessagesModel(
        createdAt: "2023-03-26T01:00:14.520Z",
        title: "title 6",
        description: "description 6",
        image:
            "https://images.unsplash.com/photo-1556742111-a301076d9d18?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80",
        id: 16012,
        userId: 6,
        clicked: false,
        status: "unread",
      ),
      MessagesModel(
        createdAt: "2023-03-26T16:44:50.825Z",
        title: "title 7",
        description: "description 7",
        image:
            "https://images.unsplash.com/photo-1635950340810-2fb374521a7b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1738&q=80",
        id: 23023,
        userId: 7,
        clicked: false,
        status: "unread",
      ),
      MessagesModel(
        createdAt: "2023-03-26T15:51:11.176Z",
        title: "title 8",
        description: "description 8",
        image:
            "https://plus.unsplash.com/premium_photo-1663956138984-4bdb183b048e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1694&q=80",
        id: 0472,
        userId: 8,
        clicked: false,
        status: "unread",
      ),
    ];
  }
}
