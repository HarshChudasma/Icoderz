import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CmnTxtFld extends StatelessWidget {
  final TextEditingController? textController;
  final FocusNode? textFocusNode;
  final bool? textReadOnly,textObsecure;
  final String? textfieldHint;
  final Widget? prefixWidget,suffixWidget;
  final int? maxLines;
  final Color? fillColor;
  final int? maxLength;
  void Function(String)? txtonChanged;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? txtinputFormatters;
  final String? Function(String?)? textFldValidate;
  final void Function()? textOnTap;
  CmnTxtFld(
      {Key? key,
        required this.textController,
        this.textFocusNode,
        this.txtinputFormatters,
        this.textReadOnly = false,
        this.textfieldHint,
        this.maxLength,
        this.textInputType,
        this.txtonChanged,
        this.prefixWidget,
        this.suffixWidget,
        this.maxLines,
        this.textFldValidate,
        this.textObsecure = false,
        this.fillColor,
        this.textOnTap,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: textOnTap,
      controller: textController,
      focusNode: textFocusNode,
      readOnly: textReadOnly ?? false,
      obscureText: textObsecure ?? false,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      validator: textFldValidate,
      onChanged: txtonChanged,
      keyboardType: textInputType,
      cursorColor: context.theme.primaryColor,
      textAlign: TextAlign.start,
      inputFormatters: txtinputFormatters,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: maxLines != null ? 12.0 : 0.0),
        counterText: '',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              width: 0.0,style: BorderStyle.none,
            )
        ),
        filled: true,
        fillColor: fillColor ?? context.theme.canvasColor,
        hintText: textfieldHint ?? '',
        prefixIcon: prefixWidget,
        suffixIcon: suffixWidget,
      ),
    );
  }
}