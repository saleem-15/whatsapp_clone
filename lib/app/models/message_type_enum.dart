enum MessageType {
  text,

  photo,

  video,

  audio,

  file,
}

MessageType msgTypeEnumfromString(String msgType) {
  switch (msgType) {
    case 'text':
      return MessageType.text;

    case 'photo':
      return MessageType.photo;

    case 'video':
      return MessageType.video;

    case 'audio':
      return MessageType.audio;

    case 'file':
      return MessageType.file;

    default:
      throw '$msgType is not valid MessageType';
  }
}
