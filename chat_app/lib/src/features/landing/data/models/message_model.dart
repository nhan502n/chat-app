import 'package:chat_app/src/features/landing/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.senderId,
    required super.receiverId,
    required super.content,
    required super.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    if (json['sender_id'] == null) {
      throw Exception("sender_id is null: $json");
    }

    return MessageModel(
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
