class CFirebaseAuthException implements Exception {
  final String code;

  CFirebaseAuthException(this.code);

  String get message {
    switch (code) {
    // Mã lỗi đăng nhập
      case 'INVALID_EMAIL':
        return 'The email address is badly formatted.';
      case 'USER_DISABLED':
        return 'The user account has been disabled by an administrator.';
      case 'USER_NOT_FOUND':
        return 'There is no user record corresponding to this identifier. The user may have been deleted.';
      case 'WRONG_PASSWORD':
        return 'The password is invalid or the user does not have a password.';
      case 'TOO_MANY_REQUESTS':
        return 'We have blocked all requests from this device due to unusual activity. Try again later.';

    // Mã lỗi đăng ký
      case 'EMAIL_ALREADY_IN_USE':
        return 'The email address is already in use by another account.';
      case 'OPERATION_NOT_ALLOWED':
        return 'Password sign-in is disabled for this project.';
      case 'WEAK_PASSWORD':
        return 'The password must be 6 characters long or more.';

    // Mã lỗi chung
      case 'NETWORK_REQUEST_FAILED':
        return 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.';
      case 'REQUIRES_RECENT_LOGIN':
        return 'This operation is sensitive and requires recent authentication. Log in again before retrying this request.';
      case 'UNAUTHORIZED_DOMAIN':
        return 'This domain is not authorized for OAuth operations for your Firebase project. Edit the list of authorized domains from the Firebase console.';
      case 'INTERNAL_ERROR':
        return 'An internal error has occurred. Please try again.';

    // Mã lỗi không xác định
      case 'UNKNOWN_ERROR':
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }

  @override
  String toString() {
    return 'TFirebaseAuthException(code: $code, message: $message)';
  }
}
