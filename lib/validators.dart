abstract class Validators {
  static String? validateEmail(String? email) {
    final regex = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+");
    final errorMessage = 'Please enter a valid email adress';

    if (email == null || email.isEmpty) {
      return errorMessage;
    }

    if (regex.hasMatch(email)) {
      return null;
    }

    return errorMessage;
  }

  static String? validateTwoWords(String? str) {
    final regex = RegExp(r"^\S+\s\S+$");
    final errorMessage = 'Please enter your last name and first name';

    if (str == null || str.isEmpty) {
      return errorMessage;
    }

    if (regex.hasMatch(str)) {
      return null;
    }

    return errorMessage;
  }

  static String? validatePassword(String? str) {
    final regex = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$");
    final errorMessage = 'Please enter a valid password';

    if (str == null || str.isEmpty) {
      return errorMessage;
    }

    if (regex.hasMatch(str)) {
      return null;
    }

    return errorMessage;
  }
}
