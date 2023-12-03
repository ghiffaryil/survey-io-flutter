import 'package:survey_io/models/survey/data/survey_model.dart';

// GET DATA FROM API
class ListSurveyPopular {
  static List<SurveyModelData> getSurveyPopular() {
    return [
      SurveyModelData(allowed: true, total_question: 16, listSurvey: [
        SurveyModelList(
          id: 27,
          title: "Survey 2022",
          audience_id: 1,
          user_id: 0,
          survey_design_id: 0,
          description: "<p>Haloo 1</p>",
          image_content: "",
          image_homescreen: "",
          point: 100,
          survey_link: "link.survey",
          action_limit: "once",
          type: "recommended",
          source: "admin",
          energy: 20,
          prods: 0,
          slug: "svyMjc=",
          report_link: null,
          pdf_link: null,
          datetime_start: "2021-12-27T18:20:24+07:00",
          datetime_end: "2021-12-28T12:07:24+07:00",
          datetime_created: "2021-11-23T10:53:54+07:00",
          datetime_updated: "2022-08-16T19:25:42+07:00",
          survey_question: null,
        )
      ]),
      SurveyModelData(allowed: true, total_question: 16, listSurvey: [
        SurveyModelList(
          id: 13,
          title: "A Test Survey 3",
          audience_id: 1,
          user_id: 0,
          survey_design_id: 0,
          description:
              "<p>Mari kita coba membuat test survey 3 dengan description</p>",
          image_content:
              "https://surveyio-assets.sgp1.cdn.digitaloceanspaces.com/survey/test.png",
          image_homescreen:
              "https://surveyio-assets.sgp1.cdn.digitaloceanspaces.com/survey/test.png",
          point: 100,
          survey_link: "https://www.alchemer.com/",
          action_limit: "once",
          type: "recommended",
          source: "admin",
          energy: 15,
          prods: 0,
          slug: "svyMTM=",
          report_link: null,
          pdf_link: null,
          datetime_start: "2021-11-30T12:10:00+07:00",
          datetime_end: "2021-12-31T18:00:00+07:00",
          datetime_created: "2021-11-18T15:45:04+07:00",
          datetime_updated: "2022-08-16T15:40:20+07:00",
          survey_question: null,
        )
      ]),
      SurveyModelData(allowed: true, total_question: 16, listSurvey: [
        SurveyModelList(
          id: 31,
          title: "Test Survey",
          audience_id: 1,
          user_id: 0,
          survey_design_id: 0,
          description:
              "<p>Mari kita coba membuat test survey dengan description</p>",
          image_content:
              "https://surveyio-assets.sgp1.cdn.digitaloceanspaces.com/survey/test.png",
          image_homescreen:
              "https://surveyio-assets.sgp1.cdn.digitaloceanspaces.com/survey/test.png",
          point: 100,
          survey_link: "https://www.alchemer.com/",
          action_limit: "once",
          type: "recommended",
          source: "admin",
          energy: 10,
          prods: 0,
          slug: "svyMzE=",
          report_link: null,
          pdf_link: null,
          datetime_start: "2021-12-29T17:00:00+07:00",
          datetime_end: "2021-12-31T17:00:00+07:00",
          datetime_created: "2021-12-24T14:34:39+07:00",
          datetime_updated: "2021-12-29T15:04:25+07:00",
          survey_question: null,
        )
      ]),
    ];
  }
}
