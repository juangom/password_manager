import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_manager/domain/entities/password_metadata.dart';
import 'package:password_manager/infra/repositories/storage/secure_storage.dart';
import 'package:password_manager/infra/repositories/storage/secure_storage_module.dart';

class MockStorageBackend extends Mock implements SecureStorageModule {}

void main() {
  final backend = MockStorageBackend();
  final SecureStorageRepository storageRepository =
      SecureStorageRepository(backend: backend);

  group('Test SecureStorageRepository Failures', () {
    when(() => backend.storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'))).thenThrow(Exception('Fail'));
    test('Test addPassword Fails', () async {
      final result = await storageRepository.addPassword(
          PasswordMetadata(
            name: 'name',
            path: 'path',
            created: DateTime.now(),
          ),
          '');
      expect(result.isSome(), true);
    });

    test('Test getPassword Fails', () async {
      final result = await storageRepository.getPassword(PasswordMetadata(
        name: 'name',
        path: 'path',
        created: DateTime.now(),
      ));
      expect(result.isLeft(), true);
    });

    test('Test updatePassword Fails', () async {
      final result = await storageRepository.updatePassword(
          PasswordMetadata(
            name: 'name',
            path: 'path',
            created: DateTime.now(),
          ),
          '');
      expect(result.isSome(), true);
    });

    test('Test deletePassword Fails', () async {
      final result = await storageRepository.deletePassword(PasswordMetadata(
        name: 'name',
        path: 'path',
        created: DateTime.now(),
      ));
      expect(result.isSome(), true);
    });

    test('Test deleteAll Fails', () async {
      final result = await storageRepository.deleteAll();
      expect(result.isSome(), true);
    });
  });
}
