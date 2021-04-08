

import 'dart:async';

enum NewsTypeItem{KAI,FAC}

class NewsTypeBloc{
  final StreamController<NewsTypeItem> _newsTypeController =
  StreamController<NewsTypeItem>.broadcast();

  NewsTypeItem defNewsType = NewsTypeItem.KAI;

  Stream<NewsTypeItem> get newsTypeStream => _newsTypeController.stream;

  void pickWeek(int i) {
    switch (i) {
      case 0:
        _newsTypeController.sink.add(NewsTypeItem.KAI);
        break;
      case 1:
        _newsTypeController.sink.add(NewsTypeItem.FAC);
        break;
    }
  }

    void setCurrWeek(NewsTypeItem weekItem){
      this.defNewsType = weekItem;
    }
    close() {
      _newsTypeController?.close();
    }
  }
  final newsTypeBloc = NewsTypeBloc();
