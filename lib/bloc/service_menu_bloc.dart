
import 'dart:async';

enum ServiceMenuItem{LESSON,EXAMS,MY_GROUP,BRS,MAP,ACTIVITY,DOC,CONTROL,MENU}

class ServiceMenuBloc{
  final StreamController<ServiceMenuItem> _serviceItemController = StreamController<ServiceMenuItem>.broadcast();

  ServiceMenuItem defaultItem = ServiceMenuItem.MENU;
  Stream<ServiceMenuItem> get itemStream =>_serviceItemController.stream;

  void pickItem(int i){
    switch(i){
      case 0:
        _serviceItemController.sink.add(ServiceMenuItem.LESSON);
        break;
      case 1:
        _serviceItemController.sink.add(ServiceMenuItem.EXAMS);
        break;
      case 2:
        _serviceItemController.sink.add(ServiceMenuItem.MY_GROUP);
        break;
      case 3:
        _serviceItemController.sink.add(ServiceMenuItem.BRS);
        break;
      case 4:
        _serviceItemController.sink.add(ServiceMenuItem.MAP);
        break;
      case 5:
        _serviceItemController.sink.add(ServiceMenuItem.ACTIVITY);
        break;
      case 6:
        _serviceItemController.sink.add(ServiceMenuItem.DOC);
        break;
      case 7:
        _serviceItemController.sink.add(ServiceMenuItem.CONTROL);
        break;
    }
  }
  void backToMenu(){
    _serviceItemController.sink.add(ServiceMenuItem.MENU);
  }

  close() {
    _serviceItemController?.close();
  }

}
final serviceMenu = ServiceMenuBloc();