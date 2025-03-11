import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/config/resources/styles.dart';
import 'package:flutter_base_bloc/core/config/themes/app_theme.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  final bool showAppBar;
  final String title;
  final Widget body;
  final Widget? bottomNavigationBar;
  final VoidCallback? customBackAction;
  final bool showBackButton;
  final List<Widget>? appbarAction;
  const AppScaffold({
    super.key,
    this.showAppBar = true,
    this.title = '',
    required this.body,
    this.bottomNavigationBar,
    this.customBackAction,
    this.showBackButton = true,
    this.appbarAction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              leading: showBackButton
                  ? IconButton(
                      onPressed: customBackAction ??
                          () {
                            context.pop();
                          },
                      icon: Icon(
                        CupertinoIcons.back,
                        color: AppTheme.getInstance().formColor,
                      ),
                    )
                  : null,
              title: Text(
                title,
                style: AppTextStyle.boldText.copyWith(
                  color: AppTheme.getInstance().formColor,
                ),
              ),
              centerTitle: true,
              backgroundColor: AppTheme.getInstance().primaryColor,
              actions: appbarAction,
            )
          : null,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
