import 'package:flutter/material.dart';
import 'package:password_manager/application/ui/pages/edit_password_page.dart';
import 'package:password_manager/application/ui/pages/home_page.dart';
import 'package:password_manager/application/ui/pages/new_password_page.dart';
import 'package:password_manager/domain/entities/password_metadata.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'new_password':
      return MaterialPageRoute(
        builder: (_) => const NewPasswordPage(),
      );
    case 'edit_password':
      final metadata = settings.arguments as PasswordMetadata;
      return MaterialPageRoute(
        builder: (_) => EditNewPasswordPage(metadata: metadata),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const HomePage(),
      );
  }
}
