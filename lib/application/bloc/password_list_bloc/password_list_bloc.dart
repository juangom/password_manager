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
  }

  void _onPasswordLoaded(
    PasswordListLoaded event,
    Emitter<PasswordListBlocState> emit,
  ) async {
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
      (metadata) async {
        final storageResult =
            await _storageRepository.addPassword(metadata, event.passwordValue);
        storageResult.fold(
          () => emit(
            state.copyWith(
              metadataList: [...state.metadataList, metadata],
            ),
          ),
          (failure) => emit(
            state.copyWith(
              failureOption: some(failure),
            ),
          ),
        );
      },
    );
    // final result = await _storageRepository.
  }
}
