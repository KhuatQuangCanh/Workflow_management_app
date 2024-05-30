class CFirebaseException implements Exception {
  final String code;

  CFirebaseException(this.code);

  String get message {
    switch (code) {
    // Mã lỗi Authentication
      case 'INVALID_EMAIL':
        return 'The email address is badly formatted.';
      case 'USER_DISABLED':
        return 'The user account has been disabled by an administrator.';
      case 'USER_NOT_FOUND':
        return 'There is no user record corresponding to this identifier. The user may have been deleted.';
      case 'WRONG_PASSWORD':
        return 'The password is invalid or the user does not have a password.';
      case 'EMAIL_ALREADY_IN_USE':
        return 'The email address is already in use by another account.';
      case 'OPERATION_NOT_ALLOWED':
        return 'Password sign-in is disabled for this project.';
      case 'WEAK_PASSWORD':
        return 'The password must be 6 characters long or more.';
      case 'TOO_MANY_REQUESTS':
        return 'We have blocked all requests from this device due to unusual activity. Try again later.';

    // Mã lỗi Firestore
      case 'PERMISSION_DENIED':
        return 'The caller does not have permission to execute the specified operation.';
      case 'NOT_FOUND':
        return 'The document was not found.';
      case 'ALREADY_EXISTS':
        return 'The document already exists.';
      case 'FAILED_PRECONDITION':
        return 'The operation was rejected because the system is not in a state required for the operation\'s execution.';
      case 'ABORTED':
        return 'The operation was aborted, typically due to a concurrency issue like transaction aborts, etc.';
      case 'OUT_OF_RANGE':
        return 'The operation was attempted past the valid range.';

    // Mã lỗi Realtime Database
      case 'DISCONNECTED':
        return 'The operation had to be aborted due to a network disconnect.';
      case 'EXPIRED_TOKEN':
        return 'The supplied auth token has expired.';
      case 'INVALID_TOKEN':
        return 'The supplied auth token is invalid.';
      case 'MAX_RETRIES':
        return 'The transaction had too many retries.';
      case 'NETWORK_ERROR':
        return 'A network error occurred.';
      case 'OVERRIDDEN_BY_SET':
        return 'The transaction was overridden by a subsequent set.';

    // Mã lỗi Storage
      case 'OBJECT_NOT_FOUND':
        return 'No object exists at the desired reference.';
      case 'BUCKET_NOT_FOUND':
        return 'No bucket is configured for Firebase Storage.';
      case 'PROJECT_NOT_FOUND':
        return 'No project is configured for Firebase Storage.';
      case 'QUOTA_EXCEEDED':
        return 'Quota on your Firebase Storage bucket has been exceeded.';
      case 'UNAUTHENTICATED':
        return 'User is unauthenticated. Authenticate and try again.';
      case 'UNAUTHORIZED':
        return 'User is not authorized to perform the desired action.';

    // Mã lỗi chung
      case 'NETWORK_REQUEST_FAILED':
        return 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.';
      case 'INTERNAL_ERROR':
        return 'An internal error has occurred. Please try again.';
      case 'UNKNOWN_ERROR':
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }

  @override
  String toString() {
    return 'TFirebaseException(code: $code, message: $message)';
  }
}
