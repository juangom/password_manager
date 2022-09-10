import 'package:dartz/dartz.dart';
import 'package:password_manager/core/failure.dart';
import 'package:password_manager/domain/entities/password.dart';

abstract class PasswordGeneratorRepository {
  Future<Either<Failure, Password>> generatePassword({required int length});
  Future<Either<Failure, double>> getPasswordStrength(Password password);
}
