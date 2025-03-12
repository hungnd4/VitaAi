import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/config/resources/color.dart';
import 'package:flutter_base_bloc/core/config/resources/dimens.dart';
import 'package:flutter_base_bloc/core/config/resources/styles.dart';
import 'package:flutter_base_bloc/gen/assets.gen.dart';
import 'package:flutter_base_bloc/gen/translations.g.dart';
import 'package:flutter_base_bloc/presentation/widgets/button/app_button.dart';
import 'package:flutter_base_bloc/presentation/widgets/textField/text_field_common.dart';
import 'package:flutter_base_bloc/utils/style_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController textInputControl = TextEditingController();
  TextEditingController passInputControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 64, 24, 0),
        child: Column(
          children: [
            Center(
              child: Assets.images.logo.image(),
            ),
            spaceH24,
            Text(
              LocaleKeys.login.tr(),
              style: AppTextStyle.interBoldText,
            ),
            spaceH24,
            TextFieldCommon(hintText: 'Email', controller: textInputControl),
            spaceH16,
            TextFieldCommon(
              hintText: LocaleKeys.password.tr(),
              controller: passInputControl,
              isPassword: true,
            ),
            spaceH16,
            AppButton(
              width: double.infinity,
              title: LocaleKeys.login.tr(),
              color: colorF17C9B,
              style: AppTextStyle.interBoldText.copyWith(
                fontWeight: FontWeight.w500,
                color: colorWhite,
              ),
            ),
            spaceH24,
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    height: Dimens.d1,
                    color: colorGrey51,
                  ),
                ),
                FittedBox(
                  child: Expanded(
                    flex: 3,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Dimens.d2),
                      child: Text(
                        LocaleKeys.orContinueWith.tr(),
                        style: AppTextStyle.interText,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    height: Dimens.d1,
                    color: colorGrey51,
                  ),
                ),
              ],
            ),
            spaceH24,
            AppButton(
              width: double.infinity,
              title: LocaleKeys.google.tr(),
              color: colorEEEEEE,
              style: AppTextStyle.interBoldText.copyWith(
                fontWeight: FontWeight.w500,
              ),
              icon: Assets.icons.icGoogle.svg(),
            ),
            spaceH24,
            AppButton(
              width: double.infinity,
              title: LocaleKeys.facebook.tr(),
              color: colorEEEEEE,
              style: AppTextStyle.interBoldText.copyWith(
                fontWeight: FontWeight.w500,
              ),
              icon: Assets.icons.icFacebook.svg(
                width: Dimens.d25.w,
                height: Dimens.d25.h,
              ),
            ),
            spaceH24,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.dontHaveAnAccount.tr(),
                  style: AppTextStyle.interText,
                ),
                spaceW5,
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    LocaleKeys.signUp.tr(),
                    style: AppTextStyle.interText.copyWith(
                      color: colorF17C9B,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
