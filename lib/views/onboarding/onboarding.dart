// ignore_for_file: unused_import, unused_field

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Import Component
import 'package:survey_io/components/button/button_component.dart';
import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/components/text/text_component.dart';

// Get Page
import '../register/register_phone_number.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class CarouselItem {
  final String imagePath;
  final String title;
  final String description;

  CarouselItem({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentIndex = 0;
  CarouselController _carouselController = CarouselController();

  final List<CarouselItem> carouselItems = [
    CarouselItem(
      imagePath: 'assets/images/onboarding/img-onboarding-slide-1.svg',
      title: 'Selamat Datang',
      description:
          'Dengan Survei.io, kamu bisa berbagi opini sekaligus membuat survei sendiri',
    ),
    CarouselItem(
      imagePath: 'assets/images/onboarding/img-onboarding-slide-2.svg',
      title: 'Ikut Survei',
      description:
          'Bagikan opini kamu sambil mengumpulkan uang jajan dari Survei.io',
    ),
    CarouselItem(
      imagePath: 'assets/images/onboarding/img-onboarding-slide-3.svg',
      title: 'Buat Survei',
      description:
          'Rencanakan survei kamu kapanpun dan di manapun dengan Survei.io',
    ),
  ];

  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HeaderLogo(),
            OnboardingSlider(),
            SizedBox(
              height: 20,
            ),
            ButtonIkutiSurvey(),
            ButtonBuatSurvey()
          ],
        ),
      ),
    );
  }

  Widget HeaderLogo() {
    return Container(
        margin: const EdgeInsets.only(top: 25),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/logo/logo-survey-io-horizontal.png',
          width: MediaQuery.of(context).size.width * 0.6,
        ));
  }

  Widget OnboardingSlider() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.5,
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              }),
          items: carouselItems.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return CarouselItemWidget(item: item);
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carouselItems.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {
                _carouselController.animateToPage(entry.key);
              },
              child: Container(
                width: 15.0,
                height: 15.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? AppColors.primaryColor
                        : AppColors.secondaryColor),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }

  Widget ButtonIkutiSurvey() {
    return ButtonPrimary(
        text: 'Ikut Survei',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterPage()),
          );
        });
  }

  Widget ButtonBuatSurvey() {
    return ButtonOutlinePrimary(
        text: 'Buat Survei',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterPage()),
          );
        });
  }
}

class CarouselItemWidget extends StatelessWidget {
  final CarouselItem item;
  CarouselItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            item.imagePath,
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            item.title,
            style: TextStyles.h2(color: AppColors.secondaryColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(item.description,
              textAlign: TextAlign.center,
              style: TextStyles.regular(color: AppColors.secondaryColor)),
        ],
      ),
    );
  }
}
