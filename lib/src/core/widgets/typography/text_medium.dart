import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_market_scan/src/core/constants/colors.dart';
import 'package:stock_market_scan/src/core/theme/app_style_text.dart';

class TextMedium extends StatelessWidget {
  final String? text;
  final String? keyName;
  final Color? color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  const TextMedium({
    this.text,
    super.key,
    this.color,
    this.keyName,
    this.overflow,
    this.textAlign,
  }) : assert(text != null || keyName != null);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
        color: color ?? AppColors.white,
        fontSize: 14,
      ).lineHeight(21.sp),
      overflow: overflow ?? TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.justify,
    );
  }
}
