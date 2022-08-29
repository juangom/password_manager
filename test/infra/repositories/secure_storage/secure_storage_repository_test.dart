import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_manager/domain/entities/password_metadata.dart';
import 'package:password_manager/infra/repositories/storage/secure_storage.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}



void main() {
  final metadata = PasswordMetadata(
    name: 'name',
    id: 'id',
    username: 'user',
    created: DateTime.now(),
  );
  group('Test SecureStorageRepository Success', () {
    MockFlutterSecureStorage mockFlutterSecureStorage = MockFlutterSecureStorage();
    SecureStorageRepository storageRepository =
        SecureStorageRepository(storage: mockFlutterSecureStorage);

    when(() => mockFlutterSecureStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'))).thenAnswer((_) => Future.value(1));
    when(() => mockFlutterSecureStorage.containsKey(key: any(named: 'key')))
        .thenAnswer((_) => Future.value(true));
    when(() => mockFlutterSecureStorage.read(key: any(named: 'key')))
        .thenAnswer((_) => Future.value('123'));
    when(() => mockFlutterSecureStorage.delete(key: any(named: 'key')))
        .thenAnswer((_) => Future.value(1));
    when(() => mockFlutterSecureStorage.deleteAll())
        .thenAnswer((_) => Future.value(1));

    test('Test addPassword Success', () async {
      final result = await storageRepository.addPassword(metadata, '');
      expect(result.isSome(), false);
    });

    test('Test getPassword Success', () async {
      final result = await storageRepository.getPassword(metadata);
      expect(result.isRight(), true);
    });

    test('Test updatePassword Success', () async {
      final result = await storageRepository.updatePassword(metadata, '');
      expect(result.isSome(), false);
    });

    test('Test deletePassword Success', () async {
      final result = await storageRepository.deletePassword(metadata);
      expect(result.isSome(), false);
    });

    test('Test deleteAll Success', () async {
      final result = await storageRepository.deleteAll();
      expect(result.isSome(), false);
    });
  });

  group('Test does not contain key', () {
    MockFlutterSecureStorage mockFlutterSecureStorage = MockFlutterSecureStorage();
    SecureStorageRepository storageRepository =
        SecureStorageRepository(storage: mockFlutterSecureStorage);

    when(() => mockFlutterSecureStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'))).thenAnswer((_) => Future.value(1));
    when(() => mockFlutterSecureStorage.containsKey(key: any(named: 'key')))
        .thenAnswer((_) => Future.value(false));
    when(() => mockFlutterSecureStorage.read(key: any(named: 'key')))
        .thenAnswer((_) => Future.value('123'));
    when(() => mockFlutterSecureStorage.delete(key: any(named: 'key')))
        .thenAnswer((_) => Future.value(1));
    when(() => mockFlutterSecureStorage.deleteAll())
        .thenAnswer((_) => Future.value(1));

    test('Test getPassword Fails', () async {
      final result = await storageRepository.getPassword(metadata);
      expect(result.isLeft(), true);
    });
  });

  group('Test SecureStorageRepository Failures', () {
    MockFlutterSecureStorage mockFlutterSecureStorage = MockFlutterSecureStorage();
    SecureStorageRepository storageRepository =
        SecureStorageRepository(storage: mockFlutterSecureStorage);


    when(() => mockFlutterSecureStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'))).thenThrow(Exception('Fail'));
    when(() => mockFlutterSecureStorage.containsKey(key: any(named: 'key')))
        .thenThrow(Exception('Fail'));
    when(() => mockFlutterSecureStorage.read(key: any(named: 'key')))
        .thenThrow(Exception('Fail'));
    when(() => mockFlutterSecureStorage.delete(key: any(named: 'key')))
        .thenThrow(Exception('Fail'));
    when(() => mockFlutterSecureStorage.deleteAll()).thenThrow(Exception('Fail'));
    test('Test addPassword Fails', () async {
      final result = await storageRepository.addPassword(metadata, '');
      expect(result.isSome(), true);
    });

    test('Test getPassword Fails', () async {
      final result = await storageRepository.getPassword(metadata);
      expect(result.isLeft(), true);
    });

    test('Test updatePassword Fails', () async {
      final result = await storageRepository.updatePassword(metadata, '');
      expect(result.isSome(), true);
    });

    test('Test deletePassword Fails', () async {
      final result = await storageRepository.deletePassword(metadata);
      expect(result.isSome(), true);
    });

    test('Test deleteAll Fails', () async {
      final result = await storageRepository.deleteAll();
      expect(result.isSome(), true);
    });
  });
}
