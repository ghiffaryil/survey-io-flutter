import 'package:survey_io/models/survey_design/data/scope_model.dart';

class ListScope {
  static List<ScopeModel> getScopeList() {
    return [
      ScopeModel(id: 1, scope: "Publik"),
      ScopeModel(id: 2, scope: "Market"),
      ScopeModel(id: 3, scope: "Personal")
    ];
  }
}
