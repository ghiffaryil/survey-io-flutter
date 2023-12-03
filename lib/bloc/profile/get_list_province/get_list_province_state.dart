part of 'get_list_province_bloc.dart';

@freezed
class GetListProvinceState with _$GetListProvinceState {
  const factory GetListProvinceState.initial() = _Initial;
  const factory GetListProvinceState.loading() = _Loading;
  const factory GetListProvinceState.loaded(List<DataProvince> data) = _Loaded;
  const factory GetListProvinceState.error(String message) = _Error;
}
