import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/payment/survey_design_payment_link_datasource.dart';
import 'package:survey_io/models/survey_design/payment/survey_payment_link_response_model.dart';

part 'survey_design_payment_event.dart';
part 'survey_design_payment_state.dart';
part 'survey_design_payment_bloc.freezed.dart';

class SurveyDesignPaymentBloc
    extends Bloc<SurveyDesignPaymentEvent, SurveyDesignPaymentState> {
  SurveyDesignPaymentBloc() : super(const _Initial()) {
    on<_GetSurveyDesignPaymentLink>((event, emit) async {
      emit(const _Loading());
      final response = await SurveyDesignPaymentLinkDatasource()
          .getSurveyDesignPaymentLink(event.surveyDesignId);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
