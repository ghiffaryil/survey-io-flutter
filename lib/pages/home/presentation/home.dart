import 'package:flutter/material.dart';

// Import Component
import 'package:survey_io/common/components/appbar.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/pages/polling/data/polling_today.dart';
import 'package:survey_io/pages/polling/models/polling_model.dart';
import 'package:survey_io/pages/survey/data/survey_popular.dart';
import 'package:survey_io/pages/survey/models/survey_model.dart';
import 'package:survey_io/pages/tabs/navigation_bottom_bar.dart';
import 'package:survey_io/pages/tabs/navigation_floating_icon.dart';
import 'package:survey_io/pages/home/presentation/widgets/main_card.dart';
import 'package:survey_io/pages/notification/presentation/notification.dart';
import 'package:survey_io/pages/home/presentation/widgets/red_shape_circular_card.dart';

import '../../../common/constants/images.dart';
import 'widgets/floating_profile_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List<SurveyModel> listDataPopularSurvey =
      ListSurveyPopular.getSurveyPopular();
  List<PollingModel> listPollingToday = ListPollingToday.getPollingToday();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: MainAppBar(
        title: Image.asset(
          Images.logoHorizontalWhite,
          width: MediaQuery.of(context).size.width * 0.35,
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            MainCard(
              popularSurvey: listDataPopularSurvey,
              pollingToday: listPollingToday,
            ),
            const RedShapeCircular(),
            const FloatingProfileCard(),
          ],
        ),
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
