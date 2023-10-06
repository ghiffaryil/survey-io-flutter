class PollingCompletedModel {
  final int pollingId;
  final String pollingTitle;
  final String direction;
  final int optionNumber;
  final List arrayOption;
  final String yourChoice;
  final List arrayVotersPercent;

  PollingCompletedModel({
    required this.pollingId,
    required this.pollingTitle,
    required this.direction,
    required this.optionNumber,
    required this.arrayOption,
    required this.yourChoice,
    required this.arrayVotersPercent,
  });
}
