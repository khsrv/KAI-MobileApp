

import 'package:kai_mobile_app/model/exam_model.dart';


class ExamsResponse {
  final List<ExamModel> exams;
  final String error;

  ExamsResponse(this.exams, this.error);

  ExamsResponse.fromJson(Map<String, dynamic> json)
      : exams =
  (json["Data"] as List).map((i) => new ExamModel.fromJson(i)).toList(),
        error = "";

  ExamsResponse.withError(String errorValue)
      : exams = List(),
        error = errorValue;
}