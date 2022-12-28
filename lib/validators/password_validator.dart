String? validatePassword(String password) {
  if (password.length > 6) return null;
  return 'At least 6 caracters';
}