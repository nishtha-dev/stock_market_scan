import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_market_scan/src/core/widgets/typography/typography.dart';

class StockDataCard extends StatelessWidget {
  const StockDataCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.subtitleColor,
      required this.onTap,
      this.isOnTap = true,
      this.showDivider = true,
      this.color});
  final String title;
  final String subtitle;
  final Color subtitleColor;
  final Function() onTap;
  final bool isOnTap;
  final Color? color;
  final bool showDivider;

  Widget getStockCardWidget({required Widget child}) {
    return isOnTap
        ? InkWell(
            onTap: onTap,
            child: child,
          )
        : child;
  }

  @override
  Widget build(BuildContext context) {
    return getStockCardWidget(
      child: Container(
        color: color,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextMedium(text: title),
            SizedBox(
              height: 4.h,
            ),
            TextSmall(
              text: subtitle,
              color: subtitleColor,
            ),
            SizedBox(
              height: 8.h,
            ),
            // showDivider ? const AppDivider() : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
