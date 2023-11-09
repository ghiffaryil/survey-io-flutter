import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/survey/survey_popular/survey_popular_bloc.dart';

import '../../../bloc/survey/ayo_check/survey_ayo_check_bloc.dart';
import '../../../bloc/polling/polling_today/polling_today_bloc.dart';
import '../../../common/components/divider.dart';
import '../../../common/components/image_rounded.dart';
import '../../../common/components/label.dart';
import '../../../common/components/text_button.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/icons.dart';
import '../../../common/constants/images.dart';
import '../../../common/constants/styles.dart';

import '../../invite/invite.dart';
import '../../polling/polling.dart';
import '../../survey/list_survey.dart';
import '../../survey_design/survey_design_list.dart';

class MainCard extends StatefulWidget {
  final List popularSurvey;
  final List pollingToday;

  const MainCard({
    super.key,
    required this.popularSurvey,
    required this.pollingToday,
  });

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  String timeRemaining = '...';

  @override
  void initState() {
    super.initState();
    context
        .read<SurveyAyoCheckBloc>()
        .add(const SurveyAyoCheckEvent.getSurveyAyoCheck());
    context
        .read<PollingTodayBloc>()
        .add(const PollingTodayEvent.getPollingToday());
    context
        .read<SurveyPopularBloc>()
        .add(const SurveyPopularEvent.getSurveyPopular());
    startCountdown();
  }

