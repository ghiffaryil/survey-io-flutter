import 'package:flutter/material.dart';
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/datasources/login/auth_save_local_datasource.dart';
import 'package:survey_io/datasources/token/check_token_datasource.dart';
import 'package:survey_io/pages/survey_design/survey_design_create.dart';
import 'package:survey_io/pages/survey_design/survey_design_auth.dart';

class ButtonCreateSurveyDesign extends StatefulWidget {
  final bool isActive;

  const ButtonCreateSurveyDesign({
    super.key,
    required this.isActive,
  });

  @override
  State<ButtonCreateSurveyDesign> createState() =>
      _ButtonCreateSurveyDesignState();
}

class _ButtonCreateSurveyDesignState extends State<ButtonCreateSurveyDesign> {
  bool isLogged = false;
  bool isExpiredToken = false;

  @override
  void initState() {
    super.initState();
  }

  void checkAuth() async {
    final isLogin = await AuthLocalDatasource().isLogin();
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      setState(() {
        isLogged = false;
        isExpiredToken = true;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SurveyDesignAuth()));
      });
    } else if (isLogin) {
      // CHECK TOKEN IS STILL AVAILABLE
      final result = await CheckTokenDatasource().checkToken();
      result.fold(
        (error) {
          setState(() {
            isLogged = true;
            isExpiredToken = true;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SurveyDesignAuth()));
          });
        },
        (data) {
          setState(() {
            isLogged = true;
            isExpiredToken = false;
          });
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const SurveyDesign()));
        },
      );
    } else {
      setState(() {
        isLogged = false;
        isExpiredToken = true;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SurveyDesignAuth()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        child: TextButtonOutlined.transparent(
            borderColor: AppColors.primary,
            textColor: AppColors.primary,
            text: 'Buat Survei',
            onPressed: () {
              checkAuth();
            }));
  }
}
