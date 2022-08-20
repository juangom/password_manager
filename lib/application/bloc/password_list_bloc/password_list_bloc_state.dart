part of 'password_list_bloc.dart';

class PasswordListBlocState extends Equatable {
  final List<PasswordMetadata> metadataList;
  final Option<Failure> failureOption;
  const PasswordListBlocState({
    required this.metadataList,
    required this.failureOption,
  });

  PasswordListBlocState.initial()
      : metadataList = [],
        failureOption = none();

  @override
  List<Object?> get props => [metadataList, failureOption];

  PasswordListBlocState copyWith({
    List<PasswordMetadata>? metadataList,
    Option<Failure>? failureOption,
  }) {
    return PasswordListBlocState(
      metadataList: metadataList ?? this.metadataList,
      failureOption: failureOption ?? this.failureOption,
    );
  }
}
