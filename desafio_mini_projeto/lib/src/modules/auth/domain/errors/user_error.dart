abstract class IUserException {
  final String message;
  final StackTrace? stackTrace;

  IUserException(this.message, [this.stackTrace]);
}

class UserException extends IUserException {
  UserException(super.message, [super.stackTrace]);
}
