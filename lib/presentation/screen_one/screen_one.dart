import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/base/page/base_page_state.dart';
import 'package:flutter_base_bloc/core/base/page/base_scafold.dart';
import 'package:flutter_base_bloc/gen/assets.gen.dart';
import 'package:flutter_base_bloc/presentation/screen_one/bloc/screen_one_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScreenOneBloc(),
      child: const ScreenOneScreen(),
    );
  }
}

class ScreenOneScreen extends StatefulWidget {
  const ScreenOneScreen({super.key});

  @override
  State<ScreenOneScreen> createState() => _ScreenOneScreenState();
}

class _ScreenOneScreenState
    extends BasePageState<ScreenOneScreen, ScreenOneBloc> {
  @override
  void initState() {
    bloc.add(const ScreenOneEvent.onLoadApi());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return AppScaffold(
      title: 'Screen One',
      body: BlocBuilder<ScreenOneBloc, ScreenOneState>(
        builder: (context, state) {
          return Center(
            child: state.dataStatus == FetchStatus.success
                ? Assets.images.onboardingFirst.image()
                : const Text('Loading data'),
          );
        },
      ),
    );
  }
}
