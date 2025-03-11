import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/base/page/base_page_state.dart';
import 'package:flutter_base_bloc/core/base/page/base_scafold.dart';
import 'package:flutter_base_bloc/core/config/resources/language.dart';
import 'package:flutter_base_bloc/core/config/themes/app_theme.dart';
import 'package:flutter_base_bloc/presentation/home/widget/home_page.dart';
import 'package:flutter_base_bloc/presentation/home/widget/list_page.dart';
import 'package:flutter_base_bloc/utils/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BasePageState<HomeScreen, HomeBloc> {
  final _pageController = PageController();

  @override
  void initState() {
    bloc.add(const HomeEvent.getAllUser());
    bloc.add(const HomeEvent.getUserInfo());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return AppScaffold(
      title: 'HOME SCREEN',
      showBackButton: false,
      appbarAction: [
        InkWell(
          onTap: () {
            context.setLocale(
              context.locale == AppLanguages.vi
                  ? AppLanguages.en
                  : AppLanguages.vi,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppTheme.getInstance().primaryColor.withOpacity(0.6),
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              context.locale.languageCode,
            ),
          ),
        )
      ],
      body: BlocListener<HomeBloc, HomeState>(
        listenWhen: (previous, current) =>
            previous.currentPageIndex != current.currentPageIndex,
        listener: (context, state) {
          _pageController.animateToPage(
            state.currentPageIndex,
            curve: Curves.linearToEaseOut,
            duration: const Duration(
              milliseconds: 300,
            ),
          );
        },
        child: PageView(
          controller: _pageController,
          onPageChanged: (currentPage) {
            bloc.add(HomeEvent.changePage(currentPage));
          },
          children: const [
            HomePage(),
            ListPage(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppTheme.getInstance().primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocSelector<HomeBloc, HomeState, int>(
              selector: (state) {
                return state.currentPageIndex;
              },
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    bloc.add(const HomeEvent.changePage(0));
                  },
                  icon: Icon(
                    CupertinoIcons.home,
                    color: state == 0
                        ? const Color(0xff870333)
                        : AppTheme.getInstance().formColor,
                  ),
                );
              },
            ),
            BlocSelector<HomeBloc, HomeState, int>(
              selector: (state) {
                return state.currentPageIndex;
              },
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    bloc.add(const HomeEvent.changePage(1));
                  },
                  icon: Icon(
                    CupertinoIcons.list_dash,
                    color: state == 1
                        ? const Color(0xff870333)
                        : AppTheme.getInstance().formColor,
                  ),
                );
              },
            ),
            IconButton(
              onPressed: () {
                exitApp();
              },
              icon: Icon(
                CupertinoIcons.power,
                color: AppTheme.getInstance().formColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
