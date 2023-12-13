enum CriteriaType { text, variable }

enum VariableType { value, indicator }

enum ApiStatus { initial, loading, success, failure }

extension ApiStatusX on ApiStatus {
  bool get isInitial => this == ApiStatus.initial;
  bool get isLoading => this == ApiStatus.loading;
  bool get isSuccess => this == ApiStatus.success;
  bool get isFailure => this == ApiStatus.failure;
}

extension CriteriaTypeX on CriteriaType {
  bool get isText => this == CriteriaType.text;
  bool get isVariable => this == CriteriaType.variable;
}

extension VariableTypeX on VariableType {
  bool get isIndicator => this == VariableType.indicator;
  bool get isValue => this == VariableType.value;
}
