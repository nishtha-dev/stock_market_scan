import 'package:stock_market_scan/src/core/constants/endpoints.dart';
import 'package:stock_market_scan/src/core/dio/dio_client.dart';
import 'package:stock_market_scan/src/model/stock_market_data_model.dart';

class DataServices {
  DioClient client;
  DataServices({required this.client});

  Future<List<StockMarketDataModel>> getJsonData() async {
    try {
      final response = await client.dio.get(EndPoints.dataPoint);

      final model = StockMarketDataModel.listFromJson(response.data);
      return model;
    } on Exception catch (e) {
      throw (Exception(e));
    }
  }
}
