import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:survey_io/pages/login/login.dart';
import 'package:survey_io/common/components/shimmer_card.dart';
import 'package:survey_io/bloc/survey/survey_popular/survey_popular_bloc.dart';
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';
import 'package:survey_io/datasources/login/auth_save_local_datasource.dart';
import 'package:survey_io/pages/survey/widgets/webview_survey.dart';
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

class MainSection extends StatefulWidget {
  const MainSection({
    super.key,
  });

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  String timeRemaining = '...';
  bool isGuest = true;
  bool isLogged = false;
  bool _isDisposed = false;
  String userToken = '';
  String surveyToken = '';
  int userId = 0;

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  @override
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void loadDataSource() {
    context
        .read<SurveyAyoCheckBloc>()
        .add(const SurveyAyoCheckEvent.getSurveyAyoCheck());
    context
        .read<PollingTodayBloc>()
        .add(const PollingTodayEvent.getPollingToday());
    context
        .read<SurveyPopularBloc>()
        .add(const SurveyPopularEvent.getSurveyPopular());
  }

  void checkToken() async {
    final token = await AuthLocalDatasource().getToken();
    final guestToken = await AuthLocalGuestDatasource().getToken();

    // IF TOKEN IS EMPTY
    if (token.isEmpty) {
      // IF GUEST TOKEN NOT EMPTY
      if (guestToken.isNotEmpty) {
        setState(() {
          isGuest = true;
          isLogged = false;
        });
        loadDataSource();
      } else {
        setState(() {
          isGuest = false;
          isLogged = false;
        });
        // print('No Guest Token');
      }
    } else {
      final user = await AuthLocalDatasource().getUser();
      setState(() {
        isGuest = false;
        isLogged = true;
        userToken = token;
        surveyToken = token.substring(7);
        userId = user.id;
      });
      // You can now use the user ID as needed
      print('User ID: $userId');
      loadDataSource();
      startCountdown();
    }
  }

