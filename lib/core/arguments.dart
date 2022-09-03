import 'package:password_manager/domain/entities/password.dart';
import 'package:password_manager/domain/entities/password_metadata.dart';

class PasswordFormArguments {
  final PasswordMetadata metadata;
  final Password password;
  PasswordFormArguments({
    required this.metadata,
    required this.password,
  });
}
