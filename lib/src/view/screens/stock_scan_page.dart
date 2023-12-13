import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_market_scan/src/controller/provider/data_provider.dart';
import 'package:stock_market_scan/src/core/constants/colors.dart';
import 'package:stock_market_scan/src/core/constants/enums.dart';
import 'package:stock_market_scan/src/core/constants/route_utils.dart';
import 'package:stock_market_scan/src/core/widgets/typography/text_large.dart';
import 'package:stock_market_scan/src/model/stock_market_data_model.dart';
import 'package:stock_market_scan/src/view/widgets/app_divider.dart';
import 'package:stock_market_scan/src/view/widgets/stock_data_card.dart';

class StockScanPage extends StatefulWidget {
  const StockScanPage({super.key});

  @override
  State<StockScanPage> createState() => _StockScanPageState();
}

class _StockScanPageState extends State<StockScanPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DataProvider>(context, listen: false)
          .getStockMarketDataModelData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const TextLarge(
          text: 'Stock Scan ',
        ),
        elevation: 1,
        backgroundColor: AppColors.payneGreyColor,
      ),
      body: Consumer<DataProvider>(
        builder: (context, provider, child) {
          if (provider.apiStatus.isLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.payneGreyColor,
            ));
          }
          return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverList.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const AppDivider(),
                  itemCount: provider.stockMarketDataModelDataList.length,
                  itemBuilder: (context, index) {
                    if ((provider.stockMarketDataModelDataList).isNotEmpty) {
                      return StockDataCard(
                        title:
                            provider.stockMarketDataModelDataList[index].name ??
                                '',
                        subtitle:
                            provider.stockMarketDataModelDataList[index].tag ??
                                '',
                        subtitleColor: provider
                            .stockMarketDataModelDataList[index]
                            .getSubtitleColor,
                        onTap: () {
                          provider.selectedStockModel =
                              provider.stockMarketDataModelDataList[index];
                          Navigator.of(context)
                              .pushNamed(RouteEnum.stockCriteriaPage.toPath);
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                )
              ]);
        },
      ),
    );
  }
}
