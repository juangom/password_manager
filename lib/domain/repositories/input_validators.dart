String? nonEmptyValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'This value must not be empty';
  }
  return null;
}
