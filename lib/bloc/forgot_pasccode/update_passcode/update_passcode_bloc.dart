import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/forgot_passcode/update_passcode.dart';

part 'update_passcode_event.dart';
part 'update_passcode_state.dart';
part 'update_passcode_bloc.freezed.dart';

class UpdatePasscodeBloc
    extends Bloc<UpdatePasscodeEvent, UpdatePasscodeState> {
  UpdatePasscodeBloc() : super(const _Initial()) {
    on<_UpdatePasscode>((event, emit) async {
      emit(const _Loading());
      final response = await UpdatePasscodeOtpDatasource()
          .update(event.phoneNumber, event.pin);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
