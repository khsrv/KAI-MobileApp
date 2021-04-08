import 'package:kai_mobile_app/model/lesson_brs_response.dart';
import 'package:kai_mobile_app/repository/kai_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetBRSLessonBloc {
  final KaiRepository repository = KaiRepository();
  final BehaviorSubject<LessonsBRSResponsesList> _subject =
      BehaviorSubject<LessonsBRSResponsesList>();

  getBrsLessons(int semesterNum) async {
    _subject.sink.add(LessonsBRSResponsesListLoading());
    List<LessonsBRSResponse> response = List();
    LessonsBRSResponse lResponse;
    bool _hasErrors;
    for (int i = 1; i <= semesterNum; i++) {
      lResponse = await repository.getLessonsBRS(i);
      response.add(lResponse);
      if (lResponse is LessonsBRSResponseOk) {
        _hasErrors = false;
      } else if (lResponse is LessonsBRSResponseWithErrors) {
        _hasErrors = true;
      }
    }
    if (_hasErrors) {
      _subject.sink.add(LessonsBRSResponsesListWithErrors("Ошибка"));
    } else {
      _subject.sink.add(LessonsBRSResponsesListOK(response));
    }
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<LessonsBRSResponsesList> get subject => _subject;
}

final getBRSLessonsBloc = GetBRSLessonBloc();
