bool isEValid(String email) {
  // Regular expression for email validation
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

extension EmailValidator on String {
  bool get isEmailValid => isEValid(this);
}
