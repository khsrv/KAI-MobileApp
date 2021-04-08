import 'package:kai_mobile_app/model/semester_response.dart';
import 'package:kai_mobile_app/repository/kai_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetSemestrBloc {
  final KaiRepository _repository = KaiRepository();
  final BehaviorSubject<SemesterResponse> _subject =
  BehaviorSubject<SemesterResponse>();

  getSemestr() async {
    SemesterResponse response = await _repository.getSemestr();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<SemesterResponse> get subject => _subject;

}
final getSemestrBloc = GetSemestrBloc();