class User {
  String uid;
  String name;
  String? image;
  String? chatId;

  User({
    this.chatId,
    required this.name,
    required this.image,
    required this.uid,
  });
}
