import '../models/demography_gender_model.dart';

class ListDemographyGender {
  static List<DemographyGenderModel> getDemographyGenderList() {
    return [
      DemographyGenderModel(id: 1, scope: "Laki-laki"),
      DemographyGenderModel(id: 2, scope: "Perempuan"),
      DemographyGenderModel(id: 3, scope: "Netral"),
      DemographyGenderModel(id: 4, scope: "Semua")
    ];
  }
}
