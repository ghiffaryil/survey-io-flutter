import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/notif/notif_bloc.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/models/notification/notification_response_model.dart';
import 'package:survey_io/pages/notification/notification.dart';

class NotificationBadge extends StatefulWidget {
  const NotificationBadge({super.key});

  @override
  State<NotificationBadge> createState() => _NotificationBadgeState();
}

class _NotificationBadgeState extends State<NotificationBadge> {
  @override
  void initState() {
    super.initState();
    context.read<NotifBloc>().add(const NotifEvent.getNotif());
  }

  void reloadScreen() {
    BlocProvider.of<NotifBloc>(context).add(const NotifEvent.getNotif());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            )
            .then((value) => reloadScreen());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20, right: 5),
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 30,
            ),
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(top: 5),
              child: BlocBuilder<NotifBloc, NotifState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Container();
                    },
                    loaded: (data) {
                      if (data.isNotEmpty) {
                        List<NotificationList> unreadNotifications = data
                            .where((notification) => notification.unread == 1)
                            .toList();

                        return Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.warning,
                              border:
                                  Border.all(color: AppColors.bg, width: 0)),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Center(
                              child: Text(
                                unreadNotifications.length.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: AppColors.black),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
