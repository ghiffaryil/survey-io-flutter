import 'package:survey_io/models/survey_design/data/respondent_model.dart';

class ListRespondent {
  static List<RespondentModel> getRespondentList() {
    return [
      RespondentModel(id: 1, scope: 50),
      RespondentModel(id: 2, scope: 100),
      RespondentModel(id: 3, scope: 200),
      RespondentModel(id: 4, scope: 300),
      RespondentModel(id: 5, scope: 400),
      RespondentModel(id: 6, scope: 500),
      RespondentModel(id: 7, scope: 700),
      RespondentModel(id: 8, scope: 1000)
    ];
  }
}
