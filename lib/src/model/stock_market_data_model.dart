import 'package:flutter/material.dart';
import 'package:stock_market_scan/src/core/constants/colors.dart';
import 'package:stock_market_scan/src/core/constants/constants.dart';
import 'package:stock_market_scan/src/core/constants/enums.dart';
import 'package:stock_market_scan/src/core/models/varible_data_model.dart';
import 'package:uuid/uuid.dart';

class StockMarketDataModel with ChangeNotifier {
  num? id;
  String? name;
  String? tag;
  String? color;
  List<Criterion>? criteria;

  StockMarketDataModel({
    this.id,
    this.name,
    this.tag,
    this.color,
    this.criteria,
  });

  static List<StockMarketDataModel> listFromJson(List<dynamic> data) {
    return data
        .map((jsonData) => StockMarketDataModel.fromJson(jsonData))
        .toList();
  }

  factory StockMarketDataModel.fromJson(Map<String, dynamic> json) =>
      StockMarketDataModel(
        id: json["id"],
        name: json["name"],
        tag: json["tag"],
        color: json["color"],
        criteria: json["criteria"] == null
            ? []
            : List<Criterion>.from(
                json["criteria"]!.map((x) => Criterion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tag": tag,
        "color": color,
        "criteria": criteria == null
            ? []
            : List<dynamic>.from(criteria!.map((x) => x.toJson())),
      };
}

extension StockMarketDataModelX on StockMarketDataModel {
  Color get getSubtitleColor {
    Map<String, Color> colorMap = {
      'green': AppColors.paleGreen,
      'red': AppColors.red
    };
    return colorMap[color] ?? AppColors.paleGreen;
  }
}

class Criterion {
  CriteriaType? type;
  String? id;
  String? text;
  List<Variable>? variable;

  Criterion({
    this.type,
    this.id,
    this.text,
    this.variable,
  });

  factory Criterion.fromJson(Map<String, dynamic> json) {
    List<dynamic>? variableList = (json["variable"]?.values)?.toList();
    List<String>? variableKeysList = json["variable"]?.keys?.toList();

    for (var i = 0; i < (variableList?.length ?? 0); i++) {
      variableList?[i] = {
        "variable_symbol": variableKeysList?[i],
        ...variableList[i]
      };
    }

    return Criterion(
      type: criteriaTypeData(json['type']),
      id: json["id"] ?? const Uuid().v1(),
      text: json["text"],
      variable:
          variableList == null ? null : Variable.listFromJson(variableList),
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
        "id": id,
        "variable": variable?.fold({}, (previousValue, element) {
          num? index = variable?.indexOf(element);
          return ({
            ...previousValue,
            ["\$$index"]: element.toJson()
          });
        }),
      };
}

extension CriterionX on Criterion {
  List<VariableData> get getFinalCriteriaValue {
    final List<String> newText = text?.split(' ') ?? [];

    final finalCriteriaValueList = newText.map((element) {
      VariableData variableData;
      if (element.contains('\$')) {
        Variable? currentVar =
            variable?.firstWhere((e) => e.variableSymbol == element);
        variableData = VariableData(
            variableSymbol: currentVar?.variableSymbol ?? '',
            variableValue: "\$${currentVar?.getDefaultVariableValue}");
      } else {
        variableData = VariableData(variableValue: element);
      }
      return variableData;
    }).toList();
    return finalCriteriaValueList;
  }
}

class Variable {
  VariableType? type;
  List<num>? values;
  String? studyType;
  String? parameterName;
  String? variableSymbol;
  num? minValue;
  num? maxValue;
  num? defaultValue;

  Variable({
    this.type,
    this.values,
    this.studyType,
    this.parameterName,
    this.minValue,
    this.maxValue,
    this.defaultValue,
    this.variableSymbol,
  });
  static List<Variable> listFromJson(List<dynamic> data) {
    return data.map((jsonData) => Variable.fromJson(jsonData)).toList();
  }

  factory Variable.fromJson(dynamic json) => Variable(
        type: variableTypeData(json["type"]),
        values: json["values"] == null
            ? []
            : List<num>.from(json["values"]!.map((x) => x)),
        studyType: json["study_type"],
        parameterName: json["parameter_name"],
        minValue: json["min_value"],
        maxValue: json["max_value"],
        defaultValue: json["default_value"],
        variableSymbol: json["variable_symbol"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "values":
            values == null ? [] : List<dynamic>.from(values!.map((x) => x)),
        "study_type": studyType,
        "parameter_name": parameterName,
        "min_value": minValue,
        "max_value": maxValue,
        "default_value": defaultValue,
        "variable_symbol": variableSymbol,
      };
}

extension VariableX on Variable {
  String get getDefaultVariableValue {
    if (type == VariableType.indicator) {
      return defaultValue.toString();
    } else {
      return values?.first.toString() ?? '';
    }
  }
}
