// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

// Import Component
import 'package:survey_io/common/constants/images.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/appbar.dart';
import 'package:survey_io/pages/tabs/floating_icon.dart';
import 'package:survey_io/common/constants/imageSize.dart';
import 'package:survey_io/pages/home/widgets/main_section.dart';
import 'package:survey_io/pages/notification/notification.dart';
import 'package:survey_io/pages/tabs/navigation_bottom_bar.dart';
import 'package:survey_io/bloc/profile/get_profile/profile_bloc.dart';
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';
import 'package:survey_io/common/constants/widgets/profile_section_coin.dart';
import 'package:survey_io/datasources/login/auth_save_local_datasource.dart';
import 'package:survey_io/common/constants/widgets/red_shape_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool isLogged = false;
  bool isGuest = false;
  var presscount = 0;

  @override
  void initState() {
    super.initState();
    getPermission();
    checkToken();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkToken();
  }

  void getPermission() async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;

    // final storagePermissionStatus =
    android.version.sdkInt < 33
        ? await Permission.storage.isDenied.then((value) {
            if (value) {
              Permission.storage.request();
            }
          })
        : PermissionStatus.granted;

    // final notificationPermissionStatus =
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });

    // print('Storage Permission : $storagePermissionStatus');
    // print('Notification Permission : $notificationPermissionStatus');
  }

  void checkToken() async {
    final token = await AuthLocalDatasource().getToken();
    final guestToken = await AuthLocalGuestDatasource().getToken();

    // IF TOKEN IS EMPTY
    if (token.isEmpty) {
      // IF GUEST TOKEN NOT EMPTY
      if (guestToken.isNotEmpty) {
        print('Guest Token => $guestToken');
        setState(() {
          isGuest = true;
          isLogged = false;
        });
        loadDataSource();
      } else {
        print('No Guest Token');
      }
    } else {
      // Have User Token
      print('User Token : $token');
      print('Guest Token => $guestToken');
      setState(() {
        isGuest = false;
        isLogged = true;
      });
      loadDataSource();
    }
    // LOAD GET PERMISSION FUNCTION
  }

  void loadDataSource() {
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        presscount++;
        if (presscount == 2) {
          exit(0);
        } else {
          Fluttertoast.showToast(
            msg: 'Tekan sekali lagi untuk keluar dari Aplikasi',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.secondary.withOpacity(0.8),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      child: Scaffold(
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
          badge: true,
        ),
        body: const Stack(
          children: [
            MainSection(),
            RedShapeCircular(),
            ProfileSectionCoin(),
          ],
        ),
        bottomNavigationBar: BottomMenu(
          selectedIndex: selectedIndex,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const NavigationFloatingIcon(
          isActive: false,
        ),
      ),
    );
  }
}
