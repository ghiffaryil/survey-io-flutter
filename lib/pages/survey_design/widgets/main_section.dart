import 'dart:isolate';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:survey_io/bloc/profile/get_profile/profile_bloc.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/shimmer_card.dart';
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/toast.dart';
import 'package:survey_io/common/constants/function/utils.dart';
import 'package:survey_io/common/constants/imageSize.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/images.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/icons.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/config/flavor_type.dart';
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';
import 'package:survey_io/datasources/login/auth_save_local_datasource.dart';
import 'package:survey_io/pages/profile/edit_profile_complete.dart';
import 'package:survey_io/pages/survey_design/survey_design.dart';
import 'package:survey_io/pages/survey_design/survey_design_list.dart';
import 'package:survey_io/common/extension/helper/currency_helper.dart';
import 'package:survey_io/bloc/survey_design/survey_design_list/survey_design_list_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_payment/survey_design_payment_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_submit/survey_design_submit_bloc.dart';
import 'package:survey_io/pages/survey_design/webview_survey_design_create_question.dart';
import 'package:survey_io/pages/survey_design/webview_survey_design_payment.dart';

class MainSectionSurveyDesign extends StatefulWidget {
  const MainSectionSurveyDesign({super.key});

  @override
  State<MainSectionSurveyDesign> createState() =>
      _MainSectionSurveyDesignState();
}

class _MainSectionSurveyDesignState extends State<MainSectionSurveyDesign> {
  String ktp = '';
  String npwp = '';
  int userActive = 0;

