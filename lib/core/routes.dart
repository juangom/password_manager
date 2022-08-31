import 'package:flutter/material.dart';
import 'package:password_manager/application/ui/pages/home_page.dart';
import 'package:password_manager/application/ui/pages/new_password_page.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'new_password':
      return MaterialPageRoute(
        builder: (_) => const NewPasswordPage(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const HomePage(),
      );
  }
}
