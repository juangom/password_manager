import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/application/bloc/password_list_bloc/password_list_bloc.dart';

void showClearPasswordsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Delete all your passwords?'),
      content:
          const Text('Are you sure you want to delete all your passwords?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            context.read<PasswordListBloc>().add(PasswordListCleared());
            Navigator.of(context).pop();
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}
