import 'package:flutter/material.dart';

class AppStyle {
  static Color whiteColor = Colors.white;
  static Color grey = Color(0xffE4E4E7);
  static Color greyDark = Color(0xff9E9E9E);
  static Color black = Color(0xff000000);
  static Color blue = Color(0xff1976D2);

  static Color textColor = const Color(0xff424242);
  static Color hintColor = const Color(0xffD7E3DF);
  static Color errorTextColor = const Color(0xffFF5252);
  static Color borderColor = const Color(0xff669585);
  static Color buttonDisabledColor = const Color(0xffCCDBD6);
  static Color buttonDisabledShadowColor = const Color(0xff99A3A0);
  static Color mainGreen = const Color(0xff90BE6D);
  static Color mainOrange = const Color(0xffF8961E);
  static Color hoverOrange = const Color(0xffE27B02);
  static Color mainRed = const Color(0xffFF5252);
  static Color hoverRed = const Color(0xffE31A37);

  static Color searchBorderColor = const Color(0xffD9E5E5);
  static Color searchHintColor = const Color(0xffE0E0E0);
  static Color dialogBgColor = const Color(0xff014F34).withValues(alpha: 0.4);

  static OutlineInputBorder inputBorderTheme() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 1.5),
      borderRadius: const BorderRadius.all(Radius.circular(15)),
    );
  }

  static OutlineInputBorder errorBorderTheme() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: errorTextColor, width: 1.5),
      borderRadius: const BorderRadius.all(Radius.circular(15)),
    );
  }

  static OutlineInputBorder disabledBorderTheme() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 1.5),
      borderRadius: const BorderRadius.all(Radius.circular(15)),
    );
  }

  static ThemeData themeData(BuildContext context) {
    return ThemeData(
        useMaterial3: false,
        fontFamily: 'BloggerSans',
        // primarySwatch: AppStyle.appTheme,
        textTheme: TextTheme(
            titleMedium: regular(
          textColor: AppStyle.blue,
          size: 15,
        )),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.zero,
          enabledBorder: inputBorderTheme(),
          border: inputBorderTheme(),
          focusedBorder: inputBorderTheme(),
          focusedErrorBorder: errorBorderTheme(),
          errorBorder: errorBorderTheme(),
          disabledBorder: disabledBorderTheme(),
          errorStyle: regular(
            textColor: AppStyle.errorTextColor,
            size: 12,
          ),
          floatingLabelStyle: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
          labelStyle: TextStyle(
            color: AppStyle.blue,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: regular(
            textColor: hintColor,
            size: 15,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            disabledForegroundColor: AppStyle.whiteColor,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: BorderSide(color: borderColor, width: 0.5),
            foregroundColor: textColor,
            minimumSize: const Size.fromHeight(44),
            disabledForegroundColor: AppStyle.whiteColor,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            disabledForegroundColor: buttonDisabledColor,
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppStyle.blue,
        ));
  }

  static TextStyle light({
    Color? textColor,
    double size = 14,
    fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      fontSize: size,
      color: textColor ?? AppStyle.textColor,
      letterSpacing: 0,
      fontFamily: 'BloggerSans',
      fontWeight: FontWeight.w400,
      fontStyle: fontStyle,
    );
  }

  static TextStyle regular({
    Color? textColor,
    double size = 14,
    double? height,
    fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      fontSize: size,
      color: textColor ?? AppStyle.textColor,
      letterSpacing: 0,
      height: height ?? 1.2,
      fontFamily: 'BloggerSans',
      fontWeight: FontWeight.w500,
      fontStyle: fontStyle,
    );
  }

  static TextStyle medium({
    Color? textColor,
    double size = 14,
    fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      fontSize: size,
      color: textColor ?? AppStyle.textColor,
      letterSpacing: 0,
      fontFamily: 'BloggerSans',
      fontWeight: FontWeight.w600,
      fontStyle: fontStyle,
    );
  }

  static TextStyle bold({
    Color? textColor,
    double size = 14,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      fontSize: size,
      color: textColor ?? AppStyle.textColor,
      letterSpacing: 0,
      fontFamily: 'BloggerSans',
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    );
  }
}
