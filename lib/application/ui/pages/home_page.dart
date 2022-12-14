import 'package:flutter/material.dart';
import 'package:password_manager/application/ui/pages/password_list_page.dart';
import 'package:password_manager/application/ui/widgets/dialogs/clear_passwords.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                showClearPasswordsDialog(context);
              },
              icon: const Icon(Icons.delete_forever),
            ),
          ],
        ),
        body: const PasswordListPage(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamed('new_password');
          },
          label: const Text('New'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
