class CPlatformException implements Exception {
  final String code;

  CPlatformException(this.code);

  String get message {
    switch (code) {
    // Mã lỗi đăng nhập
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please double-check your information.';
      case 'TOO_MANY_REQUESTS':
        return 'Too many requests. Please try again later.';
      case 'USER_NOT_FOUND':
        return 'User not found. Please register first.';
      case 'NETWORK_ERROR':
        return 'Network error. Please check your internet connection.';
      case 'UNAUTHORIZED':
        return 'Unauthorized access. Please log in.';
      case 'ACCOUNT_LOCKED':
        return 'Your account has been locked. Please contact support.';

    // Mã lỗi đăng ký
      case 'EMAIL_ALREADY_IN_USE':
        return 'The email address is already in use. Please use a different email.';
      case 'INVALID_EMAIL_FORMAT':
        return 'Invalid email format. Please check your email address.';
      case 'PASSWORD_TOO_WEAK':
        return 'Password is too weak. Please choose a stronger password.';
      case 'USERNAME_ALREADY_IN_USE':
        return 'The username is already in use. Please choose a different username.';
      case 'INVALID_USERNAME_FORMAT':
        return 'Invalid username format. Please choose a valid username.';
      case 'AGE_RESTRICTION':
        return 'You must be at least 18 years old to register.';
      case 'TERMS_NOT_ACCEPTED':
        return 'You must accept the terms and conditions to register.';

    // Mã lỗi chung
      case 'SERVER_ERROR':
        return 'Server error. Please try again later.';
      case 'UNKNOWN_ERROR':
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }

  @override
  String toString() {
    return 'TPlatformException(code: $code, message: $message)';
  }
}
