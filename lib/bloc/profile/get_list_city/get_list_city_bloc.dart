import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/profile/get_list_city_datasource.dart';
import 'package:survey_io/models/user/list_city_response_model.dart';

part 'get_list_city_event.dart';
part 'get_list_city_state.dart';
part 'get_list_city_bloc.freezed.dart';

class GetListCityBloc extends Bloc<GetListCityEvent, GetListCityState> {
  GetListCityBloc() : super(const _Initial()) {
    on<_GetListCity>((event, emit) async {
      emit(const _Loading());
      final response = await GetListCityDatasource().getCityList(event.provinceId);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
