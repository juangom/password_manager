import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/core/failure.dart';
import 'package:password_manager/domain/entities/password.dart';
import 'package:password_manager/domain/repositories/copy_repository.dart';
import 'package:password_manager/domain/repositories/storage_repository.dart';
import 'package:password_manager/domain/values/password_path.dart';
import 'package:password_manager/domain/values/password_value.dart';

part 'current_password_event.dart';
part 'current_password_state.dart';

class CurrentPasswordBloc
    extends Bloc<CurrentPasswordEvent, CurrentPasswordState> {
  CurrentPasswordBloc({
    required StorageRepository storageRepository,
    required CopyRepository copyRepository,
  })  : _storageRepository = storageRepository,
        _copyRepository = copyRepository,
        super(CurrentPasswordState.initial()) {
    on<PasswordRead>(_onStorageRead);
    on<PasswordEdited>(_onPasswordEdited);
    on<PasswordCopied>(_onPasswordCopied);
    on<PasswordCopiedToClipboard>(_onPasswordCopiedToClipboard);
  }
  final StorageRepository _storageRepository;
  final CopyRepository _copyRepository;

  void _onStorageRead(
    PasswordRead event,
    Emitter<CurrentPasswordState> emit,
  ) async {
    final result = await _storageRepository.getPassword(event.path);
    result.fold(
      (failure) => emit(state.copyWith(failureOption: some(failure))),
      (password) => emit(state.copyWith(
        failureOption: none(),
        password: password,
      )),
    );
  }

  void _onPasswordEdited(
    PasswordEdited event,
    Emitter<CurrentPasswordState> emit,
  ) async {}

  void _onPasswordCopied(
    PasswordCopied event,
    Emitter<CurrentPasswordState> emit,
  ) async {
    final passwordResult = await _storageRepository.getPassword(event.path);
    passwordResult.fold(
      (failure) => emit(state.copyWith(failureOption: some(failure))),
      (password) => add(PasswordCopiedToClipboard(password: password)),
    );
  }

  void _onPasswordCopiedToClipboard(
    PasswordCopiedToClipboard event,
    Emitter<CurrentPasswordState> emit,
  ) async {
    final result = await _copyRepository.copy(state.password);
    result.fold(
      () => emit(state.copyWith(message: 'Password copied')),
      (failure) => emit(state.copyWith(failureOption: some(failure))),
    );
  }
}
