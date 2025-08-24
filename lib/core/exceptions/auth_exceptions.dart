import 'package:tajwid/core/exceptions/exceptions.dart';

/// Auth
class EmailAlreadyInUseException extends AppException {
  EmailAlreadyInUseException()
    : super(code: 'email-already-in-use', message: 'Email already in use');
}

class WeakPasswordException extends AppException {
  WeakPasswordException()
    : super(code: 'weak-password', message: 'Password is too weak');
}

class WrongPasswordException extends AppException {
  WrongPasswordException()
    : super(code: 'wrong-password', message: 'Wrong password');
}

class UserNotFoundException extends AppException {
  UserNotFoundException()
    : super(code: 'user-not-found', message: 'User not found');
}

class UserNotSignedInException extends AppException {
  UserNotSignedInException()
    : super(
        code: 'user-not-signed-in',
        message: 'The operation can\'t be completed (not signed in)',
      );
}
