import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/config/resources/language.dart';
import 'package:flutter_base_bloc/core/config/router/go_router.dart';
import 'package:flutter_base_bloc/utils/extensions/app_dimen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/config/themes/app_theme.dart';
import 'utils/constants/app_constants.dart';
import 'utils/constants/device_constants.dart';

Widget startApp() {
  return _easyLocaltionConfig(
    _screenUtilInit(
      const AppScreen(),
    ),
  );
}

ScreenUtilInit _screenUtilInit(Widget app) => ScreenUtilInit(
      designSize: const Size(
        DeviceConstants.designDeviceWidth,
        DeviceConstants.designDeviceHeight,
      ),
      builder: (context, child) => app,
    );

EasyLocalization _easyLocaltionConfig(Widget child) => EasyLocalization(
      supportedLocales: AppLanguages.supportedLanguages,
      path: AppLanguages.assetPath,
      fallbackLocale: AppLanguages.en,
      child: child,
    );

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppDimen.of(context);
    return MaterialApp.router(
      title: AppConstants.appName,
      routerConfig: appRouterConfig,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        dialogBackgroundColor: AppTheme.getInstance().secondaryColor,
      ),
    );
  }
}
