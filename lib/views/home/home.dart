import 'package:flutter/material.dart';
import 'package:survey_io/components/button/button_component.dart';

// Import Component
import 'package:survey_io/components/color/color_component.dart';
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
        title: const Text(
          'Survey Io',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          // Other widgets or cards
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
              // color: AppColors.primaryColor,
            ),
          ),

          Positioned(
            // top: 70,
            right: null,
            bottom: null,
            left: null,
            child: Container(
              decoration: const BoxDecoration(
                  // color: AppColors.secondaryColor,
                  ),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
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
                                  'assets/images/home/icon_survey.png',
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
                                  'assets/images/home/icon_polling.png',
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
                                  'assets/images/home/icon_invite.png',
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
                  Container(
                      padding: const EdgeInsets.all(25),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          LabelInput(
                              labelText: 'Ayo Cek',
                              labelStyle: TextStyles.h3(
                                  color: AppColors.secondaryColor)),
                          CustomDividers.verySmallDivider(),
                          LabelInput(
                              labelText: 'Sebelum memulai, yuk kenalan dulu!',
                              labelStyle: TextStyles.regular(
                                  color: AppColors.secondaryColor)),
                          Container(
                            // width: double.minPositive,
                            padding: EdgeInsets.all(30),
                            child: Card(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Container(
                                          padding: EdgeInsets.all(20),
                                          child: Text('AAAA'))),
                                  Expanded(
                                      child: Container(
                                          padding: EdgeInsets.all(20),
                                          child: Text('BBB'))),
                                ],
                              ),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),

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

          Positioned(
            top: null,
            right: null,
            bottom: null,
            left: null,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15.0), // Adjust the radius as needed
                  ),
                  // margin: const EdgeInsets.only(top: 5),
                  elevation: 3.0,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    child: const Center(
                      child: Text('Centered Positioned'),
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
}
