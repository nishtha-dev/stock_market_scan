import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:stock_market_scan/src/core/constants/colors.dart';
import 'package:stock_market_scan/src/core/constants/enums.dart';
import 'package:stock_market_scan/src/core/theme/app_style_text.dart';
import 'package:stock_market_scan/src/core/widgets/typography/text_medium.dart';
import 'package:stock_market_scan/src/model/stock_market_data_model.dart';

class CriteriaCard extends StatefulWidget {
  final Criterion? criteriaData;
  final Function(Criterion? criterion, String? selectedVariableName) onTap;

  const CriteriaCard({super.key, this.criteriaData, required this.onTap});

  @override
  State<CriteriaCard> createState() => _CriteriaCardState();
}

class _CriteriaCardState extends State<CriteriaCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.black, borderRadius: BorderRadius.circular(2)),
      padding: const EdgeInsets.all(12),
      child: (widget.criteriaData?.type?.isText ?? true)
          ? TextMedium(
              text: widget.criteriaData?.text ?? '',
              textAlign: TextAlign.left,
            )
          : RichText(
              textAlign: TextAlign.left,
              text: TextSpan(children: [
                ...widget.criteriaData?.getFinalCriteriaValue.map((variable) {
                      if (variable.variableValue.contains('\$')) {
                        return TextSpan(
                          text: ' (${variable.variableValue.substring(1)}) ',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              widget.onTap(
                                  widget.criteriaData, variable.variableSymbol);
                            },
                          style: TextStyle(
                            color: AppColors.red,
                            // decoration: TextDecoration.underline,
                            fontSize: 12.sp,
                          ).lineHeight(18.sp),
                        );
                      } else {
                        return TextSpan(
                          text: '${variable.variableValue} ',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12.sp,
                          ).lineHeight(18.sp),
                        );
                      }
                    }) ??
                    []
              ])),
    );
  }
}
