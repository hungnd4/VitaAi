import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/base/page/base_scafold.dart';
import 'package:flutter_base_bloc/core/config/resources/color.dart';
import 'package:flutter_base_bloc/core/config/resources/dimens.dart';
import 'package:flutter_base_bloc/core/config/resources/styles.dart';
import 'package:flutter_base_bloc/core/config/router/router_name.dart';
import 'package:flutter_base_bloc/gen/translations.g.dart';
import 'package:flutter_base_bloc/presentation/signup_page/component/item_box.dart';
import 'package:flutter_base_bloc/presentation/widgets/button/app_button.dart';
import 'package:flutter_base_bloc/utils/style_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final num1Controller = TextEditingController();
  final num2Controller = TextEditingController();
  final num3Controller = TextEditingController();
  final num4Controller = TextEditingController();

  @override
  void dispose() {
    num1Controller.dispose();
    num2Controller.dispose();
    num3Controller.dispose();
    num4Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      showBackButton: false,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.fromLTRB(Dimens.d24, Dimens.d64, Dimens.d24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.verificationCode.tr(),
                style: AppTextStyle.interBoldText.copyWith(
                  fontSize: 24.sp,
                ),
              ),
              spaceH8,
              Text(
                LocaleKeys.verifyCode.tr(),
                style: AppTextStyle.interText,
              ),
              spaceH24,
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ItemBoxForm(
                      controllerItem: num1Controller,
                      hintTextItem: '0',
                    ),
                    ItemBoxForm(
                      controllerItem: num2Controller,
                      hintTextItem: '0',
                    ),
                    ItemBoxForm(
                      controllerItem: num3Controller,
                      hintTextItem: '0',
                    ),
                    ItemBoxForm(
                      controllerItem: num4Controller,
                      hintTextItem: '0',
                    ),
                  ],
                ),
              ),
              spaceH24,
              AppButton(
                width: double.infinity,
                title: LocaleKeys.send.tr(),
                color: colorPrimary,
                style: AppTextStyle.interBoldText.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorWhite,
                ),
                onTap: () => context.goNamed(
                  RoutesName.password.name,
                ),
              ),
              spaceH16,
              Row(
                children: [
                  Text(
                    LocaleKeys.resendIn.tr(),
                    style: AppTextStyle.interText,
                  ),
                  spaceW4,
                  Text(
                    '0:10',
                    style: AppTextStyle.interBoldText.copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
