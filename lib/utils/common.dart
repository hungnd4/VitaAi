import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/network/di/module.dart';
import 'package:flutter_base_bloc/domain/locals/prefs_service.dart';
import 'package:flutter_base_bloc/gen/translations.g.dart';
import 'package:fluttertoast/fluttertoast.dart';

void exitApp() {
  PrefsService.clearAuthData().then((_) {
    final context = getIt.get<GlobalKey<NavigatorState>>().currentContext;
    if (context != null && context.mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(LocaleKeys.exit.tr()),
          content: Text(LocaleKeys.confirmExit.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(LocaleKeys.cancel.tr()),
            ),
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: Text(LocaleKeys.yes.tr()),
            ),
          ],
        ),
      );
    }
  });
}

void showToast(String message,
    {Toast? toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.TOP,
    double? fontSize}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
    gravity: gravity,
    fontSize: fontSize,
  );
}