  void startCountdown() {
    const duration = Duration(seconds: 1);
    Timer.periodic(duration, (Timer timer) {
      if (_isDisposed) {
        // Check if the widget is disposed before updating the state
        timer.cancel();
        return;
      }

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
        // setState(() {
        //   timeRemaining = '$hours:$minutes:$seconds';
        // });
        if (!_isDisposed) {
          // Check again before updating the state
          setState(() {
            timeRemaining = '$hours:$minutes:$seconds';
          });
        }
      }
    });
  }

  Future<void> refreshPage() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    loadDataSource();
    return;
  }

  void _onShare(BuildContext context, uri) {
    if (uri.isNotEmpty) {
      Share.share(uri, subject: 'Survey Link');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshPage,
      color: AppColors.info,
      backgroundColor: Colors.white,
      displacement: 120,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.14,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
            iconSection(),
            CustomDividers.verySmallDivider(),
            ayoCheckSection(),
            CustomDividers.verySmallDivider(),
            isGuest ? Container() : pollingTodaySection(),
            CustomDividers.verySmallDivider(),
            surveyPopularSection(),
            CustomDividers.verySmallDivider(),
            createSurveySection(),
          ],
        ),
      ),
    );
  }

  Widget iconSection() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: BlocBuilder<SurveyPopularBloc, SurveyPopularState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return Container();
            },
            loading: () {
              return const ShimmerIcon();
            },
            loaded: (data) {
              return Row(
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
              );
            },
          );
        },
      ),
    );
  }

  Widget ayoCheckSection() {
    return Container(
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
                labelStyle: TextStyles.regular(color: AppColors.secondary)),
            CustomDividers.verySmallDivider(),
            BlocBuilder<SurveyAyoCheckBloc, SurveyAyoCheckState>(
              builder: (context, state) {
                return state.maybeWhen(orElse: () {
                  return Container();
                }, loading: () {
                  return Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const SizedBox(
                        height: 100.0,
                        child: ShimmerCardMain(),
                      ));
                }, loaded: (data) {
                  final surveyId = data.survey.id;
                  final surveyTitle = data.survey.title;
                  final surveyTotalQuestion = data.totalQuestion;
                  final surveyPoint = data.survey.point.toString();
                  final surveyLink = data.survey.surveyLink;
                  final surveyImage = data.survey.imageHomescreen;
                  final surveyType = data.survey.type;

                  return Container(
                    height: MediaQuery.of(context).size.height * 0.2,
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
                                    surveyImage == "" ? 'asset' : 'network',
                                imageUrl: surveyImage == ""
                                    ? Images.emptyCreateSurvey
                                    : surveyImage.toString(),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    surveyTitle,
                                    style: TextStyles.h5(
                                        color: AppColors.secondary),
                                  ),
                                  surveyType == "external"
                                      ? Container()
                                      : Text('$surveyTotalQuestion Pertanyaan'),
                                  CustomDividers.verySmallDivider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            IconName.point,
                                            width: 22,
                                            height: 22,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            surveyPoint,
                                            style: TextStyles.medium(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.secondary),
                                          ),
                                        ],
                                      ),
                                      const Spacer(
                                        flex: 1,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _onShare(context, surveyLink);
                                        },
                                        icon: const Icon(
                                          Icons.share,
                                          size: 19,
                                          color: AppColors.info,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: TextButtonOutlined.primary(
                                            minWidth: 0.20,
                                            height: 30,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            text: 'Ikut Survei',
                                            onPressed: () {
                                              // print('$surveyLink?userId=$userId&token=$surveyToken');
                                              isGuest
                                                  ? Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const LoginPage()))
                                                  : data.allowed
                                                      ? surveyType == "external"
                                                          ? Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          WebviewSurvey(
                                                                            url:
                                                                                surveyLink,
                                                                            title:
                                                                                surveyTitle,
                                                                          )))
                                                          : surveyTotalQuestion ==
                                                                  0
                                                              ? Fluttertoast
                                                                  .showToast(
                                                                  msg:
                                                                      'Mohon Maaf, Survey ini belum dapat diakses!',
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .BOTTOM,
                                                                  timeInSecForIosWeb:
                                                                      1,
                                                                  backgroundColor: AppColors
                                                                      .secondary
                                                                      .withOpacity(
                                                                          0.8),
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize:
                                                                      16.0,
                                                                )
                                                              : Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => WebviewSurvey(
                                                                          url:
                                                                              '${dotenv.env['WEBVIEW_URL']}/home/survey/participate/$surveyId?userId=$userId&token=$surveyToken',
                                                                          title:
                                                                              surveyTitle)))
                                                      : Fluttertoast.showToast(
                                                          msg:
                                                              'Kamu telah mengikuti survei ini',
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              AppColors
                                                                  .secondary
                                                                  .withOpacity(
                                                                      0.8),
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0,
                                                        );
                                            }),
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
        ));
  }

  Widget pollingTodaySection() {
    return Container(
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
                    labelStyle: TextStyles.h4(color: AppColors.secondary)),
              ),
              Expanded(
                child: BlocBuilder<PollingTodayBloc, PollingTodayState>(
                    builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Container();
                    },
                    loaded: (data) {
                      if (data.isEmpty) {
                        return Container();
                      } else {
                        return Text(
                          timeRemaining,
                          textAlign: TextAlign.end,
                          style: TextStyles.regular(color: AppColors.primary),
                        );
                      }
                    },
                  );
                }),
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
                loading: () {
                  return Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const SizedBox(
                        height: 100.0,
                        child: ShimmerCardMain(),
                      ));
                },
                loaded: (data) {
                  if (data.isEmpty) {
                    return Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: SizedBox(
                        height: 50,
                        child: Text(
                          'Tidak ada Polling tersedia untuk hari ini',
                          style: TextStyles.regular(color: AppColors.secondary),
                        ),
                      ),
                    );
                  } else {
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
                            final pollingToday = data[index];

                            final pollingTitle = pollingToday.polling.title;
                            final pollingPoint =
                                pollingToday.polling.point.toString();
                            final pollingTotalVote =
                                pollingToday.totalVote.toString();

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
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
                                      padding: const EdgeInsets.all(7.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.secondary,
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            flex: 7,
                                            child: Text(
                                              pollingTitle,
                                              style: TextStyles.h4(
                                                  color: AppColors.secondary),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              alignment: Alignment.centerRight,
                                              child: Image.asset(
                                                pollingToday.allowed
                                                    ? IconName.pollingCheck
                                                    : IconName
                                                        .pollingCheckSuccess,
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
                                      data[index].allowed
                                          ? Row(
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
                                                  pollingPoint.toString(),
                                                  style: TextStyles.h6(
                                                      color:
                                                          AppColors.secondary),
                                                )
                                              ],
                                            )
                                          : Text(
                                              'Lihat Hasil',
                                              style: TextStyles.h6(
                                                  color: AppColors.info),
                                            ),
                                      Text(
                                        '$pollingTotalVote vote',
                                        style: TextStyles.small(
                                            color: AppColors.secondary),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget surveyPopularSection() {
    return Container(
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
                    labelStyle: TextStyles.h4(color: AppColors.secondary)),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListSurveiPage()));
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
            child: BlocBuilder<SurveyPopularBloc, SurveyPopularState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return Container();
                  },
                  loading: () {
                    return Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const SizedBox(
                          height: 100.0,
                          child: ShimmerCardMain(),
                        ));
                  },
                  loaded: (data) {
                    if (data.isEmpty) {
                      return Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: SizedBox(
                          height: 50,
                          child: Text(
                            'Tidak ada Survei tersedia untuk hari ini',
                            style:
                                TextStyles.regular(color: AppColors.secondary),
                          ),
                        ),
                      );
                    } else {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          // minHeight: 60,
                          maxHeight: data.length < 2
                              ? MediaQuery.of(context).size.height * 0.18
                              : MediaQuery.of(context).size.height * 0.4,
                        ),
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final survey = data[index];
                            final surveyId = survey.survey.id;
                            final surveyTitle = survey.survey.title;
                            final surveyTotalQuestion = survey.totalQuestion;
                            final surveyPoint = survey.survey.point.toString();
                            final surveyLink = survey.survey.surveyLink;
                            final surveyImage = survey.survey.imageHomescreen;
                            final surveyType = survey.survey.type;

                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
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
                                            color: Colors.grey.withOpacity(0.1),
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
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: RoundedImage(
                                                  imageType: surveyImage == ''
                                                      ? 'asset'
                                                      : 'network',
                                                  imageUrl: surveyImage == ''
                                                      ? Images.emptyCreateSurvey
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomDividers
                                                      .verySmallDivider(),
                                                  Text(
                                                    surveyTitle,
                                                    style: TextStyles.h5(
                                                        color: AppColors
                                                            .secondary),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  surveyType == "external"
                                                      ? Container()
                                                      : Text(
                                                          '$surveyTotalQuestion Pertanyaan'),
                                                  CustomDividers.smallDivider(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            IconName.point,
                                                            width: 22,
                                                            height: 22,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            surveyPoint,
                                                            style: TextStyles.medium(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .secondary),
                                                          ),
                                                        ],
                                                      ),
                                                      const Spacer(
                                                        flex: 1,
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          _onShare(context,
                                                              surveyLink);
                                                        },
                                                        icon: const Icon(
                                                          Icons.share,
                                                          size: 17,
                                                          color: AppColors.info,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 12.0),
                                                        child: TextButtonOutlined
                                                            .primary(
                                                                rounded: true,
                                                                minWidth: 0.20,
                                                                height: 30,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                text:
                                                                    'Ikut Survei',
                                                                onPressed: () {
                                                                  isGuest
                                                                      ? Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => const LoginPage()))
                                                                      : survey.allowed
                                                                          ? surveyType == "external"
                                                                              ? Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => WebviewSurvey(
                                                                                            url: surveyLink,
                                                                                            title: surveyTitle,
                                                                                          )))
                                                                              : surveyTotalQuestion == 0
                                                                                  ? Fluttertoast.showToast(
                                                                                      msg: 'Mohon Maaf, Survey ini belum dapat diakses!',
                                                                                      toastLength: Toast.LENGTH_SHORT,
                                                                                      gravity: ToastGravity.BOTTOM,
                                                                                      timeInSecForIosWeb: 1,
                                                                                      backgroundColor: AppColors.secondary.withOpacity(0.8),
                                                                                      textColor: Colors.white,
                                                                                      fontSize: 16.0,
                                                                                    )
                                                                                  : Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                          builder: (context) => WebviewSurvey(
                                                                                                url: '${dotenv.env['WEBVIEW_URL']}/home/survey/participate/$surveyId?userId=$userId&token=$surveyToken',
                                                                                                title: surveyTitle,
                                                                                              )))
                                                                          : Fluttertoast.showToast(
                                                                              msg: 'Kamu telah mengikuti survei ini',
                                                                              toastLength: Toast.LENGTH_SHORT,
                                                                              gravity: ToastGravity.BOTTOM,
                                                                              timeInSecForIosWeb: 1,
                                                                              backgroundColor: AppColors.secondary.withOpacity(0.8),
                                                                              textColor: Colors.white,
                                                                              fontSize: 16.0,
                                                                            );
                                                                  ;
                                                                }),
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
                            );
                          },
                        ),
                      );
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget createSurveySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          LabelInput(
              labelText: 'Mau Buat Survei Sendiri?',
              labelStyle: TextStyles.h4(color: AppColors.secondary)),
          CustomDividers.smallDivider(),
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
                    // height: 0,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    text: 'Buat Survei',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SurveyDesignListPage()));
                    }),
              ],
            ),
          ),
          CustomDividers.verySmallDivider(),
        ],
      ),
    );
  }
}
