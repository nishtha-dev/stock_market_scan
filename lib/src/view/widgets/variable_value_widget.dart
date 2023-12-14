import 'package:flutter/material.dart';
import 'package:stock_market_scan/src/core/widgets/typography/text_medium.dart';
import 'package:stock_market_scan/src/model/stock_market_data_model.dart';
import 'package:stock_market_scan/src/core/constants/enums.dart';
import 'package:stock_market_scan/src/view/widgets/app_divider.dart';

class VariableValueWidget extends StatelessWidget {
  const VariableValueWidget({super.key, required this.variableData});
  final Variable? variableData;
  @override
  Widget build(BuildContext context) {
    List<num>? finalValueList = [...?variableData?.values];
    if (variableData?.type?.isValue ?? false) {
      finalValueList.sort();
    }
    return Expanded(
      child: CustomScrollView(physics: const ClampingScrollPhysics(), slivers: [
        SliverList.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const AppDivider(),
            itemCount: finalValueList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: TextMedium(
                  text: finalValueList[index].toString(),
                  textAlign: TextAlign.left,
                ),
              );
            }),
      ]),
    );
  }
}
