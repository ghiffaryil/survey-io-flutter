part of 'get_list_city_bloc.dart';

@freezed
class GetListCityEvent with _$GetListCityEvent {
  const factory GetListCityEvent.started() = _Started;
  const factory GetListCityEvent.getListCity(int provinceId) = _GetListCity;
}