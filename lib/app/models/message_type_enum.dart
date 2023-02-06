import 'package:whatsapp_clone/utils/exceptions/message_exceptions.dart';

enum MessageType {
  text,

  image,

  video,

  audio,

  file,
}

MessageType msgTypeEnumfromString(String msgType) {
  switch (msgType) {
    case 'text':
      return MessageType.text;

    case 'image':
      return MessageType.image;

    case 'video':
      return MessageType.video;

    case 'audio':
      return MessageType.audio;

    case 'file':
      return MessageType.file;

    default:
      throw MessageException.invalidMessageType(msgType);
  }
}
