part of 'survey_design_payment_bloc.dart';

@freezed
class SurveyDesignPaymentEvent with _$SurveyDesignPaymentEvent {
  const factory SurveyDesignPaymentEvent.started() = _Started;
  const factory SurveyDesignPaymentEvent.getSurveyDesignPaymentLink(int surveyDesignId) = _GetSurveyDesignPaymentLink;
}