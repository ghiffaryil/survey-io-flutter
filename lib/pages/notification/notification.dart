import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/common/components/shimmer_card.dart';
import '../../../common/components/divider.dart';
import '../../../common/components/label.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/imageSize.dart';
import '../../../common/constants/images.dart';
import '../../../common/constants/padding.dart';
import '../../../common/constants/styles.dart';
import '../../../common/extension/helper/date_helper.dart';
import '../../../common/components/appbar_plain.dart';
import '../../../models/notification/model_notification.dart';
import '../../bloc/notif/notif_bloc.dart';
import '../../datasources/notification/backup/list_notification.dart';
import 'widgets/dismissible_notification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NotificationPageState();
  }
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel> notifications = ListNotification.getNotification();

  @override
  void initState() {
    super.initState();
    context.read<NotifBloc>().add(const NotifEvent.getNotif());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: PlainAppBar(
        leadingIcon: Icons.arrow_back_ios,
        iconSize: 35.0,
        iconColor: AppColors.secondary,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: CustomPadding.p2,
            child: LabelInput(
              labelText: 'Notifikasi',
              labelStyle: TextStyles.h2(color: AppColors.secondary),
            ),
          ),
          BlocBuilder<NotifBloc, NotifState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Container();
                },
                loading: () {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return const ShimmerNotification();
                      });
                },
                error: (message) {
                  return Container(
                    padding: CustomPadding.p3,
                    child: Column(
                      children: [
                        Image.asset(
                          Images.notice,
                          width: AppWidth.imageSize(context, AppWidth.large),
                        ),
                        CustomDividers.regularDivider(),
                        Text(
                          'Oops, Data tidak ditemukan',
                          textAlign: TextAlign.center,
                          style:
                              TextStyles.extraLarge(color: AppColors.secondary),
                        )
                      ],
                    ),
                  );
                },
                loaded: (dataNotificationList) {
                  return dataNotificationList.isEmpty
                      ? Container(
                          padding: CustomPadding.p3,
                          child: Column(
                            children: [
                              Image.asset(
                                Images.emptyList,
                                width:
                                    AppWidth.imageSize(context, AppWidth.large),
                              ),
                              CustomDividers.regularDivider(),
                              Text(
                                'Ups, notifikasi masih kosong! Coba isi survei pertama kamu di menu Survei.',
                                textAlign: TextAlign.center,
                                style: TextStyles.extraLarge(
                                    color: AppColors.secondary),
                              )
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: dataNotificationList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final String dateString =
                                  dataNotificationList[index]
                                      .datetimeCreated
                                      .toString();
                              final DateTime date = DateTime.parse(dateString);
                              bool isSameDate = true;

                              if (index != 0) {
                                final String prevDateString =
                                    dataNotificationList[index - 1]
                                        .datetimeCreated
                                        .toString();
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
                                  DismissibleNotification(
                                    message:
                                        dataNotificationList[index].message,
                                    unread: dataNotificationList[index].unread,
                                    notificationId:
                                        dataNotificationList[index].id,
                                  ),
                                ]);
                              } else {
                                return DismissibleNotification(
                                  message: dataNotificationList[index].message,
                                  unread: dataNotificationList[index].unread,
                                  notificationId:
                                      dataNotificationList[index].id,
                                );
                              }
                            },
                          ),
                        );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
