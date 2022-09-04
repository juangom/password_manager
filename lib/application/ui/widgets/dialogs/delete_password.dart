import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/application/bloc/password_list_bloc/password_list_bloc.dart';
import 'package:password_manager/domain/values/password_path.dart';

void deletePasswordDialog(
  BuildContext context,
  PasswordPath path,
) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Delete Password'),
      content: const Text('Are you sure you want to delete this password?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            context.read<PasswordListBloc>().add(PasswordDeleted(path));
            Navigator.of(context).pop();
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}
