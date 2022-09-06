import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_manager/application/bloc/current_password_bloc/current_password_bloc.dart';
import 'package:password_manager/core/failure.dart';
import 'package:password_manager/domain/repositories/copy_repository.dart';
import 'package:password_manager/domain/repositories/storage_repository.dart';

class MockStorageRepository extends Mock implements StorageRepository {}

class MockCopyRepository extends Mock implements CopyRepository {}

void main() {
  final initialState = CurrentPasswordState.initial();
  group('Test Read Password Fails', () {
    MockStorageRepository mockStorageRepository = MockStorageRepository();
    MockCopyRepository mockCopyRepository = MockCopyRepository();
    const failure = Failure(msg: 'Failure');

    when(() => mockStorageRepository.getPassword(any()))
        .thenAnswer((_) async => left(failure));

    blocTest(
      'Returns the failure',
      build: () => CurrentPasswordBloc(
        storageRepository: mockStorageRepository,
        copyRepository: mockCopyRepository,
      ),
      act: (CurrentPasswordBloc bloc) => bloc.add(PasswordRead(path: 'xyz')),
      expect: () => [initialState.copyWith(failureOption: some(failure))],
    );
  });

  group('Test Password Copy Fails', () {
    MockStorageRepository mockStorageRepository = MockStorageRepository();
    MockCopyRepository mockCopyRepository = MockCopyRepository();
    const String passwordResult = 'password';
    const failure = Failure(msg: 'Failure');

    when(() => mockStorageRepository.getPassword(any()))
        .thenAnswer((_) async => right(passwordResult));

    when(() => mockCopyRepository.copy(any()))
        .thenAnswer((_) async => some(failure));

    blocTest(
      'State returns failure',
      build: () => CurrentPasswordBloc(
        storageRepository: mockStorageRepository,
        copyRepository: mockCopyRepository,
      ),
      act: (CurrentPasswordBloc bloc) => bloc.add(PasswordCopied(path: 'xyz')),
      expect: () => [initialState.copyWith(failureOption: some(failure))],
    );
  });
}
