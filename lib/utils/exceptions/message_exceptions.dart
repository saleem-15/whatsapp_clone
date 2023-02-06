import 'package:whatsapp_clone/utils/exceptions/base_exception.dart';

enum MessageExceptionType {
  InvalidMessageType,
}

class MessageException extends BaseException {
  MessageException._({
    required super.msg,
    required this.exceptionType,
  });

  MessageExceptionType exceptionType;

  ///throws a custom exception from type [MessageException]
  static MessageException invalidMessageType([dynamic object]) {
    return MessageException._(
      msg: 'Invalid Message Type: $object',
      exceptionType: MessageExceptionType.InvalidMessageType,
    );
  }

  @override
  String toString() {
    return '-------------------Exception------------------\nMessage: $msg\nException type: $exceptionType';
  }
}
