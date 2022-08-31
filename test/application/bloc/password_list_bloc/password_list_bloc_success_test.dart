import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_manager/application/bloc/password_list_bloc/password_list_bloc.dart';
import 'package:password_manager/domain/entities/password_metadata.dart';
import 'package:password_manager/domain/repositories/password_repository.dart';
import 'package:password_manager/domain/repositories/storage_repository.dart';
import 'package:password_manager/domain/values/password_metadata_value.dart';

class MockPasswordListRepository extends Mock
    implements PasswordListRepository {}

class MockStorageRepository extends Mock implements StorageRepository {}

void main() {
  final initialState = PasswordListBlocState.initial();
  final passwordMetadata = PasswordMetadata(
    id: '1',
    name: 'name',
    username: 'user',
    created: DateTime.now(),
  );
  final passwordMetadataValue = PasswordMetadataValue(
    name: 'x',
    username: 'y',
  );

  registerFallbackValue(passwordMetadata);
  registerFallbackValue(passwordMetadataValue);

  group('Test Bloc Initial State', () {
    MockPasswordListRepository mockPasswordListRepository =
        MockPasswordListRepository();
    MockStorageRepository mockStorageRepository = MockStorageRepository();

    when(() => mockPasswordListRepository.loadPasswords())
        .thenAnswer((_) => Future.value(right([])));
    blocTest(
      'Initial state when nothing is added',
      build: () => PasswordListBloc(
        repository: mockPasswordListRepository,
        storageRepository: mockStorageRepository,
      ),
      act: (PasswordListBloc bloc) => bloc.add(PasswordListLoaded()),
      expect: () => [initialState],
      wait: const Duration(seconds: 1),
    );
  });

  group('Test Load', () {
    MockPasswordListRepository mockPasswordListRepository =
        MockPasswordListRepository();
    MockStorageRepository mockStorageRepository = MockStorageRepository();
    final finalState = PasswordListBlocState(
      metadataList: [passwordMetadata],
      failureOption: none(),
    );

    when(() => mockPasswordListRepository.loadPasswords())
        .thenAnswer((_) => Future.value(right([passwordMetadata])));

    blocTest(
      'Loads one item',
      build: () => PasswordListBloc(
        repository: mockPasswordListRepository,
        storageRepository: mockStorageRepository,
      ),
      act: (PasswordListBloc bloc) => bloc.add(PasswordListLoaded()),
      expect: () => [finalState],
      wait: const Duration(seconds: 1),
    );
  });

  group('Test Add', () {
    MockPasswordListRepository mockPasswordListRepository =
        MockPasswordListRepository();
    MockStorageRepository mockStorageRepository = MockStorageRepository();
    final finalState = PasswordListBlocState(
      metadataList: [passwordMetadata],
      failureOption: none(),
    );

    when(() => mockPasswordListRepository.addPassword(any()))
        .thenAnswer((_) => Future.value(right(passwordMetadata)));
    when(() => mockStorageRepository.addPassword(any(), any()))
        .thenAnswer((_) => Future.value(none()));
    blocTest(
      'Adds one item',
      build: () => PasswordListBloc(
        repository: mockPasswordListRepository,
        storageRepository: mockStorageRepository,
      ),
      act: (PasswordListBloc bloc) => bloc.add(PasswordAdded(
        passwordValue: 'password',
        metadataValue: passwordMetadataValue,
      )),
      expect: () => [finalState],
      wait: const Duration(seconds: 1),
    );
  });
}
