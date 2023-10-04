import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/pages/home/presentation/home.dart';
import 'package:survey_io/pages/profile/presentation/pre_register.dart';
import 'package:survey_io/pages/survey/presentation/create_survey.dart';

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
    const BuatSurvei(),
    const PreRegister()
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
              color: AppColors.secondaryColor.withOpacity(0.3),
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
                      'assets/images/icons/ikutsurvei_icon_focused.png',
                      width: 30,
                    )
                  : Image.asset(
                      'assets/images/icons/polling_check_focused.png',
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
                      'assets/images/icons/akun_icon_focused.png',
                      width: 30,
                    )
                  : Image.asset(
                      'assets/images/icons/akun_icon.png',
                      width: 30,
                    ),
              label: 'Akun',
            ),
          ],
          currentIndex: widget.selectedIndex,
          onTap: onClicked,
          selectedItemColor: AppColors.menuColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
