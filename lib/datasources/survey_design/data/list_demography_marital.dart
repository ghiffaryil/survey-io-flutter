import 'package:survey_io/models/survey_design/data/demography_marital_model.dart';

class ListDemographyMarital {
  static List<DemographyMaritalModel> getDemographyMaritalList() {
    return [
      DemographyMaritalModel(id: 1, scope: "Belum Kawin"),
      DemographyMaritalModel(id: 2, scope: "Kawin"),
      DemographyMaritalModel(id: 3, scope: "Cerai")
    ];
  }
}
