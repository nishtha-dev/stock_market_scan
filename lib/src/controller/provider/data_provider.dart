import 'package:flutter/material.dart';
import 'package:stock_market_scan/src/controller/services/data_services.dart';
import 'package:stock_market_scan/src/core/constants/enums.dart';
import 'package:stock_market_scan/src/model/stock_market_data_model.dart';

class DataProvider extends ChangeNotifier {
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

  /// Initialized Data Service instance inside this function as there was only one api call, for multiple api calls better approach is to use a dependency injection like "get it"

  void getStockMarketDataModelData() async {
    final dataServices = DataServices();
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

extension DataProviderX on DataProvider {
  Variable? get getVariableData {
    return selectedCriterion?.variable?.firstWhere(
        (variableData) => variableData.variableName == selectedVariableSymbol);
  }
}
