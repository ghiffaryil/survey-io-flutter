import 'package:flutter/material.dart';
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/common/constants/padding.dart';

// Import Component
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/pages/notification/presentation/notification.dart';
import 'package:survey_io/pages/reedem/presentation/reedem.dart';
import 'package:survey_io/pages/survey_design/data/list_survey_design.dart';
import 'package:survey_io/pages/survey_design/models/survey_design_model.dart';
import 'package:survey_io/pages/survey_design/presentation/auth_survey_design.dart';
import 'package:survey_io/pages/tabs/navigation_bottom_bar.dart';
import 'package:survey_io/pages/tabs/navigation_floating_icon.dart';
import 'package:survey_io/pages/home/presentation/home.dart';
import 'package:survey_io/common/components/divider.dart';

import '../../../common/components/appbar.dart';
import '../../../common/constants/floating_profile_card.dart';
import '../../../common/constants/icons.dart';
import '../../../common/constants/images.dart';
import '../../../common/constants/red_shape_circular_card.dart';

class SurveyDesign extends StatefulWidget {
  const SurveyDesign({super.key});

  @override
  State<SurveyDesign> createState() => _SurveyDesignState();
}

class _SurveyDesignState extends State<SurveyDesign> {
  int selectedIndex = 1;

  List<SurveyDesignModel> listSurveyDesign = SurveyDesignList.getSurveyDesign();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8fbff),
      appBar: MainAppBar(
        title: Text(
          'Buat Survei',
          style: TextStyles.h2ExtraBold(
            color: AppColors.white,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotificationPage(),
            ),
          );
        },
        icon: const Icon(Icons.notifications),
      ),
      body: Stack(children: [
        MainSection(),
        const RedShapeCircular(),
        FloatingProfileCard(
          userFrontName: 'User',
          iconImage: Image.asset(
            IconName.point,
            width: 40,
            height: 40,
          ),
          label: 'Celengan Saya',
          labelValue: 0,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ReedemPage()));
          },
        ),
      ]),
      bottomNavigationBar: BottomMenu(
        selectedIndex: selectedIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const NavigationFloatingIcon(
        isActive: true,
      ),
    );
  }

  Widget MainSection() {
    return SingleChildScrollView(
      child: Container(
        child: listSurveyDesign.isNotEmpty
            ? Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listSurveyDesign.length,
                    itemBuilder: (context, index) {
                      var surveyDesignData = listSurveyDesign[index];

                      String screener = '';
                      surveyDesignData.total_screener > 1
                          ? screener = 'Ya'
                          : screener = 'Tidak';

                      return Container(
                        padding: CustomPadding.p2,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 5),
                                color: AppColors.light.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 5),
                          ],
                          color: AppColors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    flex: 8,
                                    child: Text('Judul Survey',
                                        textAlign: TextAlign.left,
                                        style: TextStyles.h4(
                                            color: AppColors.secondary))),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: AppColors.light.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Text('Status',
                                          textAlign: TextAlign.center,
                                          style: TextStyles.small(
                                              color: AppColors.light)),
                                    )),
                              ],
                            ),
                            CustomDividers.smallDivider(),
                            Row(
                              children: [
                                const Text('Cakupan Survei : '),
                                Text(
                                  'Survei ${surveyDesignData.type}',
                                  style: TextStyles.regular(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Responden : '),
                                Text(
                                  surveyDesignData.respondent.toString(),
                                  style: TextStyles.regular(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Pertanyaan : '),
                                Text(
                                  surveyDesignData.total_question.toString(),
                                  style: TextStyles.regular(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Demografi : '),
                                Flexible(
                                  child: Text(
                                    "${surveyDesignData.age_start} - ${surveyDesignData.age_end}, ${surveyDesignData.gender}, ${surveyDesignData.marital}, ${surveyDesignData.province}",
                                    style: TextStyles.regular(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Kecepatan Report : '),
                                Text(
                                  "${surveyDesignData.report_time.toString()} hari",
                                  style: TextStyles.regular(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Screener : '),
                                Text(
                                  screener,
                                  style: TextStyles.regular(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const Divider(),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {},
                                            child: const Text(
                                              'Edit',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: AppColors.secondary),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: ButtonFilled.info(
                                              height: 40,
                                              text: 'Submit',
                                              onPressed: () {}),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: CustomPadding.pdefault,
                    child: buildButtonSubmit('secondary'),
                  ),
                  CustomDividers.smallDivider(),
                ],
              )
            : Padding(
                padding: CustomPadding.p3,
                child: Column(children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  Image.asset(
                    Images.emptyCreateSurvey,
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                  CustomDividers.smallDivider(),
                  Text(
                    'Ups, kamu belum punya survei nih \n Yuk buat survei kamu sekarang!',
                    textAlign: TextAlign.center,
                    style: TextStyles.extraLarge(color: AppColors.secondary),
                  ),
                  CustomDividers.smallDivider(),
                  buildButtonSubmit('primary'),
                  CustomDividers.smallDivider(),
                ]),
              ),
      ),
    );
  }

  Widget buildButtonSubmit(String mode) {
    return mode == 'primary'
        ? ButtonFilled.primary(
            text: 'Buat Survei',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AuthSurveyDesign()));
            })
        : TextButtonOutlined.transparent(
            borderColor: AppColors.primary,
            textColor: AppColors.primary,
            text: 'Buat Survei',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AuthSurveyDesign()));
            });
  }
}
