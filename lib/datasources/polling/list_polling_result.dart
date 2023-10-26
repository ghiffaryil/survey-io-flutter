import '../../models/polling/polling_result.dart';

class ListPollingResult {
  static List<PollingResultModel> getPollingResult() {
    return [
      PollingResultModel(
        pollingId: 1,
        pollingTitle: "Survei.io is easy to use",
        arrayOption: ["Agree", "Disagree"],
        voter: "4.000",
        optionNumber: 2,
        arrayVotersPercent: ["80", "20"],
        arrayVoterCount: ["3200", "800"],
        arrayPollingColor: ["blue", "red"],
        chartMode: "pie",
      ),
      PollingResultModel(
        pollingId: 2,
        pollingTitle: "How satisfied are you with Survei.io?",
        arrayOption: ["Satisfied", "Normal", "Disatisfied"],
        voter: "2.000",
        optionNumber: 3,
        arrayVotersPercent: ["35", "15", "50"],
        arrayVoterCount: ["700", "300", "1000"],
        arrayPollingColor: ["blue", "green", "red"],
        chartMode: "bar",
      ),
      PollingResultModel(
        pollingId: 3,
        pollingTitle: "Apakah Profesi Anda?",
        optionNumber: 2,
        arrayOption: ["Pegawai", "Pengusaha"],
        voter: "1.212",
        arrayVotersPercent: ["75", "25"],
        arrayVoterCount: ["812", "400"],
        arrayPollingColor: ["blue", "red"],
        chartMode: "pie",
      ),
    ];
  }
}
