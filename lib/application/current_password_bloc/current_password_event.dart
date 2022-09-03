part of 'current_password_bloc.dart';

abstract class CurrentPasswordEvent {}

class PasswordRead extends CurrentPasswordEvent {
  final String path;
  PasswordRead({
    required this.path,
  });
}
