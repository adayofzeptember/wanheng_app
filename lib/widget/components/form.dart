import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanheng_app/utils/app_colors.dart';

// ignore: must_be_immutable
class FormCustom extends StatelessWidget {
  FormCustom({
    Key? key,
    required this.controller,
    required this.hint,
    this.obscure,
    this.borderColor,
    this.lengthLimitText,
    this.suffix,
    this.onChanged,
  }) : super(key: key);
  var controller;
  String hint;
  bool? obscure;
  Color? borderColor;
  int? lengthLimitText;
  Widget? suffix;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColor.grey,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      controller: controller,
      obscureText: obscure ?? false,
      textAlignVertical: TextAlignVertical.top,
      inputFormatters: (lengthLimitText != null)
          ? [
              LengthLimitingTextInputFormatter(lengthLimitText),
            ]
          : null,
      // expands: false,
      style: TextStyle(
        fontSize: 18,
        color: Colors.grey[700],
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        suffix: suffix,
        contentPadding: const EdgeInsets.only(left: 8, right: 4),
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: borderColor ?? AppColor.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: borderColor ?? AppColor.grey,
          ),
        ),
      ),
    );
  }
}
