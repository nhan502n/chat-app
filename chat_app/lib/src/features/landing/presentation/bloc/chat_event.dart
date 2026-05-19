import 'package:chat_app/src/features/landing/domain/entities/message_entity.dart';

abstract class ChatEvent {}

class FetchConversations extends ChatEvent {}

class ConversationsLoaded extends ChatEvent {
  final List<MessageEntity> conversations;
  ConversationsLoaded(this.conversations);
}

class ConnectSocket extends ChatEvent {
  final int userId;
  final String token;

  ConnectSocket(this.userId, this.token);
}

class NewMessageReceived extends ChatEvent {
  final dynamic message;

  NewMessageReceived(this.message);
}
