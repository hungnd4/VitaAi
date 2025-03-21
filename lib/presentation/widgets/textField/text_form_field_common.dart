import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/config/resources/dimens.dart';
import 'package:flutter_base_bloc/core/config/resources/styles.dart';
import 'package:flutter_base_bloc/core/config/themes/app_theme.dart';

class TextFormFieldCommon extends StatelessWidget {
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final int? maxLength;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;

  const TextFormFieldCommon({
    super.key,
    this.labelStyle,
    this.borderSide,
    this.borderRadius,
    this.labelText,
    this.isPassword = false,
    this.hintStyle,
    this.suffixIcon,
    this.maxLength,
    this.textAlign,
    this.keyboardType,
    required this.hintText,
    required this.controller,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      keyboardType: keyboardType,
      onChanged: onChanged,
      textAlign: textAlign ?? TextAlign.start,
      validator: validator,
      controller: controller,
      maxLength: maxLength,
      obscureText: isPassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
