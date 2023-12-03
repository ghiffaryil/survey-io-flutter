import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/profile/get_list_province_datasource.dart';
import 'package:survey_io/models/user/list_province_response_model.dart';

part 'get_list_province_event.dart';
part 'get_list_province_state.dart';
part 'get_list_province_bloc.freezed.dart';

class GetListProvinceBloc extends Bloc<GetListProvinceEvent, GetListProvinceState> {
  GetListProvinceBloc() : super(const _Initial()) {
   on<_GetListProvince>((event, emit) async {
      emit(const _Loading());
      final response = await GetListProvinceDatasource().getProvinceList();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
