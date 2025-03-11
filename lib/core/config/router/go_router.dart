import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/network/di/module.dart';
import 'package:flutter_base_bloc/domain/locals/prefs_service.dart';
import 'package:flutter_base_bloc/presentation/home/home_screen.dart';
import 'package:flutter_base_bloc/presentation/screen_one/screen_one.dart';
import 'package:go_router/go_router.dart';

import 'router_name.dart';

GoRoute _defaultGorouter({
  required RoutesGen router,
  required Widget page,
  List<GoRoute> goRoutes = const [],
}) =>
    GoRoute(
      path: router.path,
      name: router.name,
      routes: goRoutes,
      builder: (BuildContext context, GoRouterState state) {
        return page;
      },
    );

// ignore: unused_element
GoRoute _transitionRouter({
  required RoutesGen router,
  required Widget page,
  List<GoRoute> goRoutes = const [],
}) =>
    GoRoute(
      path: router.path,
      name: router.name.isNotEmpty ? router.name : null,
      routes: goRoutes,
      redirect: (BuildContext context, GoRouterState state) {
        if (PrefsService.getToken().isEmpty &&
            state.name != RoutesName.register.name) {
          return RoutesName.login.path;
        }
        return null;
      },
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    );

final GoRouter appRouterConfig = GoRouter(
  navigatorKey: getIt.get<GlobalKey<NavigatorState>>(),
  initialLocation: RoutesName.home.path,
  routes: <RouteBase>[
    _defaultGorouter(
      router: RoutesName.home,
      page: const Home(),
      goRoutes: [
        _defaultGorouter(
          router: RoutesName.screenOne,
          page: const ScreenOne(),
        ),
      ],
    ),
  ],
);
