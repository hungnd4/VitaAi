import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/presentation/main/bloc/main_bloc.dart';
import 'package:flutter_base_bloc/presentation/main/widget/user_items.dart';
import 'package:flutter_base_bloc/utils/style_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      buildWhen: (previous, current) =>
          previous.err != current.err && previous.users != current.users,
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<MainBloc>().add(const MainEvent.getAllUser());
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: (state.err == null)
                ? ListView.separated(
                    itemCount: state.users.length,
                    itemBuilder: (_, i) {
                      return UserItem(
                        user: state.users[i],
                        onTap: () {
                          context.read<MainBloc>().add(
                                MainEvent.getUser(state.users[i].id ?? ''),
                              );
                        },
                      );
                    },
                    separatorBuilder: (_, __) => spaceH10,
                  )
                : Center(
                    child: Text(state.err?.message ?? ''),
                  ),
          ),
        );
      },
    );
  }
}
