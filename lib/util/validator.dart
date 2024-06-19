String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }

  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}

String? validateUserName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your name';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 character';
  }
  if (!RegExp(r'(?=.*?[A-Z])').hasMatch(value)) {
    return 'Password must include at least one uppercase letter';
  }
  if (!RegExp(r'(?=.*?[0-9])').hasMatch(value)) {
    return 'Password must include at least one digit';
  }
  if (!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(value)) {
    return 'Password must include at least one special character';
  }
  return null;
}

String? validateConfirmPassword(String? value, String pass) {
  if (value == null || value.isEmpty) {
    return 'Please confirm your password';
  }
  if (value != pass) {
    return 'Passwords do not match';
  }
  return null;
}
