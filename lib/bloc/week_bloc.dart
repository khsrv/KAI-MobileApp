import 'dart:async';

import 'package:kai_mobile_app/repository/mobile_repository.dart';
import 'package:rxdart/rxdart.dart';

enum WeekItem { EVEN, UNEVEN }

class WeekBloc {
  final MobileRepository _repository = MobileRepository();
  final BehaviorSubject<WeekItem> _weekController = BehaviorSubject<WeekItem>();

  WeekItem currWeek = WeekItem.EVEN;

  Stream<WeekItem> get weekStream => _weekController.stream;

  void pickWeek(int i) {
    switch (i) {
      case 0:
        _weekController.sink.add(WeekItem.EVEN);
        break;
      case 1:
        _weekController.sink.add(WeekItem.UNEVEN);
        break;
    }
  }

  getCurrWeek() async {
    int response = await _repository.getCurrWeek();
    if (response == 1) {
      this.currWeek = WeekItem.UNEVEN;
      _weekController.sink.add(WeekItem.UNEVEN);
    } else {
      _weekController.sink.add(WeekItem.EVEN);
    }
  }

  close() {
    _weekController?.close();
  }
}

final weekBloc = WeekBloc();
