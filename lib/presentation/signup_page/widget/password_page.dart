import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/base/page/base_scafold.dart';
import 'package:flutter_base_bloc/core/config/resources/color.dart';
import 'package:flutter_base_bloc/core/config/resources/dimens.dart';
import 'package:flutter_base_bloc/core/config/resources/styles.dart';
import 'package:flutter_base_bloc/core/config/router/router_name.dart';
import 'package:flutter_base_bloc/gen/translations.g.dart';
import 'package:flutter_base_bloc/presentation/widgets/button/app_button.dart';
import 'package:flutter_base_bloc/presentation/widgets/textField/text_form_field_common.dart';
import 'package:flutter_base_bloc/utils/common.dart';
import 'package:flutter_base_bloc/utils/constants/regex_constants.dart';
import 'package:flutter_base_bloc/utils/style_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _formkey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                LocaleKeys.creatPassword.tr(),
                style: AppTextStyle.interBoldText.copyWith(
                  fontSize: 24.sp,
                ),
              ),
              spaceH8,
              Text(
                LocaleKeys.labelPassword.tr(),
                style: AppTextStyle.interText,
              ),
              spaceH24,
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormFieldCommon(
                      maxLength: 20,
                      hintText: LocaleKeys.password.tr(),
                      controller: passwordController,
                      isPassword: true,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            errorText: LocaleKeys.errorPasswordTwo.tr(),
                          ),
                          FormBuilderValidators.match(
                            RegExp(RegexConstants.PASSWORD_REGEX),
                            errorText: LocaleKeys.errorPasswordOne.tr(),
                          ),
                        ],
                      ),
                    ),
                    spaceH16,
                    TextFormFieldCommon(
                      maxLength: 20,
                      hintText: LocaleKeys.confirmPassword.tr(),
                      controller: confirmPasswordController,
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
              spaceH24,
              AppButton(
                width: double.infinity,
                title: LocaleKeys.confirm.tr(),
                color: colorPrimary,
                style: AppTextStyle.interBoldText.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorWhite,
                ),
                onTap: () {
                  if (_formkey.currentState!.validate() &&
                      passwordController.text ==
                          confirmPasswordController.text) {
                    context.goNamed(RoutesName.login.name);
                    showToast(LocaleKeys.registrationSuccessful.tr());
                  } else {
                    showToast(LocaleKeys.error.tr());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
