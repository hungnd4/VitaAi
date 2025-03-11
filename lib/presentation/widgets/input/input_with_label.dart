// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/config/resources/styles.dart';
import 'package:flutter_base_bloc/core/config/themes/app_theme.dart';
import 'package:flutter_base_bloc/utils/style_utils.dart';

class InputWithLabel<T extends Widget> extends StatelessWidget {
  final String label;
  final bool isRequired;
  final T child;
  const InputWithLabel({
    super.key,
    required this.label,
    this.isRequired = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: AppTextStyle.boldText,
              ),
              if (isRequired)
                TextSpan(
                  text: '*',
                  style: AppTextStyle.boldText.copyWith(
                    color: AppTheme.getInstance().statusFail,
                  ),
                ),
            ],
          ),
        ),
        spaceH8,
        child,
      ],
    );
  }
}
