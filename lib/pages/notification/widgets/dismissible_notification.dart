import 'package:flutter/material.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/icons.dart';
import '../../../common/constants/styles.dart';
import '../../../datasources/notification/read_notification_datasource.dart';

class DismissibleNotification extends StatefulWidget {
  final String message;
  final int unread;
  final int notificationId;

  const DismissibleNotification({
    super.key,
    required this.message,
    required this.unread,
    required this.notificationId,
  });

  @override
  State<DismissibleNotification> createState() =>
      _DismissibleNotificationState();
}

class _DismissibleNotificationState extends State<DismissibleNotification> {
  bool isUnread = true;

  @override
  void initState() {
    super.initState();
    widget.unread == 0 ? isUnread = false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) async {
        handleNotificationTap();
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
        onTap: () async {
          handleNotificationTap();
        },
        child: Container(
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.2,
              ),
            ),
          ),
          child: Text(
            widget.message,
            style: TextStyles.regular(
              color: isUnread ? AppColors.secondary : AppColors.light,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleNotificationTap() async {
    final datasource = ReadNotifDatasource();
    final result = await datasource.setReadNotif(widget.notificationId);
    if (result.isRight()) {
      setState(() {
        isUnread = false;
      });
    } else {
      final error = result.fold((l) => l, (r) => '');
      print('Error: $error');
    }
  }
}
