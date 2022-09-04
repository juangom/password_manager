part of 'current_password_bloc.dart';

abstract class CurrentPasswordEvent {}

class PasswordRead extends CurrentPasswordEvent {
  final String path;
  PasswordRead({
    required this.path,
  });
}

class PasswordEdited extends CurrentPasswordEvent {
  final PasswordValue passwordValue;
  final PasswordPath path;
  PasswordEdited({
    required this.passwordValue,
    required this.path,
  });
}

class PasswordCopied extends CurrentPasswordEvent {
  final PasswordPath path;

  PasswordCopied(this.path);
}
