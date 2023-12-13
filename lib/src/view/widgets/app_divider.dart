import 'package:flutter/material.dart';
import 'package:stock_market_scan/src/core/constants/colors.dart';

enum DividerType { normal, vertical }

class AppDivider extends StatelessWidget {
  final double height;
  final DividerType type;
  final Color? color;

  const AppDivider({
    Key? key,
    this.height = 1,
    this.type = DividerType.normal,
    this.color,
  }) : super(key: key);

  const AppDivider.vertical({
    super.key,
    this.type = DividerType.vertical,
    this.height = 1,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    const dividerColor = AppColors.lightGreyColor;

    Widget divider = Container(
      height: height,
      color: color ?? dividerColor,
    );

    if (type == DividerType.normal) {
      return divider;
    } else {
      divider = Container(
        width: 1,
        height: height,
        color: dividerColor,
      );
      return divider;
    }
  }
}
