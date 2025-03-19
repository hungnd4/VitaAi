import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/base/page/base_scafold.dart';
import 'package:flutter_base_bloc/core/config/resources/color.dart';
import 'package:flutter_base_bloc/core/config/resources/dimens.dart';
import 'package:flutter_base_bloc/core/config/resources/styles.dart';
import 'package:flutter_base_bloc/core/config/router/router_name.dart';
import 'package:flutter_base_bloc/gen/translations.g.dart';
import 'package:flutter_base_bloc/presentation/signup_page/bloc/signup_bloc.dart';
import 'package:flutter_base_bloc/presentation/signup_page/component/item_box.dart';
import 'package:flutter_base_bloc/presentation/widgets/button/app_button.dart';
import 'package:flutter_base_bloc/utils/style_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class VerifyPageProvider extends StatelessWidget {
  const VerifyPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: const VerifyPage(),
    );
  }
}

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final _formkey = GlobalKey<FormState>();
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(4, (_) => TextEditingController());
    focusNodes = List.generate(4, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel();
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
                key: _formkey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    return ItemBoxForm(
                      controllerItem: controllers[index],
                      hintTextItem: '0',
                      currentFocus: focusNodes[index],
                      nextFocus: index < 3 ? focusNodes[index + 1] : null,
                      previousFocus: index > 0 ? focusNodes[index - 1] : null,
                    );
                  }),
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
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    context.goNamed(RoutesName.password.name);
                  }
                },
              ),
              spaceH16,
              BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Text(
                        LocaleKeys.resendIn.tr(),
                        style: AppTextStyle.interText,
                      ),
                      spaceW4,
                      Text(
                        "0:${state.remainTime.toString().padLeft(2, '0')}",
                        style: AppTextStyle.interBoldText
                            .copyWith(fontSize: 14.sp),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (state.isFirstTime || state.remainTime == 0) {
                            context
                                .read<SignupBloc>()
                                .add(const SignupEvent.startCountdown());
                          }
                        },
                        child: Text(
                          'Gửi lại',
                          style: AppTextStyle.interBoldText.copyWith(
                            fontSize: 14.sp,
                            color: (state.isFirstTime || state.remainTime == 0)
                                ? colorPrimary
                                : Colors.grey,
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
