part of 'password_generator_bloc.dart';

class PasswordGeneratorState extends Equatable {
  final Option<Password> password;
  final Option<Failure> failureOption;
  const PasswordGeneratorState({
    required this.password,
    required this.failureOption,
  });

  PasswordGeneratorState.initial()
      : password = none(),
        failureOption = none();
  @override
  List<Object?> get props => [password, failureOption];

  PasswordGeneratorState copyWith({
    Option<Password>? password,
    Option<Failure>? failureOption,
  }) {
    return PasswordGeneratorState(
      password: password ?? this.password,
      failureOption: failureOption ?? this.failureOption,
    );
  }
}
