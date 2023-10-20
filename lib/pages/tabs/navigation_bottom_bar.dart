import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/pages/home/presentation/home.dart';
import 'package:survey_io/pages/profile/presentation/profile.dart';
import 'package:survey_io/pages/survey_design/presentation/survey_design_list.dart';

import '../../common/constants/icons.dart';

class BottomMenu extends StatefulWidget {
  final int selectedIndex;
  const BottomMenu({super.key, this.selectedIndex = 0});
  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  @override
  void initState() {
    super.initState();
  }

  void onClicked(int index) {
    if (widget.selectedIndex == index) {
      return;
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (BuildContext context) {
        return halamanTujuan[index];
      }));
    }
  }

  final List<Widget> halamanTujuan = [
    const HomePage(),
    const SurveyDesignList(),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
              color: AppColors.secondary.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: widget.selectedIndex == 0
                  ? Image.asset(
                      IconName.followSurveyFocused,
                      width: 30,
                    )
                  : Image.asset(
                      IconName.pollingCheckFocused,
                      width: 30,
                    ),
              label: 'Ikut Survei',
            ),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: 'Buat Survei'),
            BottomNavigationBarItem(
              icon: widget.selectedIndex == 2
                  ? Image.asset(
                      IconName.accountFocused,
                      width: 30,
                    )
                  : Image.asset(
                      IconName.accountOutlined,
                      width: 30,
                    ),
              label: 'Akun',
            ),
          ],
          currentIndex: widget.selectedIndex,
          onTap: onClicked,
          selectedItemColor: AppColors.secondary,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
