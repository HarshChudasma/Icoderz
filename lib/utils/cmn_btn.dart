import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CmnBtnWidget extends StatelessWidget {
  final void Function()? btnClk;
  final double? btnRadius;
  final Color? btnColor, textColor;
  final String? btnText;
  final double? horizPad, txtSize, btnOpacity;
  final FontWeight? txtWeight;
  final Size? size;

  const CmnBtnWidget({
    Key? key,
    required this.btnClk,
    this.btnRadius,
    this.btnColor,
    this.textColor,
    this.horizPad,
    this.txtSize,
    this.txtWeight,
    this.btnOpacity,
    this.size,
    required this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: btnOpacity ?? 1,
      child: ElevatedButton(
        onPressed: btnClk,
        style: ElevatedButton.styleFrom(
          maximumSize: size,
          backgroundColor: btnColor ?? context.theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(btnRadius ?? 4.0),
          ),
          shadowColor: Colors.transparent,
          padding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: horizPad ?? 0.0),
        ),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Text(
            btnText!,
            style: context.textTheme.labelMedium?.copyWith(
              color: textColor ?? context.theme.colorScheme.onPrimary,
              fontSize: txtSize ?? 20,
              fontWeight: txtWeight ?? FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
