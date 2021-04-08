import 'lesson_brs_model.dart';

class LessonsBRSResponse {
  final List<LessonBRSModel> lessonsBRS;
  final String error;

  LessonsBRSResponse(this.lessonsBRS, this.error);

  LessonsBRSResponse.fromJson(Map<String, dynamic> json)
      : lessonsBRS = (json["Data"] as List)
            .map((i) => new LessonBRSModel.fromJson(i))
            .toList(),
        error = "";

  LessonsBRSResponse.withError(String errorValue)
      : lessonsBRS = List(),
        error = errorValue;
}

class LessonsBRSResponseLoading extends LessonsBRSResponse {
  LessonsBRSResponseLoading() : super.withError("Загрузка");
}

class LessonsBRSResponseOk extends LessonsBRSResponse {
  LessonsBRSResponseOk(Map<String, dynamic> json) : super.fromJson(json);
}

class LessonsBRSResponseWithErrors extends LessonsBRSResponse {
  LessonsBRSResponseWithErrors(String err) : super.withError(err);
}

//////////////////////////
class LessonsBRSResponsesList {
  List<LessonsBRSResponse> lessonsBRSResponsesList;
  String error;
  LessonsBRSResponsesList(this.lessonsBRSResponsesList) : error = "";

  add(Map<String, dynamic> json) {
    lessonsBRSResponsesList.addAll((json["Data"] as List)
        .map((i) => new LessonsBRSResponse.fromJson(i))
        .toList());
    error = "";
  }

  LessonsBRSResponsesList.withError(this.error)
      : lessonsBRSResponsesList = null;

  LessonsBRSResponsesList.loading()
      : lessonsBRSResponsesList = null,
        error = "";
}

class LessonsBRSResponsesListOK extends LessonsBRSResponsesList {
  LessonsBRSResponsesListOK(List<LessonsBRSResponse> lessonsBRSResponsesList)
      : super(lessonsBRSResponsesList);
}

class LessonsBRSResponsesListLoading extends LessonsBRSResponsesList {
  LessonsBRSResponsesListLoading() : super.loading();
}

class LessonsBRSResponsesListWithErrors extends LessonsBRSResponsesList {
  LessonsBRSResponsesListWithErrors(String error) : super.withError(error);
}
