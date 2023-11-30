part of 'get_list_province_bloc.dart';

@freezed
class GetListProvinceEvent with _$GetListProvinceEvent {
  const factory GetListProvinceEvent.started() = _Started;
  const factory GetListProvinceEvent.getListProvince() = _GetListProvince;
}