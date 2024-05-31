
class CFormatException implements Exception {
  /// The associated error message
  final String message;

  /// Default constructor with a generic error message.
  const CFormatException([this.message = 'An unexpected format error occurred. Please check your input.']);

  /// Create a format exception from a specific error message.
  factory CFormatException.fromMessage(String message) {
    return CFormatException(message);
  }

  /// Get the corresponding error message
  String get formattedMessage => message;

  /// Create a format exception from a specific error code.
  factory CFormatException.fromCode(String code) {
    switch (code) {
    // Mã lỗi định dạng email
      case 'INVALID_EMAIL_FORMAT':
        return CFormatException('The email address is badly formatted. Please check your email address.');

    // Mã lỗi định dạng mật khẩu
      case 'WEAK_PASSWORD':
        return CFormatException('The password is too weak. It must be at least 6 characters long.');
      case 'PASSWORD_TOO_SHORT':
        return CFormatException('The password is too short. It must be at least 6 characters long.');
      case 'PASSWORD_TOO_LONG':
        return CFormatException('The password is too long. It must be no more than 20 characters long.');
      case 'PASSWORD_NO_DIGIT':
        return CFormatException('The password must contain at least one digit.');
      case 'PASSWORD_NO_UPPERCASE':
        return CFormatException('The password must contain at least one uppercase letter.');
      case 'PASSWORD_NO_LOWERCASE':
        return CFormatException('The password must contain at least one lowercase letter.');
      case 'PASSWORD_NO_SPECIAL_CHAR':
        return CFormatException('The password must contain at least one special character.');

    // Mã lỗi định dạng tên người dùng
      case 'INVALID_USERNAME_FORMAT':
        return CFormatException('The username is badly formatted. It should contain only alphanumeric characters and underscores.');
      case 'USERNAME_TOO_SHORT':
        return CFormatException('The username is too short. It must be at least 3 characters long.');
      case 'USERNAME_TOO_LONG':
        return CFormatException('The username is too long. It must be no more than 15 characters long.');

    // Mã lỗi định dạng số điện thoại
      case 'INVALID_PHONE_NUMBER':
        return CFormatException('The phone number is badly formatted. Please enter a valid phone number.');

    // Mã lỗi định dạng chung
      case 'INVALID_FORMAT':
        return CFormatException('The input format is invalid. Please check the format and try again.');

    // Mã lỗi không xác định
      case 'UNKNOWN_ERROR':
      default:
        return CFormatException('An unknown error occurred. Please try again.');
    }
  }

  @override
  String toString() {
    return 'CFormatException(message: $message)';
  }
}
