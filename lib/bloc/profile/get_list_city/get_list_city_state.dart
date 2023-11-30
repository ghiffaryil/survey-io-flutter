part of 'get_list_city_bloc.dart';

@freezed
class GetListCityState with _$GetListCityState {
  const factory GetListCityState.initial() = _Initial;
  const factory GetListCityState.loading() = _Loading;
  const factory GetListCityState.loaded(List<DataCity> data) =
      _Loaded;
  const factory GetListCityState.error(String message) = _Error;
}
