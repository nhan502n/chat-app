class MessageEntity {
  final int senderId;
  final int receiverId;
  final String content;
  final DateTime createdAt;

  MessageEntity({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.createdAt,
  });
}
