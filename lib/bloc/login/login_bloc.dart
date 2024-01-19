import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/login/auth_save_local_datasource.dart';
import 'package:survey_io/models/auth/auth_request_model.dart';
import '../../datasources/login/auth_login_datasource.dart';
import '../../models/auth/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());
      final response = await AuthRemoteDatasource().login(event.requestModel);
      response.fold(
        (error) => emit(_Error(error)),
        (data) {
          AuthLocalDatasource().saveAuthData(data);
          emit(_Loaded(data));
        },
      );
    });
  }
}
