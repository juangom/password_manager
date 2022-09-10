import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_manager/application/bloc/password_generator_bloc/password_generator_bloc.dart';
import 'package:password_manager/infra/repositories/password_generator/password_generator_repository.dart';

class MockDartPasswordGeneratorRepository extends Mock
    implements DartPasswordGeneratorRepository {}

void main() {
  group('Test generatePassword success', () {
    final initialState = PasswordGeneratorState.initial();
    final MockDartPasswordGeneratorRepository dartPasswordGeneratorRepository =
        MockDartPasswordGeneratorRepository();
    const randomPassword = 'password123';

    when(() => dartPasswordGeneratorRepository.generatePassword(
            length: any(named: 'length')))
        .thenAnswer((_) async => right(randomPassword));
    blocTest(
      'It should return a password when event called',
      build: () => PasswordGeneratorBloc(
        repository: dartPasswordGeneratorRepository,
      ),
      act: (PasswordGeneratorBloc bloc) =>
          bloc.add(PasswordGenerated(length: 50)),
      expect: () => [initialState.copyWith(password: some(randomPassword))],
    );
  });

  // group('Test checkPasswordStrength success', () {
  //   final initialState = PasswordGeneratorState.initial();
  //   final MockDartPasswordGeneratorRepository dartPasswordGeneratorRepository =
  //       MockDartPasswordGeneratorRepository();
  //   const passwordStrength = 1;

  //   when(() => dartPasswordGeneratorRepository.getPasswordStrength(any()))
  //       .thenAnswer((_) async => right(passwordStrength));
  //   blocTest(
  //     'It should return a password when event called',
  //     build: () => PasswordGeneratorBloc(
  //       repository: dartPasswordGeneratorRepository,
  //     ),
  //     act: (PasswordGeneratorBloc bloc) =>
  //         bloc.add(PasswordGenerated(length: 50)),
  //     expect: () => [initialState.copyWith(password: some(randomPassword))],
  //   );
  // });
}
