extension StringX on String {
  // Property type with null operator stripped
  String get cleaned {
    if (endsWith('?')) {
      return substring(0, length - 1);
    }

    return this;
  }
}
