// ignore_for_file: unused_import, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_field, unused_element, avoid_print, prefer_interpolation_to_compose_strings
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/pages/profile/profile.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import '../../common/components/appbar.dart';
import '../../common/components/appbar_plain.dart';

class PrivacyPolicyWebview extends StatefulWidget {
  const PrivacyPolicyWebview({super.key});

  @override
  State<PrivacyPolicyWebview> createState() => _PrivacyPolicyWebviewState();
}

class _PrivacyPolicyWebviewState extends State<PrivacyPolicyWebview> {
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
        appBar: WebViewAppBar(
          height: 70,
          toolbarHeight: 70,
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Profile()));
          },
          title: const Text('Kebijakan Privasi'),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        body: WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(const Color(0x00000000))
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    // Update loading bar.
                  },
                  onPageStarted: (String url) {},
                  onPageFinished: (String url) {},
                  onWebResourceError: (WebResourceError error) {},
                  onNavigationRequest: (NavigationRequest request) {
                    if (request.url.startsWith('https://survei.io')) {
                      return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
                  },
                ),
              )
              ..loadRequest(Uri.parse('https://survei.io/privacy-policy'))));
  }
}
