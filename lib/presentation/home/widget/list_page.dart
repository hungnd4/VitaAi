import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_base_bloc/presentation/home/widget/user_items.dart';
import 'package:flutter_base_bloc/utils/style_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.err != current.err && previous.users != current.users,
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(const HomeEvent.getAllUser());
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
                          context.read<HomeBloc>().add(
                                HomeEvent.getUser(state.users[i].id ?? ''),
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
