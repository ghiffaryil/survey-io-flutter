import '../../models/survey_design/question_model.dart';

class ListQuestion {
  static List<QuestionModel> getQuestionList() {
    return [
      QuestionModel(id: 1, scope: 5),
      QuestionModel(id: 2, scope: 10),
      QuestionModel(id: 3, scope: 20),
      QuestionModel(id: 4, scope: 30),
    ];
  }
}
