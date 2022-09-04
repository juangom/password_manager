part of 'password_list_bloc.dart';

abstract class PasswordListBlocEvent {}

class PasswordListLoaded extends PasswordListBlocEvent {}

// Added to the list
class PasswordAdded extends PasswordListBlocEvent {
  final PasswordValue passwordValue;
  final PasswordMetadataValue metadataValue;

  PasswordAdded({
    required this.passwordValue,
    required this.metadataValue,
  });
}

// Added to the store
class PasswordStored extends PasswordListBlocEvent {
  PasswordValue passwordValue;
  PasswordMetadata metadata;
  PasswordStored({
    required this.passwordValue,
    required this.metadata,
  });
}

// Delete from the list
class PasswordListCleared extends PasswordListBlocEvent {}

// Remove from the storage
class StorageCleared extends PasswordListBlocEvent {}

// Delete from the list
class PasswordRemoved extends PasswordListBlocEvent {
  final PasswordMetadata metadata;
  final int index;
  PasswordRemoved({
    required this.metadata,
    required this.index,
  });
}

// Remove from the storage
class PasswordDeleted extends PasswordListBlocEvent {
  final PasswordPath path;
  final int index;
  PasswordDeleted({
    required this.path,
    required this.index,
  });
}
