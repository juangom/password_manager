part of 'password_list_bloc.dart';

abstract class PasswordListBlocEvent {}

class PasswordListLoaded extends PasswordListBlocEvent {}

class PasswordAdded extends PasswordListBlocEvent {
  final PasswordValue passwordValue;
  final PasswordMetadataValue metadataValue;

  PasswordAdded({
    required this.passwordValue,
    required this.metadataValue,
  });
}

class PasswordDeleted extends PasswordListBlocEvent {
  final PasswordPath path;

  PasswordDeleted(this.path);
}

class PasswordEdited extends PasswordListBlocEvent {
  final PasswordValue passwordValue;
  final PasswordPath path;
  PasswordEdited({
    required this.passwordValue,
    required this.path,
  });
}
