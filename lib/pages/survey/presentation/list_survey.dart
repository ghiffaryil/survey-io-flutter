import 'package:flutter/material.dart';

// Import Component
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/common/components/image_rounded.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';

import '../../../common/components/appbar_plain.dart';
import '../../../common/constants/icons.dart';

class ListSurveiPage extends StatefulWidget {
  const ListSurveiPage({super.key});

  @override
  State<ListSurveiPage> createState() => _ListSurveiPageState();
}

class _ListSurveiPageState extends State<ListSurveiPage> {
  List<Map<String, dynamic>> listDataSurvey = [
    {
      "judulSurvei": "Digital Payment Survey",
      "jumlahPertanyaanSurvei": "20",
      "hadiahSurvei": "500",
      "image":
          "https://nunganjuk.or.id/wp-content/uploads/2021/09/5ddf45a34ee64.jpg",
    },
    {
      "judulSurvei": "FMCG Survey",
      "jumlahPertanyaanSurvei": "34",
      "hadiahSurvei": "750",
      "image":
          "https://www.bizhare.id/media/wp-content/uploads/2023/05/Thumbnail_Artikel-Media_15-Perusahaan-FMCG-Terbesar-di-Indonesia.jpg",
    },
    {
      "judulSurvei": "Teeth Aligner Survey",
      "jumlahPertanyaanSurvei": "50",
      "hadiahSurvei": "1500",
      "image":
          "https://i0.wp.com/post.healthline.com/wp-content/uploads/2021/01/Woman-Holding-Invisalign-1296x728-header.jpg?w=1155&h=1528",
    },
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
        height: 70.0,
        leadingIcon: Icons.arrow_back_ios,
        iconSize: 35.0,
        textColor: AppColors.secondary,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: PaddingHorizontalOnly.px2,
          child: Column(
            children: [
              LabelInput(
                  labelText: 'Survei',
                  labelStyle:
                      TextStyles.h2ExtraBold(color: AppColors.secondary)),
              CustomDividers.verySmallDivider(),
              sectionListSurvey(),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionListSurvey() {
    return ListView.separated(
      shrinkWrap:
          true, // Important to allow the ListView to scroll inside SingleChildScrollView
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listDataSurvey.length,
      itemBuilder: (BuildContext context, int index) {
        final survey = listDataSurvey[index];
        final judulSurvei = survey['judulSurvei'];
        final jumlahPertanyaanSurvei = survey['jumlahPertanyaanSurvei'];
        final hadiahSurvei = survey['hadiahSurvei'];
        final imageUrlSurvei = survey['image'];

        return Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: RoundedImage(
                  imageType: 'network',
                  imageUrl: imageUrlSurvei,
                  borderRadius: 8.0,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDividers.verySmallDivider(),
                    Text(
                      judulSurvei,
                      style: TextStyles.h5(color: AppColors.secondary),
                    ),
                    const SizedBox(height: 5),
                    Text('$jumlahPertanyaanSurvei Pertanyaan'),
                    CustomDividers.smallDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              IconName.point,
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '$hadiahSurvei',
                              style: TextStyles.large(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondary),
                            ),
                          ],
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        const Icon(
                          Icons.share,
                          size: 20,
                          color: AppColors.info,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: TextButtonFilled.primary(
                              minWidth: 0.20,
                              height: 30,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              text: 'Ikut Survei',
                              onPressed: () {}),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(); // Replace Divider() with your custom separator widget if needed.
      },
    );
  }
}
