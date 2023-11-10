import '../../../models/survey_design/report_time.dart';

class ListReportTime {
  static List<ReportTimeModel> getReportTimeList() {
    return [
      ReportTimeModel(id: 1, scope: "10", price: 0),
      ReportTimeModel(id: 2, scope: "7", price: 20000),
      ReportTimeModel(id: 3, scope: "5", price: 40000),
      ReportTimeModel(id: 4, scope: "3", price: 75000),
      ReportTimeModel(id: 5, scope: "1", price: 150000)
    ];
  }
}
