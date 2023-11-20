part of 'topup_prepaid_bloc.dart';

@freezed
class TopupPrepaidState with _$TopupPrepaidState {
  const factory TopupPrepaidState.initial() = _Initial;
  const factory TopupPrepaidState.loading() = _Loading;
  const factory TopupPrepaidState.loaded(TopUpPrepaidResponseModel data) =
      _Loaded;
  const factory TopupPrepaidState.error(String message) = _Error;
}
