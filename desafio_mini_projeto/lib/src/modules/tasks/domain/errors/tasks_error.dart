abstract class ITaskException {
  final String message;
  final StackTrace? stackTrace;

  ITaskException(this.message, [this.stackTrace]);
}

class TaskException extends ITaskException {
  TaskException(super.message, [super.stackTrace]);

  @override
  String toString() {
    if (stackTrace != null) {
      return 'TaskException: $message\nStackTrace: $stackTrace';
    } else {
      return 'TaskException: $message';
    }
  }
}
