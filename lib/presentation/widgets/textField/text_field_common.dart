import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/config/resources/dimens.dart';
import 'package:flutter_base_bloc/core/config/resources/styles.dart';
import 'package:flutter_base_bloc/core/config/themes/app_theme.dart';

class TextFieldCommon extends StatelessWidget {
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextAlign? textAlign;
  final int? maxLength;
  final Function(String)? onChanged;

  const TextFieldCommon({
    this.borderRadius,
    this.isPassword = false,
    this.borderSide,
    this.hintStyle,
    this.labelStyle,
    this.suffixIcon,
    required this.hintText,
    this.labelText,
    this.textAlign,
    this.maxLength,
    this.onChanged,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      maxLength: maxLength,
      textAlign: textAlign ?? TextAlign.start,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(Dimens.d8),
          borderSide: borderSide ??
              BorderSide(
                color: AppTheme.getInstance().grey88Color,
              ),
        ),
        counterText: '',
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(Dimens.d8),
          borderSide: borderSide ??
              BorderSide(
                color: AppTheme.getInstance().grey88Color,
              ),
        ),
        labelText: labelText,
        labelStyle: labelStyle,
        hintText: hintText,
        hintStyle: hintStyle ??
            AppTextStyle.interText.copyWith(
              color: AppTheme.getInstance().grey51Color,
            ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
