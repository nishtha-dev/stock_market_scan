enum CriteriaType { text, variable }

enum VariableType { value, indicator }

extension CriteriaTypeX on CriteriaType {
  bool get isText => this == CriteriaType.text;
  bool get isVariable => this == CriteriaType.variable;
}

extension VariableTypeX on VariableType {
  bool get isIndicator => this == VariableType.indicator;
  bool get isValue => this == VariableType.value;
}
