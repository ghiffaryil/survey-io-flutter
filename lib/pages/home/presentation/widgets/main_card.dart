// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../common/components/divider.dart';
import '../../../../common/components/image_rounded.dart';
import '../../../../common/components/label.dart';
import '../../../../common/components/text_button.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/icons.dart';
import '../../../../common/constants/images.dart';
import '../../../../common/constants/styles.dart';

import '../../../invite/presentation/invite.dart';
import '../../../polling/presentation/list_polling.dart';
import '../../../survey/presentation/survey.dart';

class MainCard extends StatelessWidget {
  final List popularSurvey;
  final List pollingToday;

  const MainCard({
    super.key,
    required this.popularSurvey,
    required this.pollingToday,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: null,
      right: null,
      bottom: null,
      left: null,
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
                    Container(
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
                                child: const RoundedImage(
                                  imageType: 'network',
                                  imageUrl:
                                      'https://previews.123rf.com/images/stokkete/stokkete2205/stokkete220500293/186151849-woman-scanning-a-qr-code-with-her-phone-and-crowd-of-people-in-the-background-pov-shot.jpg',
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
                                      'Kenalan Lebih Jauh',
                                      style: TextStyles.h5(
                                          color: AppColors.secondary),
                                    ),
                                    const Text('10 Pertanyaan'),
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
                                              '100',
                                              style: TextStyles.h6(
                                                  color: AppColors.secondary),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: TextButtonOutlined.primary(
                                              minWidth: 0.20,
                                              height: 30,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
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
                          '23:59:59',
                          textAlign: TextAlign.end,
                          style: TextStyles.regular(color: AppColors.primary),
                        ),
                      )
                    ],
                  ),
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
                    child: SizedBox(
                      height: 150,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: pollingToday.length,
                        itemBuilder: (context, index) {
                          final pollingTodayData = pollingToday[index];
                          final pollingText = pollingTodayData.pollingTitle;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.secondary, width: 0.5),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: Text(
                                          pollingText,
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
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          alignment: Alignment.centerRight,
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
                                          '100',
                                          style: TextStyles.h6(
                                              color: AppColors.secondary),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '24k Votes',
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
                  Row(
                    children: [
                      Expanded(
                        child: LabelInput(
                            labelText: 'Survei Populer',
                            labelStyle:
                                TextStyles.h4(color: AppColors.secondary)),
                      ),
                      Expanded(
                        child: Text(
                          'Lihat Semua',
                          textAlign: TextAlign.end,
                          style: TextStyles.regular(color: AppColors.info),
                        ),
                      )
                    ],
                  ),
                  CustomDividers.smallDivider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: ListView.builder(
                      itemCount: popularSurvey.length,
                      itemBuilder: (BuildContext context, int index) {
                        final survey = popularSurvey[index];
                        final surveyTitle = survey.title;
                        final surveyQuestions = survey.questions;
                        final surveyReward = survey.reward;
                        final surveyImage = survey.image;

                        return Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(children: [
                            Container(
                              padding: const EdgeInsets.all(4),
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
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: RoundedImage(
                                            imageType: 'network',
                                            imageUrl: surveyImage,
                                            borderRadius: 8.0,
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100)),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      flex: 7,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomDividers.verySmallDivider(),
                                          Text(
                                            surveyTitle,
                                            style: TextStyles.h5(
                                                color: AppColors.secondary),
                                          ),
                                          const SizedBox(height: 5),
                                          Text('$surveyQuestions Pertanyaan'),
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
                                                    surveyReward,
                                                    style: TextStyles.h6(
                                                        color: AppColors
                                                            .secondary),
                                                  ),
                                                ],
                                              ),
                                              const Icon(
                                                Icons.share,
                                                size: 15,
                                                color: AppColors.info,
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
                                      )),
                                ],
                              ),
                            ),
                          ]),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            CustomDividers.verySmallDivider(),
            Container(
              padding: const EdgeInsets.all(25),
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
                            onPressed: () {})
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
