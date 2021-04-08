import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/auth_user_bloc.dart';
import 'package:kai_mobile_app/bloc/get_semester_bloc.dart';
import 'package:kai_mobile_app/bloc/theme_bloc.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/model/user_response.dart';
import 'package:kai_mobile_app/style/constant.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // bool isDarkModeEnabled;
  @override
  void initState() {
    super.initState();
    // // ignore: unrelated_type_equality_checks
    // if (themeBloc.itemStream == ThemeItem.LIGHT) {
    //   isDarkModeEnabled = false;
    //   // ignore: unrelated_type_equality_checks
    // } else if (themeBloc.itemStream.last == ThemeItem.DARK) {
    //   isDarkModeEnabled = true;
    // } else {
    //   isDarkModeEnabled = false;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: StreamBuilder<UserResponse>(
        stream: authBloc.subject.stream,
        initialData: UserResponseLoading(),
        builder: (context, AsyncSnapshot<UserResponse> snapshot) {
          /*switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return buildLoadingWidget();
              break;
            case ConnectionState.none:
              return buildLoadingWidget();
              break;
            case ConnectionState.active:
              if (snapshot.data is UserResponseLoggedIn) {
                return _profileScreenBuilder(context, snapshot);
              } else {
                return buildLoadingWidget();
              }
              break;
            case ConnectionState.done:
              if (snapshot.data is UserResponseLoggedIn) {
                return _profileScreenBuilder(context, snapshot);
              } else {
                return buildLoadingWidget();
              }
              break;
            default:
              return buildLoadingWidget();
              break;
          }*/
          if (snapshot.data is UserResponseLoggedIn) {
            return _profileScreenBuilder(context, snapshot);
          } else {
            return buildLoadingWidget();
          }
        },
      ),
    );
  }

  Stack _profileScreenBuilder(
      BuildContext context, AsyncSnapshot<UserResponse> snapshot) {
    return Stack(children: [
      Column(
        children: [
          Expanded(
              flex: 6,
              child: Container(
                  color: Theme.of(context).primaryColor,
                  child: Image.asset(
                    'assets/placeholder.png',
                    width: MediaQuery.of(context).size.width,
                  ))),
          Expanded(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.only(top: 40, right: 30, left: 30),
                child: Column(
                  children: [
                    _buildUserDataText(
                        label: "Институт:",
                        userData: snapshot.data.user.instName,
                        icon: Icons.school),
                    _buildUserDataText(
                        label: "Специальность:",
                        userData: snapshot.data.user.specName,
                        icon: Icons.menu_book),
                    _buildUserDataText(
                        label: "Номер группы:",
                        userData: snapshot.data.user.groupNum,
                        icon: Icons.group),
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.sensor_door,
                          color: Colors.red,
                        ),
                        Text(
                          "Выйти",
                          style: kExitStyleText,
                        ),
                      ],
                    ),
                    onTap: () {
                      authBloc
                        ..authLogOut(
                            getSemestrBloc.subject.value.semesters.length !=
                                    null
                                ? getSemestrBloc.subject.value.semesters.length
                                : 0);
                    },
                  ),
                ),
              ))
        ],
      ),
      Positioned.fill(
        top: -150,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            height: 100,
            width: 370,
            child: _buildNameCard(snapshot.data),
          ),
        ),
      ),
      Positioned.fill(
        top: 8,
        right: 16,
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            //margin: EdgeInsets.only(left: 30, right: 30),
            height: 50,
            width: 50,
            child: _buildSwithcButton(),
          ),
        ),
      ),
    ]);
  }

  Widget _buildSwithcButton() {
    return StreamBuilder(
        stream: themeBloc.itemStream,
        // ignore: missing_return
        builder: (context, AsyncSnapshot<bool> snapshot) {
          return DayNightSwitcher(
            isDarkModeEnabled: snapshot.data == null ? true : !snapshot.data,
            onStateChanged: (isDarkModeEnabled) {
              themeBloc.pickItem(!isDarkModeEnabled);
            },
          );
        });
  }

  Widget _buildNameCard(UserResponse userResponse) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(children: [
          Text(
            userResponse.user.studFio,
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Номер зачетки: ${userResponse.user.zach}",
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }

  Widget _buildUserDataText(
      {@required String label, @required String userData, IconData icon}) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        child: Row(
          children: [
            icon != null
                ? Icon(
                    icon,
                    color: Theme.of(context).accentColor,
                  )
                : SizedBox(),
            SizedBox(
              width: 8,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                      userData,
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
