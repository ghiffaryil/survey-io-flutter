import '../../models/polling/polling_model.dart';

class ListNewPolling {
  static List<PollingModel> getNewPolling() {
    return [
      PollingModel(
        pollingId: 1,
        pollingTitle: "Survei.io is easy to use",
        direction: "Horizontal",
        optionNumber: 2,
        arrayOption: ["Agree", "Disagree"],
      ),
      PollingModel(
        pollingId: 2,
        pollingTitle: "How satisfied are you with Survei.io?",
        direction: "Vertical",
        optionNumber: 3,
        arrayOption: ["Satisfied", "Normal", "Disatisfied"],
      ),
      PollingModel(
        pollingId: 3,
        pollingTitle: "Favorite Color Poll",
        direction: "Horizontal",
        optionNumber: 4,
        arrayOption: ["Red", "Blue", "Green", "Yellow"],
      ),
      PollingModel(
        pollingId: 4,
        pollingTitle: "Coffee vs. Tea",
        direction: "Vertical",
        optionNumber: 2,
        arrayOption: ["Coffee", "Tea"],
      ),
      PollingModel(
        pollingId: 5,
        pollingTitle: "Best Smartphone Brand",
        direction: "Horizontal",
        optionNumber: 5,
        arrayOption: ["Apple", "Samsung"],
      ),
    ];
  }
}
