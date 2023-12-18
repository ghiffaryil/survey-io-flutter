String getFirstValue(String inputString) {
  List<String> values = inputString.split('-');
  values = values.map((value) => value.trim()).toList();
  return values.isNotEmpty ? values.first : "";
}

String getLastValue(String inputString) {
  List<String> values = inputString.split('-');
  values = values.map((value) => value.trim()).toList();
  return values.isNotEmpty ? values.last : "";
}
