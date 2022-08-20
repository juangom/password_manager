class PasswordMetadata {
  final String name;
  final String path;
  final String? url;
  final DateTime created;
  PasswordMetadata({
    required this.name,
    required this.path,
    this.url,
    required this.created,
  });
}
