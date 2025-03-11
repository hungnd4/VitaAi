import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/domain/entities/user.dart';

class UserItem extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;

  const UserItem({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Name: '),
                Text(user.name ?? ''),
              ],
            ),
            Row(
              children: [
                const Text('Email: '),
                Text(user.email ?? ''),
              ],
            ),
            if (user.age != null)
              Row(
                children: [
                  const Text('Age: '),
                  Text(user.age.toString()),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
