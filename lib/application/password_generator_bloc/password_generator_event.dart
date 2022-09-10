part of 'password_generator_bloc.dart';

abstract class PasswordGeneratorEvent {}

class PasswordGenerated extends PasswordGeneratorEvent {
  final int length;
  PasswordGenerated({
    required this.length,
  });
}
