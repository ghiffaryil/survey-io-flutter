import 'package:survey_io/models/survey_design/data/demography_religion_model.dart';

class ListDemographyReligion {
  static List<DemographyReligionModel> getDemographyReligionList() {
    return [
      DemographyReligionModel(id: 1, scope: "Islam", price: 50000),
      DemographyReligionModel(id: 2, scope: "Katolik", price: 150000),
      DemographyReligionModel(id: 3, scope: "Protestan", price: 150000),
      DemographyReligionModel(id: 4, scope: "Hindu", price: 200000),
      DemographyReligionModel(id: 5, scope: "Buddha", price: 200000),
      DemographyReligionModel(id: 6, scope: "Konghucu", price: 250000)
    ];
  }
}
