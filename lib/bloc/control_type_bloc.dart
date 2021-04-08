

import 'dart:async';

enum ControlTypeItem{ADD,LIST}

class ControlTypeBloc{
  final StreamController<ControlTypeItem> _addTypeController =
  StreamController<ControlTypeItem>.broadcast();

  ControlTypeItem defAddType = ControlTypeItem.ADD;

  Stream<ControlTypeItem> get addTypeStream => _addTypeController.stream;

  void pickWeek(int i) {
    switch (i) {
      case 0:
        _addTypeController.sink.add(ControlTypeItem.ADD);
        break;
      case 1:
        _addTypeController.sink.add(ControlTypeItem.LIST);
        break;
    }
  }

  close() {
      _addTypeController?.close();
    }
  }
final controlTypeBloc = ControlTypeBloc();
