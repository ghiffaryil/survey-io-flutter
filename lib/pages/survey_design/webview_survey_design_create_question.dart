// ignore_for_file: unused_import, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_field, unused_element, avoid_print, prefer_interpolation_to_compose_strings
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/models/survey/list/survey_list_response_model.dart';
import 'package:survey_io/pages/profile/profile.dart';
import 'package:survey_io/pages/survey_design/survey_design_list.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../common/components/appbar.dart';
import '../../common/components/appbar_plain.dart';

class WebviewSurveyDesignCreateQuestion extends StatefulWidget {
  final String url;
  final String title;

  const WebviewSurveyDesignCreateQuestion(
      {super.key, required this.url, required this.title});

  @override
  State<WebviewSurveyDesignCreateQuestion> createState() =>
      _SurveyDesignPaymenStatet();
}

class _SurveyDesignPaymenStatet
    extends State<WebviewSurveyDesignCreateQuestion> {
  bool isLoading = true;
  var loadingPercentage = 0;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // close the webview here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SecondaryAppBar(
          height: 70,
          toolbarHeight: 70,
          onPressed: () {
            @override
            void dispose() {
              // close the webview here
              super.dispose();
            }

            WebViewController().clearCache();

            // Navigate to a new screen and remove all previous screens
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const SurveyDesignListPage()),
            );
          },
          title: Text('Survey Design Question',
              style: TextStyles.h3(color: AppColors.white)),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        body: WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(const Color(0x00000000))
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {},
                  onPageStarted: (String url) {},
                  onPageFinished: (String url) {},
                  onWebResourceError: (WebResourceError error) {},
                  onNavigationRequest: (NavigationRequest request) {
                    print('Ini Lho URL nya : ' + widget.url);
                    if (request.url == '${dotenv.env['WEBVIEW_URL']}') {
                      print('URL is equal ${request.url}');
                      WebViewController().clearCache();
                      @override
                      void dispose() {
                        // close the webview here
                        super.dispose();
                      }

                      WebViewController().clearCache();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SurveyDesignListPage()));
                      return NavigationDecision.prevent;
                    } else if (request.url
                        .startsWith('${dotenv.env['PAYMENT_URL']}')) {
                      return NavigationDecision.navigate;
                    } else {
                      print('URL Not Found');
                      @override
                      void dispose() {
                        // close the webview here
                        super.dispose();
                      }

                      WebViewController().clearCache();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SurveyDesignListPage()));
                      return NavigationDecision.prevent;
                    }
                  },
                ),
              )
              ..loadRequest(Uri.parse(widget.url))));
  }
}
