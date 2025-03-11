import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/config/resources/styles.dart';
import 'package:flutter_base_bloc/core/config/themes/app_theme.dart';

class CommonTextInput extends StatelessWidget {
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final String? hintText;
  final TextStyle? hintStyle;
  final bool obscureText;
  const CommonTextInput({
    super.key,
    this.onChanged,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.hintText,
    this.hintStyle,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        primaryFocus?.unfocus();
      },
      decoration: _inputDecoration(),
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: autovalidateMode,
      obscureText: obscureText,
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      hintText: hintText,
      hintStyle: hintStyle ??
          AppTextStyle.lightText.copyWith(
            color: AppTheme.getInstance().textStroke,
          ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
