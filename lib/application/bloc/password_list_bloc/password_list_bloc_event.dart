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

class PasswordStored extends PasswordListBlocEvent {
  PasswordValue passwordValue;
  PasswordMetadata metadata;
  PasswordStored({
    required this.passwordValue,
    required this.metadata,
  });
}

class PasswordDeleted extends PasswordListBlocEvent {
  final PasswordPath path;

  PasswordDeleted(this.path);
}

class PasswordListCleared extends PasswordListBlocEvent {}

class StorageCleared extends PasswordListBlocEvent {}
