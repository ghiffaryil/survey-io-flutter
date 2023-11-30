part of 'survey_design_payment_bloc.dart';

@freezed
class SurveyDesignPaymentState with _$SurveyDesignPaymentState {
  const factory SurveyDesignPaymentState.initial() = _Initial;
  const factory SurveyDesignPaymentState.loading() = _Loading;
  const factory SurveyDesignPaymentState.loaded(Data data) = _Loaded;
  const factory SurveyDesignPaymentState.error(String message) = _Error;
}
