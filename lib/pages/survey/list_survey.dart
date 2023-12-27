import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:survey_io/common/components/shimmer_card.dart';

// Import Component
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/common/components/image_rounded.dart';
import 'package:survey_io/common/constants/images.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';
import 'package:survey_io/datasources/login/auth_save_local_datasource.dart';
import 'package:survey_io/pages/survey/widgets/webview_survey.dart';

import '../../bloc/survey/survey_list/survey_list_bloc.dart';
import '../../common/components/appbar_plain.dart';
import '../../common/constants/icons.dart';

class ListSurveiPage extends StatefulWidget {
  const ListSurveiPage({super.key});

  @override
  State<ListSurveiPage> createState() => _ListSurveiPageState();
}

class _ListSurveiPageState extends State<ListSurveiPage> {
  bool isGuest = true;
  bool isLogged = false;
  String userToken = '';
  String surveyToken = '';

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void loadDataSource() {
    context.read<SurveyListBloc>().add(const SurveyListEvent.getSurveyList());
  }

  void checkToken() async {
    final token = await AuthLocalDatasource().getToken();
    final guestToken = await AuthLocalGuestDatasource().getToken();

    // IF TOKEN IS EMPTY
    if (token.isEmpty) {
      // IF GUEST TOKEN NOT EMPTY
      if (guestToken.isNotEmpty) {
        print('Guest Token => $guestToken');
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
        print('No Guest Token');
      }
    } else {
      // Have User Token
      print('User Token : $token');
      setState(() {
        isGuest = false;
        isLogged = true;
        userToken = token;
        surveyToken = token.substring(7);
      });
      loadDataSource();
    }
  }

  Future<void> refreshPage() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    loadDataSource();
    return;
  }

  void _onShare(BuildContext context, uri) {
    if (uri.isNotEmpty) {
      // Share.shareUri(Uri.parse(uri));
      Share.share(uri, subject: 'Survey Link');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
        height: 70.0,
        leadingIcon: Icons.arrow_back_ios,
        iconSize: 35.0,
        iconColor: AppColors.secondary,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        padding: CustomPadding.px1,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: LabelInput(
                  labelText: 'Survei',
                  labelStyle:
                      TextStyles.h2ExtraBold(color: AppColors.secondary)),
            ),
            CustomDividers.smallDivider(),
            Expanded(
                child: RefreshIndicator(
                    color: AppColors.info,
                    backgroundColor: Colors.white,
                    onRefresh: refreshPage,
                    child: SingleChildScrollView(
                      child: listSurveySection(),
                    ))),
          ],
        ),
      ),
    );
  }

  Widget listSurveySection() {
    return Container(
        padding: CustomPadding.p1,
        child: BlocBuilder<SurveyListBloc, SurveyListState>(
            builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return Container();
            },
            loading: () {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: ShimmerListSurvey(),
                    );
                  });
            },
            error: (message) {
              return Text(message);
            },
            loaded: (surveyList) {
              if (surveyList.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Image.asset(
                        Images.emptyList,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Oops, Sepertinya sedang tidak ada Survey!',
                          textAlign: TextAlign.center,
                          style: TextStyles.h3(color: AppColors.secondary),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: surveyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final survey = surveyList[index];
                    return Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.light.withOpacity(0.4),
                            width: 0.3,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: survey.survey.imageHomescreen.isEmpty
                                ? const RoundedImage(
                                    imageType: 'asset',
                                    imageUrl:
                                        'assets/images/global/img_empty_create_survey.png',
                                    borderRadius: 8.0,
                                    fit: BoxFit.contain,
                                  )
                                : RoundedImage(
                                    imageType: 'network',
                                    imageUrl: survey.survey.imageHomescreen,
                                    borderRadius: 8.0,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomDividers.verySmallDivider(),
                                Text(
                                  survey.survey.title,
                                  style:
                                      TextStyles.h5(color: AppColors.secondary),
                                ),
                                const SizedBox(height: 5),
                                Text('${survey.totalQuestion} Pertanyaan'),
                                CustomDividers.smallDivider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                          survey.survey.energy.toString(),
                                          style: TextStyles.large(
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
                                        _onShare(
                                            context, survey.survey.surveyLink);
                                      },
                                      icon: const Icon(
                                        Icons.share,
                                        size: 19,
                                        color: AppColors.info,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: TextButtonFilled.primary(
                                          minWidth: 0.20,
                                          height: 30,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          text: 'Ikut Survei',
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        WebviewSurvey(
                                                          id: survey.survey.id,
                                                          url:'${survey.survey.surveyLink}?token=$surveyToken',
                                                          title: survey
                                                              .survey.title,
                                                        )));
                                          }),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return CustomDividers.regularDivider();
                  },
                );
              }
            },
          );
        }));
  }
}
