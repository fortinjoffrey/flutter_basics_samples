enum LoginMethod {
  none,
  email,
  google,
  apple,
  facebook,
}

LoginMethod getLoginMehodFromString(String? value) {
  if (value == null) return LoginMethod.none;

  if (value == LoginMethod.none.name)
    return LoginMethod.none;
  else if (value == LoginMethod.email.name)
    return LoginMethod.email;
  else if (value == LoginMethod.google.name)
    return LoginMethod.google;
  else if (value == LoginMethod.apple.name)
    return LoginMethod.apple;
  else if (value == LoginMethod.facebook.name) return LoginMethod.facebook;

  throw Exception('Login method from string failed');
}
