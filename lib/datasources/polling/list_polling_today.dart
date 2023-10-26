import '../../models/polling/polling_model.dart';

class ListPollingToday {
  static List<PollingModel> getPollingToday() {
    return [
      PollingModel(
        pollingId: 1,
        pollingTitle:
            "Apakah kamu sudah mendengar tentang virus Covid-19 Varian Omicron?",
        direction: "Horizontal",
        optionNumber: 2,
        arrayOption: ["Pernah", "Tidak"],
      ),
      PollingModel(
        pollingId: 2,
        pollingTitle: "How satisfied are you with Survei.io?",
        direction: "Vertical",
        optionNumber: 3,
        arrayOption: ["Satisfied", "Normal", "Disatisfied"],
      ),
    ];
  }
}
