import '../../../models/survey_design/demography_region_model.dart';

class ListDemographyRegion {
  static List<DemographyRegionModel> getDemographyRegionList() {
    return [
      DemographyRegionModel(id: 1, scope: "Sumatera", price: 75000),
      DemographyRegionModel(id: 2, scope: "Jawa", price: 20000),
      DemographyRegionModel(
          id: 3, scope: "Kepulauan Nusa Tenggara", price: 300000),
      DemographyRegionModel(id: 4, scope: "Kalimantan", price: 1000000),
      DemographyRegionModel(id: 5, scope: "Sulawesi", price: 1000000),
      DemographyRegionModel(id: 6, scope: "maluku", price: 1000000),
      DemographyRegionModel(id: 7, scope: "Papua", price: 1000000)
    ];
  }
}
