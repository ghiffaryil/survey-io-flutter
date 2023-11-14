import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/profile/edit_profile_datasource.dart';
import 'package:survey_io/models/user/edit_profile_request_model.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';
part 'edit_profile_bloc.freezed.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(const _Initial()) {
    on<_EditProfile>((event, emit) async {
      emit(const _Loading());
      final response = await EditProfileDatasource().update(event.requestModel);
      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
