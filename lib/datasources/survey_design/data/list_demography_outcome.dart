import 'package:survey_io/models/survey_design/data/demography_outcome_model.dart';

class ListDemographyOutcome {
  static List<DemographyOutcomeModel> getDemographyOutcomeList() {
    return [
      DemographyOutcomeModel(id: 1, scope: "<1.000.000"),
      DemographyOutcomeModel(id: 2, scope: "1.000.000 - 5.000.000"),
      DemographyOutcomeModel(id: 3, scope: "5.000.000 - 10.000.000"),
      DemographyOutcomeModel(id: 4, scope: ">10.000.000")
    ];
  }
}
