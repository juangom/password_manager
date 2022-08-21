import 'package:equatable/equatable.dart';

class PasswordMetadata extends Equatable {
  final String id;
  final String name;
  final String username;
  final String? url;
  final DateTime created;
  const PasswordMetadata({
    required this.id,
    required this.name,
    required this.username,
    this.url,
    required this.created,
  });

  @override
  List<Object?> get props => [id];
}
