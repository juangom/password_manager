part of 'current_password_bloc.dart';

class CurrentPasswordState extends Equatable {
  final Password password;
  final Option<Failure> failureOption;
  final String message;
  const CurrentPasswordState({
    required this.password,
    required this.failureOption,
    required this.message,
  });
  CurrentPasswordState.initial()
      : password = '',
        failureOption = none(),
        message = '';
  @override
  List<Object?> get props => [password, failureOption, message];

  CurrentPasswordState copyWith({
    Password? password,
    Option<Failure>? failureOption,
    String? message,
  }) {
    return CurrentPasswordState(
      password: password ?? this.password,
      failureOption: failureOption ?? this.failureOption,
      message: message ?? this.message,
    );
  }
}
