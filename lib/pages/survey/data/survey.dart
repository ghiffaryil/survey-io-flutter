import 'package:survey_io/pages/survey/models/survey_model.dart';

class ListSurvey {
  static List<SurveyModel> getSurvey() {
    return [
      SurveyModel(
          id: 1,
          title: "Digital Payment Survey",
          questions: "20",
          reward: "500",
          image:
              "https://nunganjuk.or.id/wp-content/uploads/2021/09/5ddf45a34ee64.jpg"),
      SurveyModel(
          id: 2,
          title: "FMCG Survey",
          questions: "34",
          reward: "750",
          image:
              "https://www.bizhare.id/media/wp-content/uploads/2023/05/Thumbnail_Artikel-Media_15-Perusahaan-FMCG-Terbesar-di-Indonesia.jpg"),
      SurveyModel(
        id: 3,
        title: "Teeth Aligner Survey",
        questions: "50",
        reward: "1500",
        image:
            "https://i0.wp.com/post.healthline.com/wp-content/uploads/2021/01/Woman-Holding-Invisalign-1296x728-header.jpg?w=1155&h=1528",
      ),
    ];
  }
}
