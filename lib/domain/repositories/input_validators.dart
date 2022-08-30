String? nonEmptyValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Value must not be null';
  }
}
