import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension TextStyleExt on TextStyle? {
  TextStyle lineHeight(double height) => this!.copyWith(
        height: height / (this?.fontSize?.sp ?? 0),
      );
}
