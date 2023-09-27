import 'package:flutter/material.dart';
import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/views/account/account_pre_register.dart';

import 'package:survey_io/views/home/home.dart';
import 'package:survey_io/views/survei/buat_survei.dart';

class BottomMenu extends StatefulWidget {
  final selectedIndex;
  final jumlah_notifikasi_yang_belum_terbaca;
  BottomMenu({this.selectedIndex, this.jumlah_notifikasi_yang_belum_terbaca});
  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  @override
  void initState() {
    super.initState();
  }

  void onClicked(int index) {
    print('selectedIndex => ${widget.selectedIndex}');
    print('Index yang di klik => $index');

    if (widget.selectedIndex == index) {
      return;
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return halamanTujuan[index];
      }));
    }
  }

  final List<Widget> halamanTujuan = [
    const HomePage(),
    const BuatSurvei(),
    const PreRegisterAccountPage()
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
          topLeft: Radius.circular(35), // Adjust the radius as needed
          topRight: Radius.circular(35), // Adjust the radius as needed
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
