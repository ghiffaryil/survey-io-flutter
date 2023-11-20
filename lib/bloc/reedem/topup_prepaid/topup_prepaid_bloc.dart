import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/reedem/topup_prepaid_datasource.dart';
import 'package:survey_io/models/reedem/topup_prepaid_response_model.dart';

part 'topup_prepaid_event.dart';
part 'topup_prepaid_state.dart';
part 'topup_prepaid_bloc.freezed.dart';

class TopupPrepaidBloc extends Bloc<TopupPrepaidEvent, TopupPrepaidState> {
  TopupPrepaidBloc() : super(const _Initial()) {
    on<_SetTopUpPrepaid>((event, emit) async {
      emit(const _Loading());
      final response =
          await TopUpPrepaidDatasource().setTopUpPrepaid(event.productCode);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
