part of 'survey_design_list_bloc.dart';

@freezed
class SurveyDesignListState with _$SurveyDesignListState {
  const factory SurveyDesignListState.initial() = _Initial;
  const factory SurveyDesignListState.loading() = _Loading;
  const factory SurveyDesignListState.loaded(List<SurveyDesignList> data) =
      _Loaded;
  const factory SurveyDesignListState.error(String message) = _Error;
}
