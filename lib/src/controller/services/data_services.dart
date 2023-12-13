import 'dart:convert';

import 'package:stock_market_scan/src/core/constants/endpoints.dart';
import 'package:stock_market_scan/src/model/stock_market_data_model.dart';
import 'package:http/http.dart' as http;

class DataServices {
  Future<List<StockMarketDataModel>> getJsonData() async {
    try {
      final response = await http
          .get(Uri.parse("${EndPoints.baseUrl}${EndPoints.dataPoint}"));
      final model =
          StockMarketDataModel.listFromJson(jsonDecode(response.body));
      return model;
    } on Exception catch (e) {
      throw (Exception(e));
    }
  }
}
