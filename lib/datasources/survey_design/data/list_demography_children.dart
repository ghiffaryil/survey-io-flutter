import '../../../models/survey_design/demography_children_model.dart';

class ListDemographyChildren {
  static List<DemographyChildrenModel> getDemographyChildrenList() {
    return [
      DemographyChildrenModel(id: 1, scope: "0"),
      DemographyChildrenModel(id: 2, scope: "1"),
      DemographyChildrenModel(id: 3, scope: "2"),
      DemographyChildrenModel(id: 4, scope: ">2")
    ];
  }
}
