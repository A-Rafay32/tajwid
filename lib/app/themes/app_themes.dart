import 'package:flutter/material.dart';
import 'package:tajwid/app/themes/app_colors.dart';
import 'package:tajwid/app/themes/text_theme.dart';

class AppThemes {
  late final theme = ThemeData(
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    textTheme: AppTextTheme.textTheme,
    drawerTheme: drawerThemeData,
    // dividerColor:  Color(0xFFEEEEEE),
    dividerTheme: DividerThemeData(color: Colors.grey.shade200),
    // dividerTheme: const DividerThemeData(color: Color(0xFFEEEEEE)),
    elevatedButtonTheme: elevationButtonTheme,
    textButtonTheme: textButtonTheme,
    cardColor: AppColors.primaryColor,
    appBarTheme: appBarTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    searchBarTheme: searchBarThemeData,
    snackBarTheme: snackbarTheme,
    bottomSheetTheme: bottomSheetTheme,
    bottomNavigationBarTheme: bottomNavigationBarTheme,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.primaryColor,
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    iconTheme: const IconThemeData(color: Colors.white),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.backgroundColor,
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(Colors.white),
        elevation: WidgetStatePropertyAll(2.0),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStatePropertyAll(Colors.white),
      checkColor: WidgetStatePropertyAll(AppColors.primaryColor),
    ),
    useMaterial3: true,
    // shadowColor: AppColors.shadowColor
  );

  final snackbarTheme = SnackBarThemeData(
    backgroundColor: AppColors.backgroundColor,
    insetPadding: EdgeInsets.all(7),
    elevation: 1.0,
    behavior: SnackBarBehavior.floating,
    contentTextStyle: AppTextTheme.bodyMedium,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );

  final navigationBarTheme = NavigationBarThemeData(
    backgroundColor: AppColors.primaryColor,
    surfaceTintColor: AppColors.primaryColor,
    elevation: 2.0,
    iconTheme: WidgetStatePropertyAll(
      IconThemeData(color: AppColors.blackColor),
    ),
    indicatorColor: AppColors.primaryColor,
  );
  final bottomNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: AppColors.backgroundColor,
    elevation: 2.0,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.primaryColor,
    unselectedIconTheme: IconThemeData(color: AppColors.backgroundColor),
    unselectedItemColor: AppColors.backgroundColor,
    selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
  );

  final AppBarTheme appBarTheme = AppBarTheme(
    centerTitle: true,
    titleTextStyle: AppTextTheme.titleMedium.copyWith(color: Colors.white),
    backgroundColor: AppColors.primaryColor,
    iconTheme: IconThemeData(color: Colors.white),
  );
  final DrawerThemeData drawerThemeData = DrawerThemeData(
    backgroundColor: AppColors.backgroundColor,
    shadowColor: AppColors.primaryColor,
  );

  final bottomSheetTheme = BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(240),
        topRight: Radius.circular(240),
      ),
    ),
  );

  final TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      textStyle: WidgetStatePropertyAll(AppTextTheme.bodyMedium),
      backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
    ),
  );

  final elevationButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
      elevation: WidgetStatePropertyAll(2.0),
      textStyle: WidgetStatePropertyAll(AppTextTheme.bodyMedium),
    ),
  );
  final searchBarThemeData = SearchBarThemeData(
    elevation: WidgetStatePropertyAll(1.0),
    hintStyle: WidgetStatePropertyAll(AppTextTheme.bodyMedium),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
    padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
    backgroundColor: WidgetStatePropertyAll(AppColors.backgroundColor),
  );
}
