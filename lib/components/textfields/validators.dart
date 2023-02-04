abstract class Validators {
  static String? validateEmail(String? email) {
    final regex = RegExp(r'[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+');
    const errorMessage = 'Please enter a valid email';

    if (email == null || email.isEmpty) {
      return errorMessage;
    }

    if (regex.hasMatch(email)) {
      return null;
    }

    return errorMessage;
  }

  static String? validateUsername(String? username) {
    final regex = RegExp(r'.{3,}');
    const errorMessage = 'Username should be at least 3 characters';

    if (username == null || username.isEmpty) {
      return errorMessage;
    }

    if (regex.hasMatch(username)) {
      return null;
    }

    return errorMessage;
  }
}
