class PollingResultModel {
  final int pollingId;
  final String pollingTitle;
  final int optionNumber;
  final List arrayOption;
  final String voter;
  final List arrayVotersPercent;
  final List arrayVoterCount;
  final List arrayPollingColor;
  final String chartMode;

  PollingResultModel({
    required this.pollingId,
    required this.pollingTitle,
    required this.optionNumber,
    required this.arrayOption,
    required this.voter,
    required this.arrayVotersPercent,
    required this.arrayVoterCount,
    required this.arrayPollingColor,
    required this.chartMode,
  });
}
