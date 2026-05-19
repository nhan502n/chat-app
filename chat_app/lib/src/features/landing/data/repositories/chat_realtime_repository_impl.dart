import 'package:chat_app/src/features/landing/data/datasources/chat_realtime_remote_datasource.dart';
import 'package:chat_app/src/features/landing/domain/entities/message_entity.dart';
import 'package:chat_app/src/features/landing/domain/repositories/chat_realtime_repository.dart';

class ChatRealtimeRepositoryImpl implements ChatRealtimeRepository {
  final ReverbSocketDataSource dataSource;

  ChatRealtimeRepositoryImpl(this.dataSource);

  @override
  Stream<MessageEntity> getMessages() {
    return dataSource.messages;
  }

  @override
  Future<void> connect(int userId, String token) {
    return dataSource.connect(userId, token);
  }

  @override
  Future<List<MessageEntity>> fetchConversations() async {
    final data = await dataSource.fetchConversations();

    return data;
  }

  @override
  Stream<List<MessageEntity>> getConversationsStream() {
    return dataSource.conversations.map((list) => list.map((e) => e).toList());
  }
}
