import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password_manager/domain/entities/password_metadata.dart';
import 'package:password_manager/domain/entities/password.dart';
import 'package:password_manager/core/failure.dart';
import 'package:password_manager/domain/repositories/storage_repository.dart';
import 'package:password_manager/domain/values/password_value.dart';

class SecureStorageRepository extends StorageRepository {
  final _storage = const FlutterSecureStorage();

  @override
  Future<Option<Failure>> addPassword(
    PasswordMetadata metadata,
    PasswordValue password,
  ) async {
    try {
      await _storage.write(key: metadata.path, value: password);
      return none();
    } catch (e) {
      return optionOf(Failure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Password>> getPassword(
      PasswordMetadata metadata) async {
    try {
      if (!await _storage.containsKey(key: metadata.path)) {
        return left(Failure(msg: 'Password not found'));
      }
      final result = await _storage.read(key: metadata.path);
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
      if (!await _storage.containsKey(key: metadata.path)) {
        return optionOf(Failure(msg: 'Password not found'));
      }
      await _storage.delete(key: metadata.path);
      await _storage.write(key: metadata.path, value: newPassword);
      return none();
    } catch (e) {
      return optionOf(Failure(msg: e.toString()));
    }
  }

  @override
  Future<Option<Failure>> deletePassword(PasswordMetadata metadata) async {
    try {
      if (!await _storage.containsKey(key: metadata.path)) {
        return optionOf(Failure(msg: 'Password not found'));
      }
      await _storage.delete(key: metadata.path);
      return none();
    } catch (e) {
      return optionOf(Failure(msg: e.toString()));
    }
  }

  @override
  Future<Option<Failure>> deleteAll() async {
    try {
      await _storage.deleteAll();
      return none();
    } catch (e) {
      return optionOf(Failure(msg: e.toString()));
    }
  }
}
