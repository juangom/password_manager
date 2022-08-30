import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_manager/core/failure.dart';
import 'package:password_manager/domain/entities/password_metadata.dart';
import 'package:password_manager/domain/values/password_metadata_value.dart';
import 'package:password_manager/infra/repositories/password_metadata/drift/tables.dart';
import 'package:password_manager/infra/repositories/password_metadata/password_list_repository.dart';

class MockDatabase extends Mock implements Database {}

// class MockDriftModule extends Mock implements DriftModule {}

void main() {
  final dbPassword = Password(
    id: '1',
    name: 'password',
    username: 'user',
    url: 'fsdfd',
    notes: '',
    created: DateTime.now(),
  );
  final metadata = PasswordMetadata(
    id: 'id',
    name: 'name',
    username: 'username',
    created: DateTime.now(),
  );

  final metadataValue =
      PasswordMetadataValue(name: 'sfdf', username: 'sdf', url: 'sfdf');

  registerFallbackValue(
    const PasswordsCompanion(
      name: Value('sdf'),
      username: Value('user'),
      url: Value('fsdf'),
    ),
  );
  registerFallbackValue(dbPassword);

  group('Test PasswordMetadataRepository Success', () {
    MockDatabase db = MockDatabase();
    DriftPasswordListRepository passwordListRepository =
        DriftPasswordListRepository(db: db);

    when(() => db.allPasswords).thenAnswer((_) => Future.value([]));
    when(() => db.add(any())).thenAnswer((_) => Future.value(dbPassword));
    when(() => db.remove(any())).thenAnswer((_) => Future.value(1));

    test('Test Load All Passwords', () async {
      final result = await passwordListRepository.loadPasswords();
      expect(result.isLeft(), false);
    });

    test('Test Add Password', () async {
      final result = await passwordListRepository.addPassword(metadataValue);
      expect(result.isLeft(), false);
    });

    test('Test Delete Password', () async {
      final result = await passwordListRepository.deletePassword(metadata);
      expect(result.isSome(), false);
    });
  });

  group('Test PasswordMetadataRepository Failure', () {
    MockDatabase db = MockDatabase();
    DriftPasswordListRepository passwordListRepository =
        DriftPasswordListRepository(db: db);

    final failure = Failure(msg: 'Fail');

    when(() => db.allPasswords).thenThrow((_) => Future.value(failure));
    when(() => db.add(any())).thenThrow((_) => Future.value(failure));
    when(() => db.remove(any())).thenThrow((_) => Future.value(failure));

    test('Test Load All Passwords', () async {
      final result = await passwordListRepository.loadPasswords();
      expect(result.isLeft(), true);
    });

    test('Test Add Password', () async {
      final result = await passwordListRepository.addPassword(metadataValue);
      expect(result.isLeft(), true);
    });

    test('Test Delete Password', () async {
      final result = await passwordListRepository.deletePassword(metadata);
      expect(result.isSome(), true);
    });
  });

  group('Test PasswordMetadataRepository Delete Returns Differrent Than 1', () {
    MockDatabase db = MockDatabase();
    DriftPasswordListRepository passwordListRepository =
        DriftPasswordListRepository(db: db);

    test('Test 0 Passwords Deleted', () async {
      when(() => db.remove(any())).thenAnswer((_) => Future.value(0));
      final result = await passwordListRepository.deletePassword(metadata);
      expect(result.isSome(), true);
    });

    test('Test  Passwords Deleted', () async {
      when(() => db.remove(any())).thenAnswer((_) => Future.value(2));
      final result = await passwordListRepository.deletePassword(metadata);
      expect(result.isSome(), true);
    });
  });
}
