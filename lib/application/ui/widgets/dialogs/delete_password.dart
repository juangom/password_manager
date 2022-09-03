import 'package:flutter/material.dart';

void deletePasswordDialog(BuildContext context) {
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
            Navigator.of(context).pop();
          },
          child: const Text('Show'),
        ),
      ],
    ),
  );
}
