import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_manager/application/bloc/current_password_bloc/current_password_bloc.dart';
import 'package:password_manager/domain/repositories/copy_repository.dart';
import 'package:password_manager/domain/repositories/storage_repository.dart';

class MockStorageRepository extends Mock implements StorageRepository {}

class MockCopyRepository extends Mock implements CopyRepository {}

void main() {
  final initialState = CurrentPasswordState.initial();
  group('Test Read Password Success', () {
    MockStorageRepository mockStorageRepository = MockStorageRepository();
    MockCopyRepository mockCopyRepository = MockCopyRepository();
    const String passwordResult = 'password';

    when(() => mockStorageRepository.getPassword(any()))
        .thenAnswer((_) async => right(passwordResult));

    blocTest(
      'Returns the password from storage',
      build: () => CurrentPasswordBloc(
        storageRepository: mockStorageRepository,
        copyRepository: mockCopyRepository,
      ),
      act: (CurrentPasswordBloc bloc) => bloc.add(PasswordRead(path: 'xyz')),
      expect: () => [initialState.copyWith(password: passwordResult)],
    );
  });

  group('Test Password Copy', () {
    MockStorageRepository mockStorageRepository = MockStorageRepository();
    MockCopyRepository mockCopyRepository = MockCopyRepository();
    const String passwordResult = 'password';

    when(() => mockStorageRepository.getPassword(any()))
        .thenAnswer((_) async => right(passwordResult));

    when(() => mockCopyRepository.copy(any())).thenAnswer((_) async => none());

    final expectedStates = [
      initialState.copyWith(
        message: 'Password copied',
      ),
    ];

    blocTest(
      'State contains message',
      build: () => CurrentPasswordBloc(
        storageRepository: mockStorageRepository,
        copyRepository: mockCopyRepository,
      ),
      act: (CurrentPasswordBloc bloc) => bloc.add(PasswordCopied(path: 'xyz')),
      expect: () => expectedStates,
    );
  });
}
