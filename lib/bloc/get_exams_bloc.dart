import 'package:kai_mobile_app/model/exams_response.dart';
import 'package:kai_mobile_app/repository/kai_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetExamsBloc {
  final KaiRepository _repository = KaiRepository();
  final BehaviorSubject<ExamsResponse> _subject =
  BehaviorSubject<ExamsResponse>();

  getExams() async {
    ExamsResponse response = await _repository.getExams();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ExamsResponse> get subject => _subject;

}
final getExamsBloc = GetExamsBloc();