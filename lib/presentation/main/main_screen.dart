import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/base/page/base_page_state.dart';
import 'package:flutter_base_bloc/core/base/page/base_scafold.dart';
import 'package:flutter_base_bloc/core/config/resources/dimens.dart';
import 'package:flutter_base_bloc/core/config/resources/language.dart';
import 'package:flutter_base_bloc/core/config/themes/app_theme.dart';
import 'package:flutter_base_bloc/gen/assets.gen.dart';
import 'package:flutter_base_bloc/presentation/chat_bot_page/chat_bot_page.dart';
import 'package:flutter_base_bloc/presentation/main/common/enum.dart';
import 'package:flutter_base_bloc/presentation/home_page/home_page.dart';
import 'package:flutter_base_bloc/presentation/news_page/news_page.dart';
import 'package:flutter_base_bloc/presentation/settings_page/setting_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/main_bloc.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(),
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BasePageState<HomeScreen, MainBloc> {
  final _pageController = PageController();

  @override
  void initState() {
    bloc.add(const MainEvent.getAllUser());
    bloc.add(const MainEvent.getUserInfo());
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
      body: BlocListener<MainBloc, MainState>(
        listenWhen: (previous, current) =>
            previous.currentPageType != current.currentPageType,
        listener: (context, state) {
          _pageController.animateToPage(
            state.currentPageType.pageIndex,
            curve: Curves.linearToEaseOut,
            duration: const Duration(
              milliseconds: 300,
            ),
          );
        },
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomePageProvider(),
            ChatBotPage(),
            NewsPage(),
            SettingPage(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[200],
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Assets.icons.icCamera.svg(
          colorFilter: ColorFilter.mode(
            AppTheme.getInstance().chipColor,
            BlendMode.srcIn,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BlocSelector<MainBloc, MainState, PageType>(
        selector: (state) {
          return state.currentPageType;
        },
        builder: (context, state) {
          return AnimatedBottomNavigationBar.builder(
            itemCount: PageType.values.length,
            tabBuilder: (index, isActive) {
              final page = PageType.values[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  page.svgGenImage.svg(
                    colorFilter: ColorFilter.mode(
                      isActive
                          ? AppTheme.getInstance().shadow6
                          : AppTheme.getInstance().chipColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              );
            },
            activeIndex: state.pageIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            leftCornerRadius: Dimens.d32,
            rightCornerRadius: Dimens.d32,
            backgroundColor: Colors.pink[200],
            onTap: (index) {
              bloc.add(MainEvent.changePage(PageType.values[index]));
            },
          );
        },
      ),
    );
  }
}
