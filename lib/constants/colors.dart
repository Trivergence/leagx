import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color colorBackground = Color(0xFF111820);
  static const Color colorWhite = Colors.white;
  static const Color colorBlack = Colors.black;
  static const Color colorYellow = Color(0xFFFFC46E);
  static const Color textFieldColor = Color(0xFF1B1F2A);
  static const Color colorGrey = Color(0xFFC7D1E7);
  static const Color colorDarkGrey = Color(0xFF272F44);
  static const Color colorGreen = Color(0xFF4CD964);
  static const Color colorRed = Color(0xFFE31C79);
  static const Color colorCyan = Color(0xFF71DAD3);
  static const Color colorCyan40 = Color(0x6671DAD3);
  static const Color colorPink = Color(0xFFEE4A80);
  static const Color colorPink500 = Color(0x50EE4A80);

  static const Color colorPrimary = Color(0xFF4DACFF);
  static const Color primaryColorDark = Color(0xFF0066C0);
  static const Color colorPrimaryLight = Color(0xFF86C4FA);
  static const Color colorPrimaryDisable = Color(0xFFBDDFFD);

  static const Color colorLabel = Color(0xff666666);
  static const Color colorAccent = Color(0xFF86C4FA);
  static const Color colorHint = Color(0xff999999);

  static const Map<int, Color> blue = <int, Color>{
    50: Color(0xFFD9EDFF),
    100: Color(0xFFBDDFFD),
    200: Color(0xFFA9D7FF),
    300: Color(0xFF86C4FA),
    400: Color(0xFF65B5FA),
    500: Color(0xFF4DACFF),
    600: Color(0xFF38A1FD),
    700: Color(0xFF2699FB),
    800: Color(0xFF007EEC),
    900: Color(0xFF0066C0)
  };

  static const Gradient pinkishGradient = LinearGradient(
    colors: [
      Color(0xFFF67599),
      Color(0xFFEA3F85),
      Color(0xFFEA3F85),
      Color(0xFFEA3F85),
      Color(0xFFE5257C),
      Color(0xFFE31C79),
      Color(0xFF8E2191),
      Color(0xFF8E2191),
      Color(0xFF5F259F),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const Gradient orangishGradient = LinearGradient(
    colors: [
      Color(0xFFFFC56E),
      Color(0xFFFF8D6D),
      Color(0xFFFF8D6D),
      Color(0xFFFF8D6D),
      Color(0xFFFF8D6D),
      Color(0xFFFF8D6D),
      Color(0xFFFF8D6D),
      Color(0xFFF8485E),
      Color(0xFFF8485E),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const Gradient blueishGradient = LinearGradient(
    colors: [
      Color(0xFFA7E6D7),
      Color(0xFF71DBD4),
      Color(0xFF4BA3BE),
      Color(0xFF1554A0),
      Color(0xFF003594),
    ],
  );
  static const Gradient blueishBottomTopGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xFFA7E6D7),
      Color(0xFF71DBD4),
      Color(0xFF1554A0),
      Color(0xFF003594),
      Color(0xFF003594),
    ],
  );

  static const Gradient blueishTopBottomGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF71DBD4),
      Color(0xFF4AA2BE),
      Color(0xFF4AA2BE),
      Color(0xFF1554A0),
      Color(0xFF1554A0),
      Color(0xFF1554A0),
      Color(0xFF003594),
    ],
  );

  static Gradient blackishGradient = LinearGradient(
    colors: [
      const Color(0xFF1B1F2A),
      const Color(0xFF232836),
      const Color(0xFF1B1F2A).withOpacity(.76),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  static Gradient grayishGradient = LinearGradient(
    colors: [
      const Color(0xFF2A3041).withOpacity(.97),
      const Color(0xFF2B344D),
      const Color(0xFF2A3041)
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
}
