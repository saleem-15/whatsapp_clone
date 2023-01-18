enum ExceptionType {
  chatAlreadyExists,
}

class ChatException implements Exception {
  ChatException._({
    required this.msg,
    required this.exceptionType,
  });

  String msg;
  ExceptionType exceptionType;

  ///throws a custom exception from type [ChatException]
  static void chatAlreadyExists() {
    throw ChatException._(
      msg: 'Chat Already Exists',
      exceptionType: ExceptionType.chatAlreadyExists,
    );
  }

  @override
  String toString() {
    return 'Message: $msg\nException type: $exceptionType';
  }
}
