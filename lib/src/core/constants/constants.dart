import 'package:stock_market_scan/src/core/constants/enums.dart';

CriteriaType criteriaTypeData(String text) {
  Map<String, CriteriaType> criteriaMap = {
    'text': CriteriaType.text,
    'variable': CriteriaType.variable
  };
  return criteriaMap[text] ?? CriteriaType.text;
}

VariableType variableTypeData(String text) {
  Map<String, VariableType> variableMap = {
    'indicator': VariableType.indicator,
    'value': VariableType.value
  };
  return variableMap[text] ?? VariableType.indicator;
}
