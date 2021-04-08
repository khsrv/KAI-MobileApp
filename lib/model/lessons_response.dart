import 'package:kai_mobile_app/model/lesson_model.dart';

class LessonsResponse {
  final List<LessonModel> lessons;
  final String error;

  LessonsResponse(this.lessons, this.error);

  LessonsResponse.fromJson(Map<String, dynamic> json)
      : lessons = (json["Data"] as List)
            .map((i) => new LessonModel.fromJson(i))
            .toList(),
        error = "";

  LessonsResponse.withError(String errorValue)
      : lessons = List(),
        error = errorValue;
}
