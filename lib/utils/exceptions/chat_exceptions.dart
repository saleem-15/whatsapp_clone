import 'base_exception.dart';

enum ExceptionType {
  chatAlreadyExists,
}

class ChatException extends BaseException {
  ChatException._({
    required super.msg,
    required this.exceptionType,
  });

  ExceptionType exceptionType;

  ///throws a custom exception from type [ChatException]
  static ChatException chatAlreadyExists() {
   return  ChatException._(
      msg: 'Chat Already Exists',
      exceptionType: ExceptionType.chatAlreadyExists,
    );
  }

  @override
  String toString() {
    return '-------------------Exception------------------\nMessage: $msg\nException type: $exceptionType';
  }
}
