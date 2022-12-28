String? validateEmail(String email) {
  final regex = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+");

  return regex.hasMatch(email) ? null : 'Invalid email adress';
}
