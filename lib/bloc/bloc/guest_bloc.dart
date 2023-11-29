import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';
import 'package:survey_io/datasources/guest/auth_token_guest_datasource.dart';
import 'package:survey_io/models/auth/auth_guest_response_model.dart';

part 'guest_event.dart';
part 'guest_state.dart';
part 'guest_bloc.freezed.dart';

class GuestBloc extends Bloc<GuestEvent, GuestState> {
  GuestBloc() : super(const _Initial()) {
    on<_GetGuestToken>((event, emit) async {
      emit(const _Loading());
      final response = await AuthRemoteGuestDatasource().getToken();
      response.fold(
        (error) => emit(_Error(error)),
        (data) {
          AuthLocalGuestDatasource().saveAuthDataLocalGuest(data);
          emit(_Loaded(data));
        },
      );
    });
  }
}
