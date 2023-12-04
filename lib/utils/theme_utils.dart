import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';

import '../constants/custom_colors.dart';

class ThemeUtils {
  static ThemeData get darkTheme => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        focusColor: HexColor(CustomColors.blue1).withOpacity(0.3),
        hoverColor: HexColor(CustomColors.blue1).withOpacity(0.3),
        splashColor: HexColor(CustomColors.blue1).withOpacity(0.3),
        highlightColor: HexColor(CustomColors.blue1).withOpacity(0.3),
        radioTheme: RadioThemeData(
          fillColor: MaterialStatePropertyAll(
            HexColor(CustomColors.blue1),
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        applyElevationOverlayColor: true,
        colorScheme: const ColorScheme.dark(
          brightness: Brightness.dark,
          primary: Colors
              .white, // it is also responsible for setting default color of Icon()
        ).copyWith(
          secondary: HexColor(CustomColors.blue1),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.rubik(
            color: Colors.white,
          ),
        ),
      );

  static ThemeData get lightTheme => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        // scaffoldBackgroundColor: HexColor(CustomColors.grey4),
        focusColor: HexColor(CustomColors.blue1).withOpacity(0.3),
        hoverColor: HexColor(CustomColors.blue1).withOpacity(0.3),
        splashColor: HexColor(CustomColors.blue1).withOpacity(0.3),
        highlightColor: HexColor(CustomColors.blue1).withOpacity(0.3),
        colorScheme: ColorScheme.light(
          brightness: Brightness.light,
          primary: HexColor(CustomColors
              .blue1), // it is also responsible for setting default color of Icon()
        ).copyWith(
          secondary: HexColor(CustomColors.blue1),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.rubik(
            color: Colors.white,
          ),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStatePropertyAll(
            HexColor(CustomColors.blue1),
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      );

  static SystemUiOverlayStyle getStatusNavBarTheme(BuildContext context) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      systemNavigationBarIconBrightness:
          Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
      statusBarBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    );
  }

  static SystemUiOverlayStyle getStatusNavBarOneTheme(BuildContext context) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      systemNavigationBarDividerColor:
          Theme.of(context).scaffoldBackgroundColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness:
          Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
      statusBarBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    );
  }
}
