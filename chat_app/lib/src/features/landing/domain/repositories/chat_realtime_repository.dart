import 'package:chat_app/src/features/landing/domain/entities/message_entity.dart';

abstract class ChatRealtimeRepository {
  Stream<MessageEntity> getMessages();
  Future<void> connect(int userId, String token);
  Future<List<MessageEntity>> fetchConversations();

  Stream<List<MessageEntity>> getConversationsStream();
}
