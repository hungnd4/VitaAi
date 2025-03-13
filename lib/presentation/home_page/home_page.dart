import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/base/page/base_page_state.dart';
import 'package:flutter_base_bloc/core/config/router/router_name.dart';
import 'package:flutter_base_bloc/presentation/home_page/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePageProvider extends StatelessWidget {
  const HomePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage, HomeBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          context.goNamed(
            RoutesName.screenOne.name,
          );
        },
        child: const Text('Home Page'),
      ),
    );
  }
}
