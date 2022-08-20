import 'package:flutter/material.dart';
import 'package:password_manager/application/ui/pages/password_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PasswordListPage(),
      ),
    );
  }
}
