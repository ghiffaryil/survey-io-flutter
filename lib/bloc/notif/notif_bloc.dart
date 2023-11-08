import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/notification/list_notification_datasource.dart';

import '../../../models/notification/notification_response_model.dart';

part 'notif_event.dart';
part 'notif_state.dart';
part 'notif_bloc.freezed.dart';

class NotifBloc extends Bloc<NotifEvent, NotifState> {
  NotifBloc() : super(const _Initial()) {
    on<_GetNotif>((event, emit) async {
      emit(const _Loading());
      final response = await NotificationDatasource().getListNotification();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
