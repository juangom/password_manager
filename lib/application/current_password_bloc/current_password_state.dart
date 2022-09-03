part of 'current_password_bloc.dart';

class CurrentPasswordState extends Equatable {
  final Password password;
  final Option<Failure> failureOption;
  const CurrentPasswordState({
    required this.password,
    required this.failureOption,
  });
  CurrentPasswordState.initial()
      : password = '',
        failureOption = none();
  @override
  List<Object?> get props => [password, failureOption];

  CurrentPasswordState copyWith({
    Password? password,
    Option<Failure>? failureOption,
  }) {
    return CurrentPasswordState(
      password: password ?? this.password,
      failureOption: failureOption ?? this.failureOption,
    );
  }
}
