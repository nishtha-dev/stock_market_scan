class VariableData {
  final String? variableSymbol;
  final String variableValue;

  VariableData({this.variableSymbol, required this.variableValue});

  factory VariableData.initial() {
    return VariableData(variableSymbol: '', variableValue: '');
  }
}
