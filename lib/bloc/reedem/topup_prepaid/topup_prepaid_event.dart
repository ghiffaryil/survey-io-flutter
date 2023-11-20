part of 'topup_prepaid_bloc.dart';

@freezed
class TopupPrepaidEvent with _$TopupPrepaidEvent {
  const factory TopupPrepaidEvent.started() = _Started;
  const factory TopupPrepaidEvent.setTopUpPrepaid(String productCode) =
      _SetTopUpPrepaid;
}
