import 'package:flutter/material.dart';
import 'package:survey_io/components/button/elevatedButton_component.dart';
import 'package:survey_io/components/button/textButton_component.dart';

// Import Component
import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/components/image/image_component.dart';
import 'package:survey_io/components/text/text_component.dart';
import 'package:survey_io/components/divider/divider_component.dart';
import 'package:survey_io/components/input/labelInput.dart';
import 'package:survey_io/components/input/textInput.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8fbff),
      appBar: AppBar(
        toolbarHeight: 100.0,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Image.asset(
          'assets/images/logo/surveiio_logo.png',
          width: MediaQuery.of(context).size.width * 0.35,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          // MAIN SCREEN
          Positioned(
            top: null,
            right: null,
            bottom: null,
            left: null,
            child: Container(
              decoration: const BoxDecoration(
                  // color: AppColors.secondaryColor,
                  ),
              child: Column(
                children: [
                  // MARGIN TOP
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),

                  // ICON SECTION
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                // CustomDividers.smallDivider(),
                                Image.asset(
                                  'assets/images/icons/icon_survey.png',
                                  width: 45,
                                  height: 45,
                                ),
                                CustomDividers.smallDivider(),
                                Text('Survei',
                                    style: TextStyles.h5(
                                        color: AppColors.secondaryColor)),
                                // CustomDividers.smallDivider(),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                // CustomDividers.smallDivider(),
                                Image.asset(
                                  'assets/images/icons/icon_polling.png',
                                  width: 45,
                                  height: 45,
                                ),
                                CustomDividers.smallDivider(),
                                Text('Polling',
                                    style: TextStyles.h5(
                                        color: AppColors.secondaryColor)),
                                // CustomDividers.smallDivider(),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                // CustomDividers.smallDivider(),
                                Image.asset(
                                  'assets/images/icons/icon_invite.png',
                                  width: 45,
                                  height: 45,
                                ),
                                CustomDividers.smallDivider(),
                                Text('Invite',
                                    style: TextStyles.h5(
                                        color: AppColors.secondaryColor)),
                                // CustomDividers.smallDivider(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomDividers.verySmallDivider(),

                  // AYO CEK
                  Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          LabelInput(
                              labelText: 'Ayo Cek',
                              labelStyle: TextStyles.h4(
                                  color: AppColors.secondaryColor)),
                          CustomDividers.verySmallDivider(),
                          LabelInput(
                              labelText: 'Sebelum memulai, yuk kenalan dulu!',
                              labelStyle: TextStyles.regular(
                                  color: AppColors.secondaryColor)),
                          CustomDividers.verySmallDivider(),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.1), // Shadow color
                                  spreadRadius: 3, // Spread radius
                                  blurRadius: 10, // Blur radius
                                  offset: const Offset(
                                      0, 3), // Offset from top-left
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
                                      child: RoundedImageNetwork(
                                        imageUrl:
                                            'https://previews.123rf.com/images/stokkete/stokkete2205/stokkete220500293/186151849-woman-scanning-a-qr-code-with-her-phone-and-crowd-of-people-in-the-background-pov-shot.jpg',
                                        borderRadius: 5.0,
                                      )),
                                ),
                                Expanded(
                                    flex: 7,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Kenalan Lebih Jauh',
                                            style: TextStyles.h5(
                                                color:
                                                    AppColors.secondaryColor),
                                          ),
                                          const Text('10 Pertanyaan'),
                                          CustomDividers.smallDivider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/icons/point_icon.png',
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '100',
                                                    style: TextStyles.h6(
                                                        color: AppColors
                                                            .secondaryColor),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: TextButtonOutlinePrimary(
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
                          )
                        ],
                      )),
                  CustomDividers.verySmallDivider(),

                  // POLLING HARI INI
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
                                  labelStyle: TextStyles.h4(
                                      color: AppColors.secondaryColor)),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  '23:59:59',
                                  textAlign: TextAlign.end,
                                  style: TextStyles.regular(
                                      color: AppColors.primaryColor),
                                ),
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
                                color: Colors.grey
                                    .withOpacity(0.1), // Shadow color
                                spreadRadius: 3, // Spread radius
                                blurRadius: 10, // Blur radius
                                offset:
                                    const Offset(0, 3), // Offset from top-left
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.secondaryColor,
                                      width: 0.5),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        'Apakah kamu sudah mendengar tentang virus Covid-19 Varian Omicron?',
                                        style: TextStyles.h4(
                                            color: AppColors.secondaryColor),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.only(right: 10),
                                        alignment: Alignment.centerRight,
                                        child: Image.asset(
                                          'assets/images/icons/polling_check.png',
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
                                        'assets/images/icons/point_icon.png',
                                        width: 25,
                                        height: 25,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '100',
                                        style: TextStyles.h6(
                                            color: AppColors.secondaryColor),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '24k Votes',
                                    style: TextStyles.small(
                                        color: AppColors.secondaryColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // SURVEI POPULER
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
                                  labelStyle: TextStyles.h4(
                                      color: AppColors.secondaryColor)),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'Lihat Semua',
                                  textAlign: TextAlign.end,
                                  style: TextStyles.regular(
                                      color: AppColors.infoColor),
                                ),
                              ),
                            )
                          ],
                        ),
                        CustomDividers.verySmallDivider(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.1), // Shadow color
                                spreadRadius: 3, // Spread radius
                                blurRadius: 10, // Blur radius
                                offset:
                                    const Offset(0, 3), // Offset from top-left
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: RoundedImageNetwork(
                                          imageUrl:
                                              'https://previews.123rf.com/images/stokkete/stokkete2205/stokkete220500293/186151849-woman-scanning-a-qr-code-with-her-phone-and-crowd-of-people-in-the-background-pov-shot.jpg',
                                          borderRadius: 5.0,
                                        )),
                                  ),
                                  Expanded(
                                      flex: 7,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Kenalan Lebih Jauh',
                                              style: TextStyles.h5(
                                                  color:
                                                      AppColors.secondaryColor),
                                            ),
                                            const Text('10 Pertanyaan'),
                                            CustomDividers.smallDivider(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/icons/point_icon.png',
                                                      width: 25,
                                                      height: 25,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '100',
                                                      style: TextStyles.h6(
                                                          color: AppColors
                                                              .secondaryColor),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10.0),
                                                  child:
                                                      TextButtonOutlinePrimary(
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // MAU BUAT SURVEI SENDIRI?
                  CustomDividers.verySmallDivider(),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1), // Shadow color
                          spreadRadius: 3, // Spread radius
                          blurRadius: 10, // Blur radius
                          offset: const Offset(0, 3), // Offset from top-left
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
                                  child: RoundedImageNetwork(
                                    imageUrl:
                                        'https://previews.123rf.com/images/stokkete/stokkete2205/stokkete220500293/186151849-woman-scanning-a-qr-code-with-her-phone-and-crowd-of-people-in-the-background-pov-shot.jpg',
                                    borderRadius: 5.0,
                                  )),
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
                                      style: TextStyles.h5(
                                          color: AppColors.secondaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextButtonOutlinePrimary(
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
          ),

          // RED BORDER RADIUS
          Positioned(
            top: null,
            right: null,
            bottom: null,
            left: null,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
                color: AppColors.primaryColor,
              ),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ),

          // PROFILE SECTION
          Positioned(
            top: null,
            right: null,
            bottom: null,
            left: null,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  // margin: const EdgeInsets.only(top: 5),
                  elevation: 4,
                  child: SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Image.asset(
                                  'assets/images/icons/account_icon.png',
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hi, User',
                                      style: TextStyles.h4(
                                          color: AppColors.secondaryColor),
                                    ),
                                    Text(
                                      'Profile Saya',
                                      style: TextStyles.regular(
                                          color: AppColors.secondaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: DividerVertical(),
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Image.asset(
                                  'assets/images/icons/point_icon.png',
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '0',
                                      style: TextStyles.h4(
                                          color: AppColors.secondaryColor),
                                    ),
                                    Text(
                                      'Celengan Saya',
                                      style: TextStyles.regular(
                                          color: AppColors.secondaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget DividerVertical() {
    return Container(
      height: double.infinity, // Adjust the height as needed
      width: 1.0, // Width of the vertical divider
      color: const Color(0xFFb5b5b5), // Color of the divider
      margin: const EdgeInsets.symmetric(
          horizontal: 8.0), // Adjust spacing as needed
    );
  }
}
