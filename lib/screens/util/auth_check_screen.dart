import 'package:flutter/material.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/model/user_response.dart';
import 'package:kai_mobile_app/bloc/auth_user_bloc.dart';
import 'package:kai_mobile_app/screens/tabs/profile_screen.dart';
import 'package:kai_mobile_app/screens/util/auth_screen.dart';

class AuthCheckScreen extends StatefulWidget {
  @override
  _AuthCheckScreenState createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
          child: StreamBuilder<UserResponse>(
        stream: authBloc.subject.stream,
        builder: (context, AsyncSnapshot<UserResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is UserResponseLoggedIn) {
              return ProfileScreen();
            } else if (snapshot.data is UserResponseLoggetOut) {
              return AuthScreen();
            } else if (snapshot.data is UserResponseLoading) {
              return buildLoadingWidget();
            } else {
              return buildLoadingWidget();
            }
          } else {
            return buildLoadingWidget();
          }
        },
      )),
    );
  }
}
