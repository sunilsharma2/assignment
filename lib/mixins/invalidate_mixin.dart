mixin InvalidateMixin
{
  bool isEmailValid(String email) {
    RegExp regex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    final passwordRegExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return passwordRegExp.hasMatch(password);
  }
}

bool isValidText(String text) {
  if (text.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}