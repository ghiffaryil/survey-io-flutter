import '../../models/polling/polling_completed.dart';

class ListPollingCompleted {
  static List<PollingCompletedModel> getCompletedPolling() {
    return [
      PollingCompletedModel(
        pollingId: 1,
        pollingTitle: "Survei.io is easy to use",
        optionNumber: 2,
        direction: "Horizontal",
        arrayOption: ["Agree", "Disagree"],
        yourChoice: "Agree",
        arrayVotersPercent: ["20", "10"],
      ),
      PollingCompletedModel(
        pollingId: 2,
        pollingTitle: "How satisfied are you with Survei.io?",
        optionNumber: 3,
        direction: "Vertical",
        arrayOption: ["Satisfied", "Normal", "Disatisfied"],
        yourChoice: "Satisfied",
        arrayVotersPercent: ["70", "20", "10"],
      ),
      PollingCompletedModel(
        pollingId: 3,
        pollingTitle: "Apakah Profesi Anda?",
        optionNumber: 2,
        direction: "Horizontal",
        arrayOption: ["Pegawai", "Pengusaha"],
        yourChoice: "Pengusaha",
        arrayVotersPercent: ["10", "20"],
      ),
    ];
  }
}
