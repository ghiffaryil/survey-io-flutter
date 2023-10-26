import '../../models/survey_design/demography_income_model.dart';

class ListDemographyIncome {
  static List<DemographyIncomeModel> getDemographyIncomeList() {
    return [
      DemographyIncomeModel(id: 1, scope: "<1.000.000"),
      DemographyIncomeModel(id: 2, scope: "1.000.000 - 5.000.000"),
      DemographyIncomeModel(id: 3, scope: "5.000.000 - 10.000.000"),
      DemographyIncomeModel(id: 4, scope: ">10.000.000")
    ];
  }
}
