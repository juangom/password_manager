class PasswordMetadataValue {
  final String name;
  final String username;
  final String? url;
  final String? notes;
  PasswordMetadataValue({
    required this.name,
    required this.username,
    this.url,
    this.notes,
  });
}
