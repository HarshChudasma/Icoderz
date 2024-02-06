import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icoderz/styles/app_colors.dart';

class CmnDrpDwnBtn extends StatelessWidget {
  final String? textfieldHint;
  final Widget? prefixWidget, suffixWidget;
  final List<DropdownMenuItem<dynamic>>? drpItem;
  final dynamic drpValue;
  void Function(dynamic)? onChanged;
  Widget? iconData;
  String? Function(dynamic)? drpDwnValidation;
  double? brderRadius;

  CmnDrpDwnBtn(
      {Key? key,
        this.textfieldHint,
        this.prefixWidget,
        this.suffixWidget,
        this.drpItem,
        this.drpValue,this.onChanged,this.iconData,this.drpDwnValidation,this.brderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2(
        items: drpItem,
        value: drpValue,
        isDense: true,
        isExpanded: true,
        onChanged: onChanged,
        buttonStyleData: const ButtonStyleData(
          height: 40,
          width: 140,
        ),
        iconStyleData:  IconStyleData(
            icon: iconData ?? const Icon(Icons.keyboard_arrow_down_rounded,size: 24.0,)
        ),
        dropdownStyleData: const DropdownStyleData(
          maxHeight: double.maxFinite,
        ),
        validator: drpDwnValidation,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 6.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular( brderRadius ?? 15.0),
              borderSide: const BorderSide(
                width: 0.0,
                style: BorderStyle.none,
              ),
            ),
            hintText: textfieldHint ?? '',
            alignLabelWithHint: true,
            filled: true,
            fillColor: context.theme.colorScheme.onPrimary,
            hintStyle: TextStyle(
              color: AppColors.greyColor.withOpacity(0.6),
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            )
        ),
      ),
    );
  }
}