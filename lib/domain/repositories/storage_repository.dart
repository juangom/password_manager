import 'package:dartz/dartz.dart';
import 'package:password_manager/core/failure.dart';
import 'package:password_manager/domain/entities/password.dart';
import 'package:password_manager/domain/entities/password_metadata.dart';
import 'package:password_manager/domain/values/password_value.dart';

abstract class StorageRepository {
  Future<Option<Failure>> addPassword(
    PasswordMetadata metadata,
    PasswordValue password,
  );
  Future<Either<Failure, Password>> getPassword(PasswordMetadata metadata);
  Future<Option<Failure>> deletePassword(PasswordMetadata metadata);
  Future<Option<Failure>> deleteAll();
  Future<Option<Failure>> updatePassword(
    PasswordMetadata metadata,
    PasswordValue newPassword,
  );
}
