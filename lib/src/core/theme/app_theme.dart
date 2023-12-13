import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_market_scan/src/core/constants/colors.dart';

class AppTheme {
  AppTheme();

  ThemeData get themeData {
    return ThemeData(
      primaryColor: AppColors.blue,
      canvasColor: AppColors.black,
      scaffoldBackgroundColor: AppColors.black,
      appBarTheme: appBarTheme,
      dividerTheme: const DividerThemeData(color: AppColors.payneGreyColor),
      splashColor: AppColors.transparent,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: AppColors.payneGreyColor),
      dividerColor: AppColors.lightGreyColor,
    );
  }

  AppBarTheme get appBarTheme {
    return const AppBarTheme(
      iconTheme: IconThemeData(
        color: AppColors.black,
      ),
      elevation: 0,
      toolbarHeight: 64,
      backgroundColor: AppColors.payneGreyColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }
}