  bool isLogged = false;
  bool isGuest = true;
  String userToken = '';
  String surveyToken = '';
  int userId = 0;

  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // ignore: unused_local_variable
      String id = data[0];
      DownloadTaskStatus status = data[1];
      // ignore: unused_local_variable
      int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        ToastComponent.showToast('Download selesai');
      } else {
        ToastComponent.showToast('Download Failed');
      }
      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);
    checkToken();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    DownloadTaskStatus downloadStatus = DownloadTaskStatus.values[status];
    send!.send([id, downloadStatus, progress]);
  }

  void downloadFile(String url) async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;

    final storageStatus = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;

    print('status granted $storageStatus');

    if (storageStatus.isGranted) {
      final baseStorage = await getExternalStorageDirectory();
      ToastComponent.showToast('Mulai mengunduh file');
      await FlutterDownloader.enqueue(
        url: url,
        savedDir: baseStorage!.path,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: true,
        allowCellular: true,
      );
      ToastComponent.showToast('Download file berhasil');
    } else {
      ToastComponent.showToast('Harap aktifkan izin akses File Handphone anda');
      if (storageStatus.isDenied || storageStatus.isPermanentlyDenied) {
        openAppSettings();
      }
      print('storageStatus granted $storageStatus');
    }
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
      } else {
        setState(() {
          isGuest = false;
          isLogged = false;
        });
        print('No Guest Token');
      }
    } else {
      print('User Token : $token');
      final user = await AuthLocalDatasource().getUser();
      setState(() {
        isGuest = false;
        isLogged = true;
        userToken = token;
        surveyToken = token.substring(7);
        userId = user.id;
      });
      print('UserId $userId');
    }
  }

  void loadDataSource() {
    context
        .read<SurveyDesignListBloc>()
        .add(const SurveyDesignListEvent.getSurveyDesignList());
  }

  Future<void> refreshPage() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    loadDataSource();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshPage,
      color: AppColors.info,
      backgroundColor: Colors.white,
      displacement: 120,
      child: SingleChildScrollView(
        child: BlocBuilder<SurveyDesignListBloc, SurveyDesignListState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return Container();
              },
              loading: () {
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
                              padding: CustomPadding.p3,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 5),
                                      color: AppColors.light.withOpacity(0.2),
                                      spreadRadius: 0,
                                      blurRadius: 5),
                                ],
                                color: AppColors.white,
                              ),
                              child: const ShimmerSurveyDesign());
                        }),
                    CustomDividers.smallDivider(),
                  ],
                );
              },
              error: (message) {
                return Column(children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  Image.asset(
                    Images.emptyCreateSurvey,
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                  CustomDividers.smallDivider(),
                  Text(
                    'Ups, Terjadi kesalahan',
                    textAlign: TextAlign.center,
                    style: TextStyles.extraLarge(color: AppColors.secondary),
                  ),
                ]);
              },
              loaded: (data) {
                if (data.isEmpty) {
                  return Padding(
                    padding: CustomPadding.p3,
                    child: Column(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      Image.asset(
                        Images.emptyCreateSurvey,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                      CustomDividers.smallDivider(),
                      Text(
                        'Ups, kamu belum punya survei nih \n Yuk buat survei kamu sekarang!',
                        textAlign: TextAlign.center,
                        style:
                            TextStyles.extraLarge(color: AppColors.secondary),
                      ),
                      CustomDividers.smallDivider(),
                      // buildButtonSubmit('primary'),
                      CustomDividers.smallDivider(),
                    ]),
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.12,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var surveyDesignData = data[index];

                          // print(surveyDesignData.createQuestionUrl);

                          String screener = '';
                          surveyDesignData.totalScreener > 1
                              ? screener = 'Ya'
                              : screener = 'Tidak';

                          String statusLabel = 'Draft';
                          Color statusColor = AppColors.indicator;
                          Color textColor = AppColors.white;

                          if (surveyDesignData.created == 0) {
                            statusLabel = "Draft"; //Created
                            statusColor = AppColors.light.withOpacity(0.3);
                            textColor = const Color(0XFF5c5959);
                          } else if (surveyDesignData.created == 1) {
                            statusLabel = "Draft"; // Menunggu Pembayaran
                            statusColor = AppColors.light.withOpacity(0.3);
                            textColor = const Color(0XFF5c5959);
                          } else if (surveyDesignData.created == 2) {
                            statusLabel = "Draft"; //Draft //Paid
                            statusColor = AppColors.light.withOpacity(0.3);
                            textColor = const Color(0XFF5c5959);
                          } else if (surveyDesignData.created == 3) {
                            statusLabel = "Submitted"; //Submitted
                            statusColor = AppColors.info;
                            textColor = AppColors.white;
                          } else if (surveyDesignData.created == 4) {
                            statusLabel = "Rejected";
                            statusColor = AppColors.primary;
                          } else if (surveyDesignData.created == 5) {
                            statusLabel = "Approved";
                            statusColor = AppColors.success;
                          } else {
                            statusLabel = "Done";
                            statusColor = AppColors.secondary;
                          }

                          return Container(
                            padding: CustomPadding.p2,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 5),
                                    color: AppColors.light.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 5),
                              ],
                              color: AppColors.white,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        flex: 7,
                                        child: Text(surveyDesignData.title,
                                            textAlign: TextAlign.left,
                                            style: TextStyles.h4(
                                                color: AppColors.secondary))),
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: statusColor,
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            child: Text(statusLabel.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: textColor)),
                                          ),
                                        )),
                                  ],
                                ),
                                CustomDividers.smallDivider(),
                                Row(
                                  children: [
                                    const Text('Cakupan Survei : '),
                                    Text(
                                      'Survei ${surveyDesignData.type}',
                                      style: TextStyles.regular(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Responden : '),
                                    Text(
                                      surveyDesignData.respondent.toString(),
                                      style: TextStyles.regular(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Pertanyaan : '),
                                    Text(
                                      surveyDesignData.totalQuestion.toString(),
                                      style: TextStyles.regular(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Demografi : '),
                                    Flexible(
                                      child: Text(
                                        "${surveyDesignData.ageStart}-${surveyDesignData.ageEnd}, ${surveyDesignData.gender}, ${surveyDesignData.marital}, ${surveyDesignData.province}",
                                        style: TextStyles.regular(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Kecepatan Report : '),
                                    Text(
                                      "${surveyDesignData.reportTime.toString()} hari",
                                      style: TextStyles.regular(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Screener : '),
                                    Text(
                                      screener,
                                      style: TextStyles.regular(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                surveyDesignData.created == 0
                                    ? SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: Container(),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: ButtonFilled.info(
                                                  height: 40,
                                                  text: 'Lanjutkan',
                                                  onPressed: () {
                                                    String modifiedUrl =
                                                        replaceAmpersAnd(
                                                            surveyDesignData
                                                                .createQuestionUrl);
                                                    print(
                                                        '$modifiedUrl&key=$surveyToken');
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                WebviewSurveyDesignCreateQuestion(
                                                                  title:
                                                                      surveyDesignData
                                                                          .title,
                                                                  url:
                                                                      '$modifiedUrl&key=$surveyToken',
                                                                  // url:'https://dev-app.survei.io'
                                                                )));
                                                  }),
                                            )
                                          ],
                                        ),
                                      )
                                    : surveyDesignData.created == 1
                                        ? SizedBox(
                                            width: double.infinity,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 7,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          'Total Biaya',
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                            formatCurrency(
                                                                surveyDesignData
                                                                    .price
                                                                    .toDouble()),
                                                            style: TextStyles
                                                                .h4()),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: BlocListener<
                                                      SurveyDesignPaymentBloc,
                                                      SurveyDesignPaymentState>(
                                                    listener: (context, state) {
                                                      state.maybeWhen(
                                                        orElse: () {},
                                                        loaded: (data) {
                                                          print(data.url);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      WebviewSurveyDesignPayment(
                                                                          url: data
                                                                              .url)));
                                                        },
                                                        error: (message) {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                'Mohon maaf, sepertinya terjadi kesalahan teknis!',
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                AppColors
                                                                    .secondary
                                                                    .withOpacity(
                                                                        0.7),
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0,
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: BlocBuilder<
                                                        SurveyDesignPaymentBloc,
                                                        SurveyDesignPaymentState>(
                                                      builder:
                                                          (context, state) {
                                                        return state.maybeWhen(
                                                            orElse: () {
                                                          return ButtonFilled
                                                              .info(
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  height: 40,
                                                                  text: 'Bayar',
                                                                  onPressed:
                                                                      () {
                                                                    if (FlavorType
                                                                            .dev ==
                                                                        true) {
                                                                      context
                                                                          .read<
                                                                              SurveyDesignPaymentBloc>()
                                                                          .add(SurveyDesignPaymentEvent.getSurveyDesignPaymentLink(
                                                                              surveyDesignData.id));
                                                                    } else {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return AlertDialog(
                                                                              surfaceTintColor: Colors.white,
                                                                              title: Text(
                                                                                'Oops..!',
                                                                                style: TextStyles.h2(color: AppColors.primary),
                                                                              ),
                                                                              content: Text(
                                                                                'Mohon maaf, kamu belum dapat melanjutkan fitur pembuatan survey ini',
                                                                                style: TextStyles.large(color: AppColors.secondary),
                                                                              ),
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Text(
                                                                                    'Ok',
                                                                                    style: TextStyles.h4(color: AppColors.primary),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          });
                                                                    }
                                                                  });
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : surveyDesignData.created == 2
                                            ? SizedBox(
                                                width: double.infinity,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 6,
                                                      child: Container(),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: ButtonFilled.info(
                                                          height: 40,
                                                          text: 'Lanjutkan',
                                                          onPressed: () {
                                                            String modifiedUrl =
                                                                replaceAmpersAnd(
                                                                    surveyDesignData
                                                                        .createQuestionUrl);
                                                            print(
                                                                '$modifiedUrl&key=$surveyToken');
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            WebviewSurveyDesignCreateQuestion(
                                                                              title: surveyDesignData.title,
                                                                              url: '$modifiedUrl&key=$surveyToken',
                                                                            )));
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : surveyDesignData.created == 3
                                                ? Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        color: AppColors.info
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          Images.notice,
                                                          width: 40.0,
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Expanded(
                                                          flex: 7,
                                                          child: Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              'Admin sedang memeriksa survei kamu. Mohon tunggu 2x24 jam.',
                                                              style: TextStyles.regular(
                                                                  color: AppColors
                                                                      .secondary),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : surveyDesignData.created == 4
                                                    ? SizedBox(
                                                        width: double.infinity,
                                                        child: Row(
                                                          children: [
                                                            const Expanded(
                                                              flex: 7,
                                                              child: Text(
                                                                  'Survei kamu butuh perbaikan, Ketuk Edit untuk melakukan perubahan.'),
                                                            ),
                                                            const SizedBox(
                                                                width: 15),
                                                            Expanded(
                                                              flex: 3,
                                                              child: TextButtonFilled
                                                                  .info(
                                                                      height:
                                                                          40,
                                                                      text:
                                                                          'Edit',
                                                                      onPressed:
                                                                          () {
                                                                        String
                                                                            modifiedUrl =
                                                                            replaceAmpersAnd(surveyDesignData.createQuestionUrl);
                                                                        print(
                                                                            '$modifiedUrl&key=$surveyToken');
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => WebviewSurveyDesignCreateQuestion(
                                                                                      title: surveyDesignData.title,
                                                                                      url: '$modifiedUrl&key=$surveyToken',
                                                                                    )));
                                                                      }),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    : surveyDesignData
                                                                .created ==
                                                            5
                                                        ? Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 10),
                                                            width:
                                                                double.infinity,
                                                            child: Row(
                                                              children: [
                                                                Flexible(
                                                                  flex: 2,
                                                                  child: Image
                                                                      .asset(
                                                                    IconName
                                                                        .surveyCheckApproved,
                                                                    color: AppColors
                                                                        .success,
                                                                    width: 30,
                                                                    height: 30,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 15,
                                                                ),
                                                                Flexible(
                                                                  flex: 6,
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      'Survei kamu sudah tayang. ${surveyDesignData.respondentProgress} Responden terpenuhi.',
                                                                      style: TextStyles.medium(
                                                                          color:
                                                                              AppColors.secondary),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        5.0),
                                                                child: Text(
                                                                  'Survei kamu telah selesai. Silakan download laporan hasil survei di bawah ini.',
                                                                  style: TextStyles.large(
                                                                      color: AppColors
                                                                          .light),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              const Divider(),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      flex: 4,
                                                                      child:
                                                                          Container()),
                                                                  Expanded(
                                                                      flex: 4,
                                                                      child: TextButtonOutlined.info(
                                                                          height: 40,
                                                                          text: 'Format CSV',
                                                                          onPressed: () {
                                                                            print(surveyDesignData.reportLink);
                                                                            if (surveyDesignData.reportLink?.isEmpty ??
                                                                                true) {
                                                                              ToastComponent.showToast('Mohon maaf, sepertinya survey ini tidak memiliki Report CSV');
                                                                            } else {
                                                                              downloadFile(surveyDesignData.reportLink!);
                                                                            }
                                                                          }))
                                                                ],
                                                              )
                                                            ],
                                                          )
                              ],
                            ),
                          );
                        },
                      ),
                      const Padding(
                        padding: CustomPadding.pdefault,
                        // child: buildButtonSubmit('secondary'),
                      ),
                      CustomDividers.smallDivider(),
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildButtonSubmit(String mode) {
    return Container(
        child: mode == 'primary'
            ? BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return ButtonFilled.primary(
                          text: 'Buat Survei',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileComplete()));
                          });
                    },
                    loaded: (data) {
                      return ButtonFilled.primary(
                          text: 'Buat Survei',
                          onPressed: () {
                            if (data.userProfile.npwp == null &&
                                data.userProfile.npwp == null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfileComplete()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SurveyDesign(
                                            designAction: 'Create',
                                          )));
                            }
                          });
                    },
                    loading: () {
                      return const ShimmerProfileUser();
                    },
                  );
                },
              )
            : BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return state.maybeWhen(orElse: () {
                    return TextButtonOutlined.transparent(
                        borderColor: AppColors.primary,
                        textColor: AppColors.primary,
                        text: 'Buat Survei',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileComplete()));
                        });
                  }, loaded: (data) {
                    return TextButtonOutlined.transparent(
                        borderColor: AppColors.primary,
                        textColor: AppColors.primary,
                        text: 'Buat Survei',
                        onPressed: () {
                          // ignore: unnecessary_null_comparison
                          if (data.userProfile.ktp == null &&
                              data.userProfile.npwp == null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileComplete()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SurveyDesign(
                                          designAction: 'Create',
                                        )));
                          }
                        });
                  });
                },
              ));
  }

  void showModalSubmitConfirmation(BuildContext context, int surveyDesignId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          title: Container(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 25,
                )),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  padding: CustomPadding.p1,
                  child: Image.asset(
                    Images.confirmSubmitSurvey,
                    width: AppWidth.imageSize(context, AppWidth.medium),
                  )),
              CustomDividers.smallDivider(),
              Text(
                'Submit Survei',
                textAlign: TextAlign.center,
                style: TextStyles.h3(color: AppColors.secondary),
              ),
              CustomDividers.smallDivider(),
              Text(
                'Dengan mengetuk tombol “Submit”, maka survei kamu akan dikirimkan ke Admin untuk diperiksa.',
                textAlign: TextAlign.center,
                style: TextStyles.large(),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: CustomPadding.p1,
              child: Row(
                children: [
                  Expanded(
                    child: TextButtonOutlined.primary(
                        height: 45,
                        text: 'Cek Lagi',
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: BlocListener<SurveyDesignSubmitBloc,
                          SurveyDesignSubmitState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        loaded: (data) {
                          if (data == "Success") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SurveyDesignListPage()));
                          }
                        },
                        error: (message) {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    surfaceTintColor: AppColors.white,
                                    title: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Oops...!',
                                          style: TextStyles.h3(
                                              color: AppColors.primary),
                                        )),
                                    content: Text(
                                      message,
                                      textAlign: TextAlign.center,
                                      style: TextStyles.h5(
                                          color: AppColors.secondary),
                                    ),
                                    actions: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Ok',
                                            style: TextStyles.regular(
                                                color: AppColors.primary),
                                          ))
                                    ]);
                              });
                        },
                      );
                    },
                    child: BlocBuilder<SurveyDesignSubmitBloc,
                        SurveyDesignSubmitState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return ButtonFilled.primary(
                              height: 45,
                              text: 'Submit',
                              onPressed: () {
                                context.read<SurveyDesignSubmitBloc>().add(
                                    SurveyDesignSubmitEvent.submitSurveyDesign(
                                        surveyDesignId));
                              },
                            );
                          },
                          loading: () {
                            return ButtonFilled.primary(
                              height: 45,
                              text: '',
                              textColor: AppColors.white,
                              onPressed: () {},
                              loading: true,
                            );
                          },
                        );
                      },
                    ),
                  )),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
