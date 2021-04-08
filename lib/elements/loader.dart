import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

Widget buildLoadingWidget() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 50.0,
        width: 50.0,
        child: SpinKitDoubleBounce(
          size: 50,
          color: Color(0xFF3985c0),
        ),
      )
    ],
  ));
}
