import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/core/failure.dart';
import 'package:password_manager/domain/entities/password.dart';
import 'package:password_manager/domain/repositories/password_generator_repository.dart';

part 'password_generator_event.dart';
part 'password_generator_state.dart';

class PasswordGeneratorBloc
    extends Bloc<PasswordGeneratorEvent, PasswordGeneratorState> {
  final PasswordGeneratorRepository _repository;
  PasswordGeneratorBloc({
    required PasswordGeneratorRepository repository,
  })  : _repository = repository,
        super(PasswordGeneratorState.initial()) {
    on<PasswordGenerated>(_onPasswordGenerated);
  }

  void _onPasswordGenerated(
    PasswordGenerated event,
    Emitter<PasswordGeneratorState> emit,
  ) async {
    final result = await _repository.generatePassword(length: event.length);
    result.fold(
      (failure) => emit(state.copyWith(failureOption: some(failure))),
      (password) => emit(state.copyWith(
        failureOption: none(),
        password: some(password),
      )),
    );
  }
}
