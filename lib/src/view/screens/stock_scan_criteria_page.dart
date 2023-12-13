import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock_market_scan/src/controller/provider/data_provider.dart';
import 'package:stock_market_scan/src/core/constants/colors.dart';
import 'package:stock_market_scan/src/core/constants/route_utils.dart';
import 'package:stock_market_scan/src/core/widgets/typography/text_large.dart';
import 'package:stock_market_scan/src/model/stock_market_data_model.dart';
import 'package:stock_market_scan/src/view/widgets/app_divider.dart';
import 'package:stock_market_scan/src/view/widgets/criteria_card.dart';
import 'package:stock_market_scan/src/view/widgets/stock_data_card.dart';

class StockMarketCriteria extends StatelessWidget {
  const StockMarketCriteria({super.key});

  @override
  Widget build(BuildContext context) {
    final stockMarketData = Provider.of<DataProvider>(context, listen: true);
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: AppColors.black2,
            child: StockDataCard(
                title: stockMarketData.selectedStockModel?.name ?? '',
                subtitle: stockMarketData.selectedStockModel?.tag ?? '',
                subtitleColor:
                    stockMarketData.selectedStockModel?.getSubtitleColor ??
                        AppColors.paleGreen,
                onTap: () {},
                isOnTap: false,
                showDivider: false,
                color: AppColors.black2),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverList.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const AppDivider(),
                        itemCount: stockMarketData
                                .selectedStockModel?.criteria?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return CriteriaCard(
                            criteriaData: stockMarketData
                                .selectedStockModel?.criteria?[index],
                            onTap: (Criterion? criterion,
                                String? selectedVariableName) {
                              stockMarketData.selectedCriterionData(
                                  variableSymbol: selectedVariableName,
                                  model: criterion);
                              Navigator.pushNamed(context,
                                  RouteEnum.stockCriteriaDetailsPage.toPath);
                            },
                          );
                        }),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
