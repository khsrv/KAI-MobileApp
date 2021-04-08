import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/bottom_navbar_bloc.dart';


Widget buildAuthButton(){
  return Center(
    child: FlatButton(
      child: Text(
        "Авторизоваться",
            style: TextStyle(
          color: Colors.white
      ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      color: Color(0xFF3985c0),
      onPressed: (){
        bottomNavBarBloc..pickItem(3);
      },
    ),
  );
}