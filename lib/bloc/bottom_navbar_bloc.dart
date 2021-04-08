import 'dart:async';

import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';

enum NavBarItem { NEWS, SERVICE, PROFILE }

class BottomNavBarBloc {
  final StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.NEWS;
  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.NEWS);
        break;
      case 1:
        serviceMenu.backToMenu();
        _navBarController.sink.add(NavBarItem.SERVICE);
        break;
      case 2:
        _navBarController.sink.add(NavBarItem.PROFILE);
        break;
      case 3:
        _navBarController.sink.add(NavBarItem.PROFILE);
        break;
      // case 3:
      //   _navBarController.sink.add(NavBarItem.MESSENGER);
      //   break;
    }
  }

  close() {
    _navBarController?.close();
  }
}

final bottomNavBarBloc = BottomNavBarBloc();
