import 'package:chat_app/src/features/landing/domain/entities/message_entity.dart';

class ChatState {
  final bool isConnected;
  final List<MessageEntity> messages;
  final List<MessageEntity> conversations;

  ChatState({
    required this.isConnected,
    required this.messages,
    required this.conversations,
  });

  factory ChatState.initial() =>
      ChatState(isConnected: false, messages: [], conversations: []);

  ChatState copyWith({
    bool? isConnected,
    List<MessageEntity>? messages,
    List<MessageEntity>? conversations,
  }) {
    return ChatState(
      isConnected: isConnected ?? this.isConnected,
      messages: messages ?? this.messages,
      conversations: conversations ?? this.conversations,
    );
  }
}
