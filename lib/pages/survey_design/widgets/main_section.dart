import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/survey/survey_design_list/survey_design_list_bloc.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/icons.dart';
import 'package:survey_io/common/constants/imageSize.dart';
import 'package:survey_io/common/constants/images.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/extension/helper/currency_helper.dart';
import 'package:survey_io/pages/survey_design/survey_design_auth.dart';

class MainSectionSurveyDesign extends StatefulWidget {
  const MainSectionSurveyDesign({super.key});

  @override
  State<MainSectionSurveyDesign> createState() =>
      _MainSectionSurveyDesignState();
}

class _MainSectionSurveyDesignState extends State<MainSectionSurveyDesign> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.all(5),
          child: BlocBuilder<SurveyDesignListBloc, SurveyDesignListState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Container();
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (message) {
                  return Center(
                    child: Text(message),
                  );
                },
                loaded: (data) {
                  if (data.isEmpty) {
                    return Padding(
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
                          style:
                              TextStyles.extraLarge(color: AppColors.secondary),
                        ),
                        CustomDividers.smallDivider(),
                        buildButtonSubmit('primary'),
                        CustomDividers.smallDivider(),
                      ]),
                    );
                  } else {
                    return Column(
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
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var surveyDesignData = data[index];

                            String screener = '';
                            surveyDesignData.totalScreener > 1
                                ? screener = 'Ya'
                                : screener = 'Tidak';

                            String statusLabel = 'Draft';
                            Color statusColor = AppColors.indicator;
                            Color textColor = AppColors.white;

                            if (surveyDesignData.created == 0) {
                              statusLabel = "Draft"; //Created
                              statusColor = AppColors.light.withOpacity(0.3);
                              textColor = const Color(0XFF5c5959);
                            } else if (surveyDesignData.created == 1) {
                              statusLabel = "Draft"; // Menunggu Pembayaran
                              statusColor = AppColors.light.withOpacity(0.3);
                              textColor = const Color(0XFF5c5959);
                            } else if (surveyDesignData.created == 2) {
                              statusLabel = "Draft"; //Draft
                              statusColor = AppColors.light.withOpacity(0.3);
                              textColor = const Color(0XFF5c5959);
                            } else if (surveyDesignData.created == 3) {
                              statusLabel = "Draft"; //Submitted
                              statusColor = AppColors.light.withOpacity(0.3);
                              textColor = const Color(0XFF5c5959);
                            } else if (surveyDesignData.created == 4) {
                              statusLabel = "Rejected";
                              statusColor = AppColors.primary;
                            } else if (surveyDesignData.created == 5) {
                              statusLabel = "Approved";
                              statusColor = AppColors.success;
                            } else {
                              statusLabel = "Done";
                              statusColor = AppColors.secondary;
                            }

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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          flex: 7,
                                          child: Text(surveyDesignData.type,
                                              textAlign: TextAlign.left,
                                              style: TextStyles.h4(
                                                  color: AppColors.secondary))),
                                      Expanded(
                                          flex: 3,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: statusColor,
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              child: Text(
                                                  statusLabel.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: textColor)),
                                            ),
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
                                        surveyDesignData.totalQuestion
                                            .toString(),
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
                                          "${surveyDesignData.ageStart}-${surveyDesignData.ageEnd}, ${surveyDesignData.gender}, ${surveyDesignData.marital}, ${surveyDesignData.province}",
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
                                        "${surveyDesignData.reportTime.toString()} hari",
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
                                  surveyDesignData.created == 0 ||
                                          surveyDesignData.created == 2
                                      ? SizedBox(
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
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {},
                                                        child: Container(
                                                          padding:
                                                              CustomPadding.px1,
                                                          child: Text(
                                                            'Edit',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                TextStyles.h4(),
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
                                      : surveyDesignData.created == 1
                                          ? SizedBox(
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 6,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Total Biaya',
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                              formatCurrency(
                                                                  surveyDesignData
                                                                      .price
                                                                      .toDouble()),
                                                              style: TextStyles
                                                                  .h4()),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: ButtonFilled.info(
                                                        height: 40,
                                                        text: 'Bayar',
                                                        onPressed: () {
                                                          showModalSubmitConfirmation(
                                                              context);
                                                        }),
                                                  )
                                                ],
                                              ),
                                            )
                                          : surveyDesignData.created == 3
                                              ? SizedBox(
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
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {},
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      CustomPadding
                                                                          .px1,
                                                                  child: Text(
                                                                    'Edit',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyles
                                                                            .h4(),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: TextButtonFilled.light(
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0xFFb5b5b5),
                                                                  height: 40,
                                                                  text:
                                                                      'Submit',
                                                                  onPressed:
                                                                      () {}),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : surveyDesignData.created == 4
                                                  ? SizedBox(
                                                      width: double.infinity,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 7,
                                                            child: Container(
                                                              child: const Text(
                                                                  'Survei kamu butuh perbaikan, Ketuk Edit untuk melakukan perubahan.'),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: TextButtonFilled
                                                                .info(
                                                                    height: 40,
                                                                    text:
                                                                        'Edit',
                                                                    onPressed:
                                                                        () {}),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : surveyDesignData.created ==
                                                          5
                                                      ? Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 10),
                                                          width:
                                                              double.infinity,
                                                          child: Row(
                                                            children: [
                                                              Flexible(
                                                                flex: 2,
                                                                child:
                                                                    Image.asset(
                                                                  IconName
                                                                      .surveyCheckApproved,
                                                                  color: AppColors
                                                                      .success,
                                                                  width: 30,
                                                                  height: 30,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 15,
                                                              ),
                                                              Flexible(
                                                                flex: 6,
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                    'Survei kamu sudah tayang. 5/50 Responden terpenuhi.',
                                                                    style: TextStyles
                                                                        .medium(
                                                                            color:
                                                                                AppColors.secondary),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : Container(
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                'Survei kamu telah selesai. Silakan download laporan hasil survei di bawah ini.',
                                                                style: TextStyles.medium(
                                                                    color: AppColors
                                                                        .light),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      flex: 4,
                                                                      child: TextButtonOutlined.info(
                                                                          height:
                                                                              40,
                                                                          text:
                                                                              'Format PDF',
                                                                          onPressed:
                                                                              () {})),
                                                                  const SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  Expanded(
                                                                      flex: 4,
                                                                      child: TextButtonOutlined.info(
                                                                          height:
                                                                              40,
                                                                          text:
                                                                              'Format CSV',
                                                                          onPressed:
                                                                              () {}))
                                                                ],
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
                    );
                  }
                },
              );
            },
          )),
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
