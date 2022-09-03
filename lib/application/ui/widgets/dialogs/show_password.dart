import 'package:flutter/material.dart';

void showPasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      content: const Text('Password?'),
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
