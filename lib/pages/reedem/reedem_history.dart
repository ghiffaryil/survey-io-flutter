import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/reedem/reedem_history/reedem_history_bloc.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/shimmer_card.dart';
import 'package:survey_io/models/reedem/reedem_history_response_model.dart';
import '../../../common/components/label.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/imageSize.dart';
import '../../../common/constants/images.dart';
import '../../../common/constants/padding.dart';
import '../../../common/constants/styles.dart';
import '../../../common/extension/helper/date_helper.dart';
import '../../../common/components/appbar_plain.dart';

class ReedemHistoryPage extends StatefulWidget {
  const ReedemHistoryPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ReedemHistoryPageState();
  }
}

class _ReedemHistoryPageState extends State<ReedemHistoryPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<ReedemHistoryBloc>()
        .add(const ReedemHistoryEvent.getListReedemHistory());
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
              labelText: 'Riwayat',
              labelStyle: TextStyles.h2(color: AppColors.secondary),
            ),
          ),
          BlocBuilder<ReedemHistoryBloc, ReedemHistoryState>(
            builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return Container();
              }, loading: () {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return const ShimmerNotification();
                    });
              }, error: (message) {
                return Container(
                  padding: CustomPadding.p3,
                  child: Column(
                    children: [
                      Image.asset(
                        Images.emptyList,
                        width: AppWidth.imageSize(context, AppWidth.large),
                      ),
                      CustomDividers.regularDivider(),
                      Text(
                        'Ups, riwayat hadiah masih kosong! Coba tukar koin kamu dengan Hadiah.',
                        textAlign: TextAlign.center,
                        style:
                            TextStyles.extraLarge(color: AppColors.secondary),
                      )
                    ],
                  ),
                );
              }, loaded: (data) {
                // Declarated data to list
                List<ReedemHistoryList> dataList = List.from(data);

                // Sort data by dateTimeCreated
                dataList.sort(
                    (a, b) => b.datetimeCreated.compareTo(a.datetimeCreated));

                return Expanded(
                  child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool isSameDate = true;
                      final String dateString =
                          dataList[index].datetimeCreated.toString();
                      final DateTime date = DateTime.parse(dateString);

                      if (index == 0) {
                      } else {
                        final String prevDateString =
                            dataList[index - 1].datetimeCreated.toString();
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
                          Container(
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
                            child: Text(dataList[index].message,
                                style: TextStyles.regular(
                                    color: AppColors.secondary)),
                          ),
                        ]);
                      } else {
                        return Container(
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
                          child: Text(dataList[index].message,
                              style: TextStyles.regular(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.light)),
                        );
                      }
                    },
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}