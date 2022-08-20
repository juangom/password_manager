import 'package:dartz/dartz.dart';
import 'package:password_manager/core/failure.dart';
import 'package:password_manager/domain/entities/password_metadata.dart';
import 'package:password_manager/domain/values/password_metadata_value.dart';

abstract class PasswordListRepository {
  Future<Either<Failure, List<PasswordMetadata>>> loadPasswords();
  Future<Either<Failure, PasswordMetadata>> addPassword(
    PasswordMetadataValue passwordValue,
  );
  Future<Either<Failure, List<PasswordMetadata>>> deletePassword(
      PasswordMetadata password);
}
