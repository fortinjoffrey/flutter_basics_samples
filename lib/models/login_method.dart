enum LoginMethod {
  none,
  email,
  google,
  apple,
  facebook,
}

LoginMethod getLoginMehodFromString(String? value) {
  if (value == null) return LoginMethod.none;

  switch (value) {
    case 'none':
      return LoginMethod.none;
    case 'email':
      return LoginMethod.email;
    case 'google':
      return LoginMethod.google;
    case 'apple':
      return LoginMethod.apple;
    case 'facebook':
      return LoginMethod.facebook;
    default:
      return LoginMethod.none;
  }
}
