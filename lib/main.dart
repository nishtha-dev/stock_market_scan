import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock_market_scan/src/controller/provider/data_provider.dart';
import 'package:stock_market_scan/src/core/constants/endpoints.dart';
import 'package:stock_market_scan/src/core/dio/dio_client.dart';
import 'package:stock_market_scan/src/core/theme/app_theme.dart';
import 'package:stock_market_scan/src/core/utils/utils.dart';
import 'package:stock_market_scan/src/view/screens/stock_criteria_details_page.dart';
import 'package:stock_market_scan/src/view/screens/stock_scan_criteria_page.dart';
import 'package:stock_market_scan/src/view/screens/stock_scan_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        ScreenUtil.init(context, designSize: const Size(360, 801));
        return ChangeNotifierProvider(
          create: (context) => DataProvider(
              client: DioClient.create(
                  Dio(BaseOptions(baseUrl: EndPoints.baseUrl)))),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Stock Scan Parser',
            theme: AppTheme().themeData,
            home: const StockScanPage(),
            routes: {
              RouteEnum.stockMarketScans.toPath: (context) =>
                  const StockScanPage(),
              RouteEnum.stockCriteriaPage.toPath: (context) =>
                  const StockMarketCriteria(),
              RouteEnum.stockCriteriaDetailsPage.toPath: (context) =>
                  const CriteriaDetailsPage(),
            },
          ),
        );
      },
    );
  }
}
