import '../models/demography_age_model.dart';

class ListDemographyAge {
  static List<DemographyAgeModel> getDemographyAgeList() {
    return [
      DemographyAgeModel(
        id: 1,
        scope: "<20",
      ),
      DemographyAgeModel(
        id: 2,
        scope: "21-30",
      ),
      DemographyAgeModel(
        id: 3,
        scope: "31-40",
      ),
      DemographyAgeModel(
        id: 4,
        scope: "41-50",
      )
    ];
  }
}
