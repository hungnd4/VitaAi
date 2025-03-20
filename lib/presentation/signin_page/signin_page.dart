import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/base/page/base_scafold.dart';
import 'package:flutter_base_bloc/core/config/resources/color.dart';
import 'package:flutter_base_bloc/core/config/resources/dimens.dart';
import 'package:flutter_base_bloc/core/config/resources/styles.dart';
import 'package:flutter_base_bloc/core/config/router/router_name.dart';
import 'package:flutter_base_bloc/gen/assets.gen.dart';
import 'package:flutter_base_bloc/gen/translations.g.dart';
import 'package:flutter_base_bloc/presentation/widgets/button/app_button.dart';
import 'package:flutter_base_bloc/presentation/widgets/textField/text_form_field_common.dart';
import 'package:flutter_base_bloc/utils/constants/regex_constants.dart';
import 'package:flutter_base_bloc/utils/style_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

final _formkey = GlobalKey<FormState>();

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
    return AppScaffold(
      showBackButton: false,
      showAppBar: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                Dimens.d24, Dimens.d128, Dimens.d24, Dimens.d16),
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
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormFieldCommon(
                        maxLength: 10,
                        hintText: LocaleKeys.phoneNumber.tr(),
                        controller: textInputController,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: LocaleKeys.errorPhoneNumberOne.tr(),
                          ),
                          FormBuilderValidators.match(
                            RegExp(RegexConstants.VN_PHONE),
                            errorText: LocaleKeys.errorPhoneNumber.tr(),
                          ),
                        ]),
                      ),
                      spaceH16,
                      TextFormFieldCommon(
                        hintText: LocaleKeys.password.tr(),
                        controller: passInputController,
                        isPassword: true,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: LocaleKeys.errorPasswordTwo.tr(),
                          ),
                          FormBuilderValidators.match(
                            RegExp(RegexConstants.PASSWORD_REGEX),
                            errorText: LocaleKeys.errorPasswordOne.tr(),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                spaceH16,
                AppButton(
                  width: double.infinity,
                  title: LocaleKeys.login.tr(),
                  color: colorPrimary,
                  style: AppTextStyle.interBoldText.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorWhite,
                  ),
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      context.goNamed(RoutesName.main.name);
                    }
                  },
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
                    Expanded(
                      child: FittedBox(
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
                          side:
                              BorderSide(color: colorGrey88, width: Dimens.d2),
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
                          side:
                              BorderSide(color: colorGrey88, width: Dimens.d2),
                        ),
                      ),
                      icon: Assets.icons.icFacebook.svg(
                        width: 32.w,
                        height: 32.h,
                      ),
                    ),
                  ],
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
                      onTap: () {
                        context.goNamed(RoutesName.register.name);
                      },
                      child: Text(
                        LocaleKeys.signUp.tr(),
                        style: AppTextStyle.interText.copyWith(
                          color: colorPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
