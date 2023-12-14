import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_market_scan/src/controller/provider/data_provider.dart';
import 'package:stock_market_scan/src/core/constants/enums.dart';
import 'package:stock_market_scan/src/core/widgets/typography/typography.dart';
import 'package:stock_market_scan/src/model/stock_market_data_model.dart';
import 'package:stock_market_scan/src/view/widgets/variable_indicator_widget.dart';
import 'package:stock_market_scan/src/view/widgets/variable_value_widget.dart';

class CriteriaDetailsPage extends StatelessWidget {
  const CriteriaDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stockMarketData = Provider.of<DataProvider>(context, listen: true);
    final Variable? variableData = stockMarketData.getVariableData;
    return Scaffold(
      appBar: AppBar(
        title: const TextLarge(text: 'Stock Criteria'),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          (variableData?.type?.isValue ?? true)
              ? VariableValueWidget(variableData: variableData)
              : VariableIndicatorWidget(variable: variableData ?? Variable())
        ],
      ),
    );
  }
}
