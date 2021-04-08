
import 'package:kai_mobile_app/model/group_mate_respose.dart';
import 'package:kai_mobile_app/repository/kai_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetGroupMateBloc{
  final KaiRepository repository = KaiRepository();
  final BehaviorSubject<GroupMateResponse> _subject = BehaviorSubject<GroupMateResponse>();

  getGroup() async{
    GroupMateResponse response = await repository.getGroup();

    _subject.sink.add(response);
  }
  dispose() {
    _subject.close();
  }

  BehaviorSubject<GroupMateResponse> get subject => _subject;

}
final getGroupMateBloc = GetGroupMateBloc();