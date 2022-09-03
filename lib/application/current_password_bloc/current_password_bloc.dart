import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/core/failure.dart';
import 'package:password_manager/domain/entities/password.dart';
import 'package:password_manager/domain/repositories/storage_repository.dart';

part 'current_password_event.dart';
part 'current_password_state.dart';

class CurrentPasswordBloc
    extends Bloc<CurrentPasswordEvent, CurrentPasswordState> {
  CurrentPasswordBloc({required StorageRepository storageRepository})
      : _storageRepository = storageRepository,
        super(CurrentPasswordState.initial()) {
    on<PasswordRead>(_onStorageRead);
  }
  final StorageRepository _storageRepository;

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
}
