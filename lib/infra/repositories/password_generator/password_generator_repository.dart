import 'package:dartz/dartz.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:password_manager/domain/entities/password.dart';
import 'package:password_manager/core/failure.dart';
import 'package:password_manager/domain/repositories/password_generator_repository.dart';

class DartPasswordGeneratorRepository extends PasswordGeneratorRepository {
  final _generator = RandomPasswordGenerator();
  @override
  Future<Either<Failure, Password>> generatePassword(
      {required int length}) async {
    return right(_generator.randomPassword());
  }

  @override
  Future<Either<Failure, double>> getPasswordStrength(Password password) async {
    return right(_generator.checkPassword(password: password));
  }
}
