import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/domain/entities/password_metadata.dart';
import 'package:password_manager/domain/entities/password.dart';
import 'package:password_manager/core/failure.dart';
import 'package:password_manager/domain/repositories/storage_repository.dart';
import 'package:password_manager/domain/values/password_value.dart';

@Injectable(as: StorageRepository)
class SecureStorageRepository extends StorageRepository {
  final FlutterSecureStorage _storage;
  SecureStorageRepository({
    required FlutterSecureStorage storage,
  }) : _storage = storage;

  @override
  Future<Option<Failure>> addPassword(
    PasswordMetadata metadata,
    PasswordValue password,
  ) async {
    try {
      await _storage.write(key: metadata.id, value: password);
      return none();
    } catch (e) {
      return some(Failure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Password>> getPassword(
      PasswordMetadata metadata) async {
    try {
      if (!await _storage.containsKey(key: metadata.id)) {
        return left(const Failure(msg: 'Password not found'));
      }
      final result = await _storage.read(key: metadata.id);
      if (result == null) {
        return left(const Failure(msg: 'Password not found'));
      } else {
        return right(result);
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
      if (!await _storage.containsKey(key: metadata.id)) {
        return some(const Failure(msg: 'Password not found'));
      }
      await _storage.delete(key: metadata.id);
      await _storage.write(key: metadata.id, value: newPassword);
      return none();
    } catch (e) {
      return some(Failure(msg: e.toString()));
    }
  }

  @override
  Future<Option<Failure>> deletePassword(PasswordMetadata metadata) async {
    try {
      if (!await _storage.containsKey(key: metadata.id)) {
        return some(const Failure(msg: 'Password not found'));
      }
      await _storage.delete(key: metadata.id);
      return none();
    } catch (e) {
      return some(Failure(msg: e.toString()));
    }
  }

  @override
  Future<Option<Failure>> deleteAll() async {
    try {
      await _storage.deleteAll();
      return none();
    } catch (e) {
      return some(Failure(msg: e.toString()));
    }
  }
}
