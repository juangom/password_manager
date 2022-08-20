import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/domain/entities/password_metadata.dart';
import 'package:password_manager/domain/entities/password.dart';
import 'package:password_manager/core/failure.dart';
import 'package:password_manager/domain/repositories/storage_repository.dart';
import 'package:password_manager/domain/values/password_value.dart';
import 'package:password_manager/infra/repositories/storage/secure_storage_module.dart';

@Injectable(as: StorageRepository)
class SecureStorageRepository extends StorageRepository {
  final SecureStorageModule _backend;
  SecureStorageRepository({
    required SecureStorageModule backend,
  }) : _backend = backend;

  @override
  Future<Option<Failure>> addPassword(
    PasswordMetadata metadata,
    PasswordValue password,
  ) async {
    try {
      await _backend.storage.write(key: metadata.path, value: password);
      return none();
    } catch (e) {
      return optionOf(Failure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Password>> getPassword(
      PasswordMetadata metadata) async {
    try {
      if (!await _backend.storage.containsKey(key: metadata.path)) {
        return left(Failure(msg: 'Password not found'));
      }
      final result = await _backend.storage.read(key: metadata.path);
      if (result == null) {
        return left(Failure(msg: 'Password not found'));
      } else {
        return right(Password(result));
      }
    } catch (e) {
      return left(Failure(msg: e.toString()));
    }
  }

  @override
  Future<Option<Failure>> updatePassword(
    PasswordMetadata metadata,
    PasswordValue newPassword,
  ) async {
    try {
      if (!await _backend.storage.containsKey(key: metadata.path)) {
        return optionOf(Failure(msg: 'Password not found'));
      }
      await _backend.storage.delete(key: metadata.path);
      await _backend.storage.write(key: metadata.path, value: newPassword);
      return none();
    } catch (e) {
      return optionOf(Failure(msg: e.toString()));
    }
  }

  @override
  Future<Option<Failure>> deletePassword(PasswordMetadata metadata) async {
    try {
      if (!await _backend.storage.containsKey(key: metadata.path)) {
        return optionOf(Failure(msg: 'Password not found'));
      }
      await _backend.storage.delete(key: metadata.path);
      return none();
    } catch (e) {
      return optionOf(Failure(msg: e.toString()));
    }
  }

  @override
  Future<Option<Failure>> deleteAll() async {
    try {
      await _backend.storage.deleteAll();
      return none();
    } catch (e) {
      return optionOf(Failure(msg: e.toString()));
    }
  }
}
