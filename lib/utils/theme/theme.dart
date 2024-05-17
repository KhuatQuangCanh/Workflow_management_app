

import 'package:flutter/material.dart';
import 'package:workflow_management_app/utils/theme/custom_themes/appbar_theme.dart';
import 'package:workflow_management_app/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:workflow_management_app/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:workflow_management_app/utils/theme/custom_themes/chip_theme.dart';
import 'package:workflow_management_app/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:workflow_management_app/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:workflow_management_app/utils/theme/custom_themes/text_field_theme.dart';
import 'package:workflow_management_app/utils/theme/custom_themes/text_theme.dart';

class CAppTheme {
  CAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    chipTheme: CChipTheme.lightChipTheme,
    textTheme: CTextTheme.lightTextTheme,
    appBarTheme: CAppBarTheme.lightAppBarTheme,
    checkboxTheme: CCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: CBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: CElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: COutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: CTextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    chipTheme: CChipTheme.darkChipTheme,
    textTheme: CTextTheme.darkTextTheme,
    appBarTheme: CAppBarTheme.darkAppBarTheme,
    checkboxTheme: CCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: CBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: CElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: COutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: CTextFormFieldTheme.darkInputDecorationTheme,
  );

}