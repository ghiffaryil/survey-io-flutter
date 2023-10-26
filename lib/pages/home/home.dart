import 'package:flutter/material.dart';

// Import Component
import 'package:survey_io/common/components/appbar.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/icons.dart';
import 'package:survey_io/datasources/polling/list_polling_today.dart';
import 'package:survey_io/models/polling/polling_model.dart';
import 'package:survey_io/datasources/survey/list_survey_popular.dart';
import 'package:survey_io/pages/survey/list_survey.dart';
import 'package:survey_io/pages/tabs/navigation_bottom_bar.dart';
import 'package:survey_io/pages/tabs/floating_icon.dart';
import 'package:survey_io/pages/home/widgets/main_card.dart';

import '../notification/notification.dart';
import '../../common/constants/widgets/profile_card.dart';
import '../../common/constants/widgets/red_shape_card.dart';
import '../../common/constants/imageSize.dart';
import '../../common/constants/images.dart';
import '../../models/survey/survey_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List<SurveyModelData> listDataPopularSurvey =
      ListSurveyPopular.getSurveyPopular();
  List<PollingModel> listPollingToday = ListPollingToday.getPollingToday();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: MainAppBar(
        title: Image.asset(
          Images.logoHorizontalWhite,
          width: AppWidth.imageSize(context, AppWidth.regular),
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
      body: Stack(
        children: [
          MainCard(
            popularSurvey: listDataPopularSurvey,
            pollingToday: listPollingToday,
          ),
          const RedShapeCircular(),
          FloatingProfileCard(
            userFrontName: 'User',
            iconImage: Image.asset(
              IconName.totalSurvey,
              width: 40,
              height: 40,
            ),
            label: 'Jumlah Survey',
            labelValue: 0,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ListSurveiPage()));
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomMenu(
        selectedIndex: selectedIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const NavigationFloatingIcon(
        isActive: false,
      ),
    );
  }
}