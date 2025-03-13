import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/base/page/base_scafold.dart';
import 'package:flutter_base_bloc/core/config/resources/color.dart';
import 'package:flutter_base_bloc/core/config/resources/dimens.dart';
import 'package:flutter_base_bloc/core/config/resources/styles.dart';
import 'package:flutter_base_bloc/gen/assets.gen.dart';
import 'package:flutter_base_bloc/gen/translations.g.dart';
import 'package:flutter_base_bloc/presentation/widgets/button/app_button.dart';
import 'package:flutter_base_bloc/presentation/widgets/textField/text_field_common.dart';
import 'package:flutter_base_bloc/utils/style_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController textInputController = TextEditingController();
  TextEditingController passInputController = TextEditingController();
  @override
  void dispose() {
    textInputController.dispose();
    passInputController.dispose();
    super.dispose();
  }

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
              LocaleKeys.signUp.tr(),
              style: AppTextStyle.interBoldText,
            ),
            spaceH2,
            FittedBox(
              child: Text(
                LocaleKeys.enterYourPhone.tr(),
                style: AppTextStyle.interText,
              ),
            ),
            spaceH24,
            TextFieldCommon(
              hintText: LocaleKeys.sdt.tr(),
              controller: textInputController,
            ),
            spaceH16,
            AppButton(
              width: double.infinity,
              title: LocaleKeys.send.tr(),
              color: colorPrimary,
              style: AppTextStyle.interBoldText.copyWith(
                fontWeight: FontWeight.w500,
                color: colorWhite,
              ),
            ),
            spaceH24,
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: Dimens.d1,
                    color: colorGrey51,
                  ),
                ),
                FittedBox(
                  child: Expanded(
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
                  child: Container(
                    width: double.infinity,
                    height: Dimens.d1,
                    color: colorGrey51,
                  ),
                ),
              ],
            ),
            spaceH24,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(
                      side: BorderSide(color: colorGrey88, width: Dimens.d2),
                    ),
                  ),
                  icon: Assets.icons.icGoogle.svg(
                    width: 32.w,
                    height: 32.h,
                  ),
                ),
                spaceW16,
                IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(
                      side: BorderSide(color: colorGrey88, width: Dimens.d2),
                    ),
                  ),
                  icon: Assets.icons.icFacebook.svg(
                    width: 32.w,
                    height: 32.h,
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
