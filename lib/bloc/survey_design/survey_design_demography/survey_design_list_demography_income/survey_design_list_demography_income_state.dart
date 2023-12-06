part of 'survey_design_list_demography_income_bloc.dart';

@freezed
class SurveyDesignListDemographyIncomeState with _$SurveyDesignListDemographyIncomeState {
  const factory SurveyDesignListDemographyIncomeState.initial() = _Initial;
  const factory SurveyDesignListDemographyIncomeState.loading() = _Loading;
  const factory SurveyDesignListDemographyIncomeState.loaded(List<ListDemographyIncome> data) = _Loaded;
  const factory SurveyDesignListDemographyIncomeState.error(String message) = _Error;
}
