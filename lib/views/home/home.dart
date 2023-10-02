// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

// Import Component
import 'package:survey_io/components/input/input_label.dart';
import 'package:survey_io/components/padding/padding.dart';
import 'package:survey_io/components/text/text_component.dart';
import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/components/image/image_component.dart';
import 'package:survey_io/components/divider/divider_component.dart';
import 'package:survey_io/components/button/text_button_component.dart';
import 'package:survey_io/components/navigation/navigation_bottom_bar.dart';
import 'package:survey_io/components/navigation/navigation_floating_icon.dart';
import 'package:survey_io/views/home/notification.dart';
import 'package:survey_io/views/polling/list_polling.dart';
import 'package:survey_io/views/referal/invite_friend.dart';
import 'package:survey_io/views/survei/list_survei.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<Map<String, dynamic>> listDataSurvey = [
    {
      "judulSurvei": "Digital Payment Survey",
      "jumlahPertanyaanSurvei": "20",
      "hadiahSurvei": "500",
      "image":
          "https://nunganjuk.or.id/wp-content/uploads/2021/09/5ddf45a34ee64.jpg",
    },
    {
      "judulSurvei": "FMCG Survey",
      "jumlahPertanyaanSurvei": "34",
      "hadiahSurvei": "750",
      "image":
          "https://www.bizhare.id/media/wp-content/uploads/2023/05/Thumbnail_Artikel-Media_15-Perusahaan-FMCG-Terbesar-di-Indonesia.jpg",
    },
    {
      "judulSurvei": "Teeth Aligner Survey",
      "jumlahPertanyaanSurvei": "50",
      "hadiahSurvei": "1500",
      "image":
          "https://i0.wp.com/post.healthline.com/wp-content/uploads/2021/01/Woman-Holding-Invisalign-1296x728-header.jpg?w=1155&h=1528",
    },
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
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
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationPage()));
              },
              icon: const Icon(Icons.notifications))
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          // MAIN SECTION
          PositionedMainSection(),
          // RED BORDER RADIUS Section
          PositionedRedShapeSection(),

          // PROFILE SECTION
          PositionedProfileSection(),
        ]),
      ),
      bottomNavigationBar: BottomMenu(
        selectedIndex: selectedIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: NavigationFloatingIcon(
        isActive: false,
      ),
    );
  }

  Widget PositionedMainSection() {
    return Positioned(
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
            SectionIcon(),

            // AYO CEK
            CustomDividers.verySmallDivider(),
            SectionKenalan(),

            // POLLING HARI INI
            CustomDividers.verySmallDivider(),
            SectionPollingToday(),

            // SURVEI POPULER
            CustomDividers.verySmallDivider(),
            SectionSurveiPopuler(),

            CustomDividers.verySmallDivider(),
            // MAU BUAT SURVEI SENDIRI?
            SectionBuatSurvei(),

            // END DIVIDER
            CustomDividers.mediumDivider(),
          ],
        ),
      ),
    );
  }

  Widget PositionedRedShapeSection() {
    return Positioned(
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
    );
  }

  Widget PositionedProfileSection() {
    return Positioned(
      top: null,
      right: null,
      bottom: null,
      left: null,
      child: Center(
        child: Padding(
          padding: PaddingHorizontalOnly.px1,
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
                    child: Container(
                      height: double.infinity,
                      width: 1.0,
                      color: const Color(0xFFb5b5b5),
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    ),
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
    );
  }

  Widget SectionIcon() {
    return Container(
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
                        style: TextStyles.h5(color: AppColors.secondaryColor)),
                    // CustomDividers.smallDivider(),
                  ],
                ),
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
                        style: TextStyles.h5(color: AppColors.secondaryColor)),
                    // CustomDividers.smallDivider(),
                  ],
                ),
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
                        style: TextStyles.h5(color: AppColors.secondaryColor)),
                    // CustomDividers.smallDivider(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget SectionKenalan() {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            LabelInput(
                labelText: 'Ayo Cek',
                labelStyle: TextStyles.h4(color: AppColors.secondaryColor)),
            CustomDividers.verySmallDivider(),
            LabelInput(
                labelText: 'Sebelum memulai, yuk kenalan dulu!',
                labelStyle:
                    TextStyles.regular(color: AppColors.secondaryColor)),
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
                        child: const RoundedImageNetwork(
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kenalan Lebih Jauh',
                              style: TextStyles.h5(
                                  color: AppColors.secondaryColor),
                            ),
                            const Text('10 Pertanyaan'),
                            CustomDividers.verySmallDivider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: TextButtonOutlinePrimary(
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
        ));
  }

  Widget SectionPollingToday() {
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
                    labelStyle: TextStyles.h4(color: AppColors.secondaryColor)),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    '23:59:59',
                    textAlign: TextAlign.end,
                    style: TextStyles.regular(color: AppColors.primaryColor),
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
                  color: Colors.grey.withOpacity(0.1), // Shadow color
                  spreadRadius: 3, // Spread radius
                  blurRadius: 10, // Blur radius
                  offset: const Offset(0, 3), // Offset from top-left
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: AppColors.secondaryColor, width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Text(
                          'Apakah kamu sudah mendengar tentang virus Covid-19 Varian Omicron?',
                          style: TextStyles.h4(color: AppColors.secondaryColor),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.only(right: 10),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          style: TextStyles.h6(color: AppColors.secondaryColor),
                        ),
                      ],
                    ),
                    Text(
                      '24k Votes',
                      style: TextStyles.small(color: AppColors.secondaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget SectionSurveiPopuler() {
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
                    labelText: 'Survei Populer',
                    labelStyle: TextStyles.h4(color: AppColors.secondaryColor)),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'Lihat Semua',
                    textAlign: TextAlign.end,
                    style: TextStyles.regular(color: AppColors.infoColor),
                  ),
                ),
              )
            ],
          ),
          CustomDividers.smallDivider(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: ListView.builder(
              itemCount: listDataSurvey.length,
              itemBuilder: (BuildContext context, int index) {
                final survey = listDataSurvey[index];
                final judulSurvei = survey['judulSurvei'];
                final jumlahPertanyaanSurvei = survey['jumlahPertanyaanSurvei'];
                final hadiahSurvei = survey['hadiahSurvei'];
                final imageUrlSurvei = survey['image'];

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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: RoundedImageNetwork(
                                    imageUrl: imageUrlSurvei,
                                    borderRadius: 8.0,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 7,
                              child: Container(
                                // padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomDividers.verySmallDivider(),
                                    Text(
                                      judulSurvei,
                                      style: TextStyles.h5(
                                          color: AppColors.secondaryColor),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                        '${jumlahPertanyaanSurvei} Pertanyaan'),
                                    CustomDividers.smallDivider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
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
                                                '$hadiahSurvei',
                                                style: TextStyles.h6(
                                                    color: AppColors
                                                        .secondaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.share,
                                          size: 15,
                                          color: AppColors.infoColor,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: TextButtonOutlinePrimary(
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
                    ),
                  ]),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget SectionBuatSurvei() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          LabelInput(
              labelText: 'Mau Buat Survei Sendiri?',
              labelStyle: TextStyles.h4(color: AppColors.secondaryColor)),
          CustomDividers.verySmallDivider(),
          Container(
            padding: const EdgeInsets.all(20),
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
                          child: Image.asset(
                              'assets/images/icons/undraw_to_do_list_re_9_nt_7_1.png')),
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
                                  color: AppColors.secondaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CustomDividers.smallDivider(),
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
    );
  }
}
