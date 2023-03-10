import 'package:flutter/material.dart';

const homeAppBarHeight = Size.fromHeight(40);

final appThemeData = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorSchemeSeed: Colors.purple,
  fontFamily: 'Sarasa UI SC',
);

final appDarkThemeData = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorSchemeSeed: Colors.orange,
  fontFamily: 'Sarasa UI SC',
);
