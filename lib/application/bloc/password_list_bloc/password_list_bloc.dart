import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/core/failure.dart';
import 'package:password_manager/domain/entities/password_metadata.dart';
import 'package:password_manager/domain/repositories/password_repository.dart';
import 'package:password_manager/domain/repositories/storage_repository.dart';
import 'package:password_manager/domain/values/password_metadata_value.dart';
import 'package:password_manager/domain/values/password_path.dart';
import 'package:password_manager/domain/values/password_value.dart';

part 'password_list_bloc_event.dart';
part 'password_list_bloc_state.dart';

class PasswordListBloc
    extends Bloc<PasswordListBlocEvent, PasswordListBlocState> {
  final PasswordListRepository _repository;
  final StorageRepository _storageRepository;
  PasswordListBloc({
    required PasswordListRepository repository,
    required StorageRepository storageRepository,
  })  : _repository = repository,
        _storageRepository = storageRepository,
        super(PasswordListBlocState.initial()) {
    on<PasswordListLoaded>(_onPasswordLoaded);
    on<PasswordAdded>(_onPasswordAdded);
    on<PasswordStored>(_onPasswordStored);
  }

  void _onPasswordLoaded(
    PasswordListLoaded event,
    Emitter<PasswordListBlocState> emit,
  ) async {
    await _repository.clearDB();
    final result = await _repository.loadPasswords();
    result.fold(
      (failure) => emit(state.copyWith(
        failureOption: some(failure),
      )),
      (list) => emit(state.copyWith(metadataList: list)),
    );
  }

  void _onPasswordAdded(
    PasswordAdded event,
    Emitter<PasswordListBlocState> emit,
  ) async {
    final metadataResult = await _repository.addPassword(event.metadataValue);
    metadataResult.fold(
      (failure) => emit(state.copyWith(failureOption: some(failure))),
      (metadata) {
        add(PasswordStored(
          metadata: metadata,
          passwordValue: event.passwordValue,
        ));
      },
    );
    // final result = await _storageRepository.
  }

  void _onPasswordStored(
    PasswordStored event,
    Emitter<PasswordListBlocState> emit,
  ) async {
    final result = await _storageRepository.addPassword(
        event.metadata, event.passwordValue);
    result.fold(
      () => emit(
        state.copyWith(
          metadataList: [...state.metadataList, event.metadata],
        ),
      ),
      (failure) => emit(
        state.copyWith(
          failureOption: some(failure),
        ),
      ),
    );
  }
}
