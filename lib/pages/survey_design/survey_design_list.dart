import 'package:flutter/material.dart';
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/common/constants/imageSize.dart';
import 'package:survey_io/common/constants/padding.dart';

// Import Component
import '../../../common/constants/styles.dart';
import '../../../common/constants/colors.dart';
import '../../../common/components/elevated_button.dart';
import '../../../common/components/divider.dart';
import '../../../common/components/appbar.dart';
import '../../../common/constants/icons.dart';
import '../../../common/constants/images.dart';
import '../../common/constants/widgets/profile_card.dart';
import '../../common/constants/widgets/red_shape_card.dart';
import '../../datasources/survey_design/list_survey_design.dart';
import '../../../models/survey_design/survey_design_model.dart';
import '../notification/notification.dart';
import '../reedem/reedem.dart';
import '../tabs/floating_icon.dart';
import '../tabs/navigation_bottom_bar.dart';
import 'survey_design_auth.dart';

class SurveyDesignList extends StatefulWidget {
  const SurveyDesignList({super.key});

  @override
  State<SurveyDesignList> createState() => _SurveyDesignListState();
}

class _SurveyDesignListState extends State<SurveyDesignList> {
  int selectedIndex = 1;

  List<SurveyDesignModel> listSurveyDesign = MySurveyDesign.getSurveyDesign();

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
        mainSection(),
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ReedemPage()));
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

  Widget mainSection() {
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
                                    flex: 4,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              padding: CustomPadding.px1,
                                              child: Text(
                                                'Edit',
                                                textAlign: TextAlign.center,
                                                style: TextStyles.h4(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: ButtonFilled.info(
                                              height: 40,
                                              text: 'Submit',
                                              onPressed: () {
                                                showModalSubmitConfirmation(
                                                    context);
                                              }),
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

  void showModalSubmitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 25,
                )),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  padding: CustomPadding.p1,
                  child: Image.asset(
                    Images.confirmSubmitSurvey,
                    width: AppWidth.imageSize(context, AppWidth.medium),
                  )),
              CustomDividers.smallDivider(),
              Text(
                'Submit Survei',
                textAlign: TextAlign.center,
                style: TextStyles.h3(color: AppColors.secondary),
              ),
              CustomDividers.smallDivider(),
              Text(
                'Dengan mengetuk tombol “Submit”, maka survei kamu akan dikirimkan ke Admin untuk diperiksa.',
                textAlign: TextAlign.center,
                style: TextStyles.large(),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: CustomPadding.p1,
              child: Row(
                children: [
                  Expanded(
                    child: TextButtonOutlined.primary(
                        height: 45,
                        text: 'Cek Lagi',
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextButtonFilled.primary(
                          height: 45, text: 'Submit', onPressed: () {})),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
