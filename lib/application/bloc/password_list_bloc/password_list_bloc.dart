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
  final PasswordListRepository _passwordMetadataRepository;
  final StorageRepository _storageRepository;
  PasswordListBloc({
    required PasswordListRepository repository,
    required StorageRepository storageRepository,
  })  : _passwordMetadataRepository = repository,
        _storageRepository = storageRepository,
        super(PasswordListBlocState.initial()) {
    on<PasswordListLoaded>(_onPasswordLoaded);
    on<PasswordAdded>(_onPasswordAdded);
    on<PasswordStored>(_onPasswordStored);
    on<PasswordListCleared>(_onPasswordListCleared);
    on<StorageCleared>(_onStorageCleared);
    on<PasswordRemoved>(_onPasswordRemoved);
    on<PasswordDeleted>(_onPasswordDeleted);
  }

  void _onPasswordLoaded(
    PasswordListLoaded event,
    Emitter<PasswordListBlocState> emit,
  ) async {
    // await _passwordMetadataRepository.clearDB();
    final result = await _passwordMetadataRepository.loadPasswords();
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
    final metadataResult =
        await _passwordMetadataRepository.addPassword(event.metadataValue);
    metadataResult.fold(
      (failure) => emit(state.copyWith(failureOption: some(failure))),
      (metadata) {
        add(PasswordStored(
          metadata: metadata,
          passwordValue: event.passwordValue,
        ));
      },
    );
  }

  void _onPasswordStored(
    PasswordStored event,
    Emitter<PasswordListBlocState> emit,
  ) async {
    final result = await _storageRepository.addPassword(
      event.metadata.id,
      event.passwordValue,
    );
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

  void _onPasswordListCleared(
    PasswordListCleared event,
    Emitter<PasswordListBlocState> emit,
  ) async {
    final result = await _passwordMetadataRepository.clearDB();
    result.fold(
      () => add(StorageCleared()),
      (failure) => emit(state.copyWith(failureOption: some(failure))),
    );
  }

  void _onStorageCleared(
    StorageCleared event,
    Emitter<PasswordListBlocState> emit,
  ) async {
    final result = await _storageRepository.deleteAll();
    result.fold(
      () => emit(PasswordListBlocState.initial()),
      (failure) => emit(state.copyWith(failureOption: some(failure))),
    );
  }

  void _onPasswordRemoved(
    PasswordRemoved event,
    Emitter<PasswordListBlocState> emit,
  ) async {
    final result =
        await _passwordMetadataRepository.deletePassword(event.metadata);
    result.fold(
      () => add(PasswordDeleted(
        path: event.metadata.id,
        index: event.index,
      )),
      (failure) => emit(state.copyWith(failureOption: some(failure))),
    );
  }

  void _onPasswordDeleted(
    PasswordDeleted event,
    Emitter<PasswordListBlocState> emit,
  ) async {
    final result = await _storageRepository.deletePassword(event.path);
    result.fold(
      () {
        final List<PasswordMetadata> newList = List.from(state.metadataList);
        newList.removeAt(event.index);
        emit(state.copyWith(
          failureOption: none(),
          metadataList: newList,
        ));
      },
      (failure) => emit(state.copyWith(failureOption: some(failure))),
    );
  }
}
