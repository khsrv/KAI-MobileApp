import 'package:flutter/cupertino.dart';

class Colors {

  Colors();

  static const Color mainColor = const Color(0xFFFFFFFF);
  static const Color secondColor = const Color(0xFF1d1f33);
  static const Color grey = const Color(0xFF858585);
  static const Color background = const Color(0xFFf0f1f6);
  static const Color titleColor = const Color(0xFF5178BD);
  static const Color standardTextColor = const Color(0xFF656565);
  static const primaryGradient = const LinearGradient(
    colors: const [ Color(0xFF111428), Color(0xFF29304a)],
    stops: const [0.0, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

}