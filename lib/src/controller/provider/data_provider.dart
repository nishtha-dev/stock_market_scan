import 'package:flutter/material.dart';
import 'package:stock_market_scan/src/controller/services/data_services.dart';
import 'package:stock_market_scan/src/core/dio/dio_client.dart';
import 'package:stock_market_scan/src/model/stock_market_data_model.dart';

enum ApiStatus { initial, loading, success, failure }

extension ApiStatusX on ApiStatus {
  bool get isInitial => this == ApiStatus.initial;
  bool get isLoading => this == ApiStatus.loading;
  bool get isSuccess => this == ApiStatus.success;
  bool get isFailure => this == ApiStatus.failure;
}

class DataProvider extends ChangeNotifier {
  late DioClient client;
  DataProvider({required this.client});

  List<StockMarketDataModel> stockMarketDataModelDataList = [];
  ApiStatus apiStatus = ApiStatus.initial;
  StockMarketDataModel? selectedStockModel;
  Criterion? selectedCriterion;
  String? selectedVariableSymbol;

  set selectedStockModelData(StockMarketDataModel? model) {
    selectedStockModel = model;
    notifyListeners();
  }

  void selectedCriterionData({Criterion? model, String? variableSymbol}) {
    selectedCriterion = model;
    selectedVariableSymbol = variableSymbol;
    notifyListeners();
  }

  /// Initialized Data Service instance inside this function as there was only one api call, for multiple api calls better approch is to use a dependency injection like "get it" 

  void getStockMarketDataModelData() async {
    final dataServices = DataServices(client: client);
    try {
      apiStatus = ApiStatus.loading;
      notifyListeners();
      stockMarketDataModelDataList = await dataServices.getJsonData();
      apiStatus = ApiStatus.success;
      notifyListeners();
    } catch (e) {
      apiStatus = ApiStatus.failure;
      notifyListeners();
      throw (Exception(e));
    }
  }
}
