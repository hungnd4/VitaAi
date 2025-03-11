import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/network/di/module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../exception/exception_wrapper.dart';
import '../../helper/dispose_bag.dart';
import '../../config/themes/app_theme.dart';
import '../bloc/base_bloc.dart';
import '../common/common_bloc.dart';

abstract class BasePageState<T extends StatefulWidget, B extends BaseBloc>
    extends BasePageStateDelegate<T, B> {}

abstract class BasePageStateDelegate<T extends StatefulWidget,
    B extends BaseBloc> extends State<T> {
  B get bloc => context.read<B>();

  CommonBloc get commonBloc => getIt.get();

  late final DisposeBag disposeBag;
  @override
  void initState() {
    disposeBag = DisposeBag();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommonBloc, CommonState>(
      bloc: commonBloc,
      listenWhen: (previous, current) {
        log(previous.toString());
        log(current.toString());
        return previous.wrapper != current.wrapper &&
            current.wrapper?.exception != null;
      },
      listener: (context, state) {
        log(state.wrapper?.exception.message ?? 'NO EXCEPTION');
        handleException(state.wrapper!);
      },
      child: buildPageListeners(
        child: Stack(
          children: [
            buildPage(context),
            BlocBuilder<CommonBloc, CommonState>(
              bloc: commonBloc,
              buildWhen: (previous, current) =>
                  previous.isLoading != current.isLoading,
              builder: (context, state) => Visibility(
                visible: state.isLoading,
                child: buildPageLoading(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPageListeners({required Widget child}) => child;

  Widget buildPageLoading() => BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2,
          sigmaY: 2,
        ),
        child: Center(
          child: CircularProgressIndicator(
            color: AppTheme.getInstance().statusFail,
          ),
        ),
      );

  Widget buildPage(BuildContext context);

  @override
  void dispose() {
    super.dispose();
    disposeBag.dispose();
  }

  void handleException(ExceptionWrapper wrapper) {
    bloc.exceptionHandler.handleException(wrapper);
  }
}
