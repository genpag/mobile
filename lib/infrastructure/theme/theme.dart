import 'package:flutter/material.dart';

import 'app_bar.theme.dart';
import 'button.theme.dart';
import 'colors.theme.dart';
import 'text.theme.dart';

ThemeData themeData = ThemeData(
  primaryColor: ColorsTheme.primary,
  appBarTheme: appBarTheme,
  buttonTheme: buttonTheme,
  textTheme: textTheme,
  fontFamily: 'BeVietnam',
  colorScheme: const ColorScheme.light(
    primary: ColorsTheme.primary,
    secondary: ColorsTheme.secondary,
  ),
);
