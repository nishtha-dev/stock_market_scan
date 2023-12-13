import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_market_scan/src/core/constants/colors.dart';
import 'package:stock_market_scan/src/core/theme/app_style_text.dart';
import 'package:stock_market_scan/src/core/widgets/typography/text_large.dart';
import 'package:stock_market_scan/src/core/widgets/typography/text_medium.dart';
import 'package:stock_market_scan/src/model/stock_market_data_model.dart';

class VariableIndicatorWidget extends StatefulWidget {
  const VariableIndicatorWidget({super.key, required this.variable});
  final Variable variable;

  @override
  State<VariableIndicatorWidget> createState() =>
      _VariableIndicatorWidgetState();
}

class _VariableIndicatorWidgetState extends State<VariableIndicatorWidget> {
  late final FocusNode focusNode;

  late final TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    searchController =
        TextEditingController(text: widget.variable.defaultValue.toString());
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextLarge(
            text: widget.variable.studyType?.toUpperCase(),
          ),
          SizedBox(
            height: 4.h,
          ),
          const TextMedium(
            text: 'Set Parameters',
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: TextMedium(
                    text: widget.variable.parameterName,
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.amberAccent,
                    child: TextField(
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onChanged: (value) {
                        if (value.isEmpty) {
                          searchController.text =
                              widget.variable.minValue.toString();
                          return;
                        }
                        if (num.parse(value) >
                            (widget.variable.maxValue ?? 99)) {
                          searchController.text =
                              widget.variable.maxValue.toString();
                          return;
                        }
                        if (num.parse(value) <
                            (widget.variable.minValue ?? 0)) {
                          searchController.text =
                              widget.variable.minValue.toString();
                        }
                      },
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 12.sp,
                      ).lineHeight(18.sp),
                      controller: searchController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: AppColors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.lightGreyColor),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.blue),
                          ),
                          focusColor: Colors.transparent,
                          filled: true),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
