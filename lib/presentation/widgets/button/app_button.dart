import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/config/resources/dimens.dart';
import 'package:flutter_base_bloc/core/config/resources/styles.dart';
import 'package:flutter_base_bloc/core/config/themes/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Widget? icon;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? color;
  final LinearGradient? gradient;
  final double? width;
  final bool? enabled;

  const AppButton({
    super.key,
    required this.title,
    this.onTap,
    this.borderRadius,
    this.padding,
    this.icon,
    this.style,
    this.color,
    this.gradient,
    this.width,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled == false ? null : onTap?.call,
      child: Container(
        width: width,
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: Dimens.d12.w,
              vertical: Dimens.d8.h,
            ),
        decoration: BoxDecoration(
          color: enabled == false ? AppTheme.getInstance().primaryColor : color,
          border: Border.all(
            color: (color != null || gradient != null)
                ? Colors.transparent
                : AppTheme.getInstance().primaryColor,
          ),
          borderRadius: BorderRadius.circular(
            borderRadius ?? 8.r,
          ),
          gradient: enabled == false
              ? LinearGradient(
                  colors: [
                    AppTheme.getInstance().primaryColor,
                    AppTheme.getInstance().primaryColor,
                  ],
                )
              : gradient,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: EdgeInsets.only(right: 4),
                child: icon!,
              ),
            Flexible(
              child: FittedBox(
                child: Text(
                  title,
                  style: style ??
                      AppTextStyle.boldText.copyWith(
                        color: AppTheme.getInstance().secondaryColor,
                        fontSize: 12.sp,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