  void startCountdown() {
    const duration = Duration(seconds: 1);
    Timer.periodic(duration, (Timer timer) {
      DateTime now = DateTime.now();
      // DateTime now = DateTime.now().toUtc().add(const Duration(hours: 7)); // GMT+7
      DateTime midnight = DateTime(now.year, now.month, now.day, 23, 59, 59);

      if (now.isAfter(midnight)) {
        // Countdown is over
        setState(() {
          timeRemaining = '00:00:00';
        });
        timer.cancel();
      } else {
        // Calculate remaining time
        Duration difference = midnight.difference(now);
        String hours = difference.inHours.toString().padLeft(2, '0');
        String minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
        String seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');
        setState(() {
          timeRemaining = '$hours:$minutes:$seconds';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListSurveiPage()));
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            IconName.survey,
                            width: 45,
                            height: 45,
                          ),
                          CustomDividers.smallDivider(),
                          Text('Survei',
                              style: TextStyles.h5(color: AppColors.secondary)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PollingPage()));
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            IconName.polling,
                            width: 45,
                            height: 45,
                          ),
                          CustomDividers.smallDivider(),
                          Text('Polling',
                              style: TextStyles.h5(color: AppColors.secondary)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InviteFriend()));
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            IconName.invite,
                            width: 45,
                            height: 45,
                          ),
                          CustomDividers.smallDivider(),
                          Text('Invite',
                              style: TextStyles.h5(color: AppColors.secondary)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomDividers.verySmallDivider(),
            Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    LabelInput(
                        labelText: 'Ayo Cek',
                        labelStyle: TextStyles.h4(color: AppColors.secondary)),
                    CustomDividers.verySmallDivider(),
                    LabelInput(
                        labelText: 'Sebelum memulai, yuk kenalan dulu!',
                        labelStyle:
                            TextStyles.regular(color: AppColors.secondary)),
                    CustomDividers.verySmallDivider(),
                    BlocBuilder<SurveyAyoCheckBloc, SurveyAyoCheckState>(
                      builder: (context, state) {
                        return state.maybeWhen(orElse: () {
                          return Container();
                        }, loading: () {
                          return const SizedBox(
                            height: 40,
                            child: CircularProgressIndicator(),
                          );
                        }, error: (error) {
                          return SizedBox(
                              height: 40, child: Center(child: Text(error)));
                        }, loaded: (data) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: RoundedImage(
                                        imageType:
                                            data.survey.imageContent == ""
                                                ? 'asset'
                                                : 'network',
                                        imageUrl: data.survey.imageContent == ""
                                            ? Images.emptyCreateSurvey
                                            : data.survey.imageContent
                                                .toString(),
                                        borderRadius: 8.0,
                                      )),
                                ),
                                Expanded(
                                    flex: 7,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.survey.title,
                                            style: TextStyles.h5(
                                                color: AppColors.secondary),
                                          ),
                                          Text(
                                              '${data.totalQuestion.toString()} Pertanyaan'),
                                          CustomDividers.verySmallDivider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    IconName.point,
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    data.survey.energy
                                                        .toString(),
                                                    style: TextStyles.h6(
                                                        color: AppColors
                                                            .secondary),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child:
                                                    TextButtonOutlined.primary(
                                                        minWidth: 0.20,
                                                        height: 30,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        text: 'Ikut Survei',
                                                        onPressed: () {}),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          );
                        });
                      },
                    )
                  ],
                )),
            CustomDividers.verySmallDivider(),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: LabelInput(
                            labelText: 'Polling Hari Ini',
                            labelStyle:
                                TextStyles.h4(color: AppColors.secondary)),
                      ),
                      Expanded(
                        child: Text(
                          timeRemaining,
                          textAlign: TextAlign.end,
                          style: TextStyles.regular(color: AppColors.primary),
                        ),
                      )
                    ],
                  ),
                  CustomDividers.verySmallDivider(),
                  BlocBuilder<PollingTodayBloc, PollingTodayState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return Container();
                        },
                        error: (message) {
                          return Text(message);
                        },
                        loading: () {
                          return const SizedBox(
                              height: 40, child: CircularProgressIndicator());
                        },
                        loaded: (data) {
                          if (data.isNotEmpty) {
                            return Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: SizedBox(
                                height: 100,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const Divider();
                                  },
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    final pollingTodayData =
                                        data[index].polling;
                                    final pollingText = pollingTodayData.title;

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PollingPage(),
                                                )),
                                            child: Container(
                                              width: double.infinity,
                                              padding:
                                                  const EdgeInsets.all(7.0),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors.secondary,
                                                    width: 0.5),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    flex: 7,
                                                    child: Text(
                                                      pollingText,
                                                      style: TextStyles.h4(
                                                          color: AppColors
                                                              .secondary),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Image.asset(
                                                        IconName.pollingCheck,
                                                        width: 25,
                                                        height: 25,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          CustomDividers.smallDivider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    IconName.point,
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    pollingTodayData.point
                                                        .toString(),
                                                    style: TextStyles.h6(
                                                        color: AppColors
                                                            .secondary),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '${data[index].totalVote.toString()} vote',
                                                style: TextStyles.small(
                                                    color: AppColors.secondary),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: const SizedBox(
                                height: 50,
                                child: Text('No Polling Today'),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            CustomDividers.verySmallDivider(),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: LabelInput(
                            labelText: 'Survei Populer',
                            labelStyle:
                                TextStyles.h4(color: AppColors.secondary)),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ListSurveiPage()));
                          },
                          child: Text(
                            'Lihat Semua',
                            textAlign: TextAlign.end,
                            style: TextStyles.regular(color: AppColors.info),
                          ),
                        ),
                      )
                    ],
                  ),
                  CustomDividers.smallDivider(),
                  SizedBox(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 40,
                        maxHeight: MediaQuery.of(context).size.height * 0.45,
                      ),
                      child: BlocBuilder<SurveyPopularBloc, SurveyPopularState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return Container();
                            },
                            loading: () {
                              return const SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(),
                              );
                            },
                            error: (message) {
                              return Text(message);
                            },
                            loaded: (surveyList) {
                              return ListView.builder(
                                itemCount: surveyList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final survey = surveyList[index];
                                  final surveyTitle = survey.survey.title;

                                  final totalSurveyQuestions =
                                      survey.totalQuestion;

                                  final surveyEnergy =
                                      survey.survey.energy.toString();
                                  final surveyImage =
                                      survey.survey.imageHomescreen;

                                  return Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Column(children: [
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                    spreadRadius: 3,
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        child: RoundedImage(
                                                          imageType:
                                                              surveyImage == ''
                                                                  ? 'asset'
                                                                  : 'network',
                                                          imageUrl: surveyImage ==
                                                                  ''
                                                              ? Images
                                                                  .emptyCreateSurvey
                                                              : surveyImage,
                                                          borderRadius: 8.0,
                                                          fit: BoxFit.cover,
                                                          width: 100,
                                                          height: 100,
                                                        )),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                      flex: 7,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomDividers
                                                              .verySmallDivider(),
                                                          Text(
                                                            surveyTitle,
                                                            style: TextStyles.h5(
                                                                color: AppColors
                                                                    .secondary),
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Text(
                                                              '$totalSurveyQuestions Pertanyaan'),
                                                          CustomDividers
                                                              .smallDivider(),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Image.asset(
                                                                    IconName
                                                                        .point,
                                                                    width: 25,
                                                                    height: 25,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    surveyEnergy,
                                                                    style: TextStyles.h6(
                                                                        color: AppColors
                                                                            .secondary),
                                                                  ),
                                                                ],
                                                              ),
                                                              const Icon(
                                                                Icons.share,
                                                                size: 15,
                                                                color: AppColors
                                                                    .info,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            10.0),
                                                                child: TextButtonOutlined.primary(
                                                                    minWidth:
                                                                        0.20,
                                                                    height: 30,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    text:
                                                                        'Ikut Survei',
                                                                    onPressed:
                                                                        () {}),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ]),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            CustomDividers.verySmallDivider(),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  LabelInput(
                      labelText: 'Mau Buat Survei Sendiri?',
                      labelStyle: TextStyles.h4(color: AppColors.secondary)),
                  CustomDividers.verySmallDivider(),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(Images.createOwnSurvey)),
                            ),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Buat survei sesuai kebutuhanmu dengan Survei.io',
                                      style: TextStyles.regular(
                                          color: AppColors.secondary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        CustomDividers.smallDivider(),
                        TextButtonOutlined.primary(
                            minWidth: 1,
                            height: 40,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            text: 'Buat Survei',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SurveyDesignList()));
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomDividers.mediumDivider(),
          ],
        ),
      ),
    );
  }
}
