String? validateUsername(String name, int minlength) {
  if (name.length >= minlength && name.length < 10) return null;

  return 'Too short';
}
