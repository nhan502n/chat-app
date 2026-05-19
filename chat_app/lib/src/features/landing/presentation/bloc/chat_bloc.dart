import 'dart:async';
import 'package:chat_app/src/features/landing/domain/entities/message_entity.dart';
import 'package:chat_app/src/features/landing/domain/repositories/chat_realtime_repository.dart';
import 'package:chat_app/src/features/landing/presentation/bloc/chat_event.dart';
import 'package:chat_app/src/features/landing/presentation/bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRealtimeRepository repository;

  StreamSubscription<MessageEntity>? _subscription;

  ChatBloc(this.repository) : super(ChatState.initial()) {
    on<ConnectSocket>(_onConnectSocket);
    on<NewMessageReceived>(_onNewMessage);
    on<FetchConversations>(_onFetchConversations);
    on<ConversationsLoaded>(_onConversationsLoaded);
  }

  Future<void> _onConnectSocket(
    ConnectSocket event,
    Emitter<ChatState> emit,
  ) async {
    await repository.connect(event.userId, event.token);
    emit(state.copyWith(isConnected: true));
    _subscription?.cancel();
    _subscription = repository.getMessages().listen((message) {
      add(NewMessageReceived(message));
    });
    _conversationSub?.cancel();
    _conversationSub = repository.getConversationsStream().listen((data) {
      add(ConversationsLoaded(data));
    });

    add(FetchConversations());
  }

  Future<void> _onFetchConversations(
    FetchConversations event,
    Emitter<ChatState> emit,
  ) async {
    final data = await repository.fetchConversations();
    add(ConversationsLoaded(data));
  }

  StreamSubscription<List<MessageEntity>>? _conversationSub;

  void _onConversationsLoaded(
    ConversationsLoaded event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(conversations: event.conversations));
  }

  void _onNewMessage(NewMessageReceived event, Emitter<ChatState> emit) {
    final updatedMessages = List<MessageEntity>.from(state.messages)
      ..add(event.message);

    final updatedConversations = List<MessageEntity>.from(state.conversations);

    final index = updatedConversations.indexWhere(
      (c) =>
          (c.senderId == event.message.senderId &&
              c.receiverId == event.message.receiverId) ||
          (c.senderId == event.message.receiverId &&
              c.receiverId == event.message.senderId),
    );

    if (index != -1) {
      updatedConversations.removeAt(index);
    }

    updatedConversations.insert(0, event.message);

    emit(
      state.copyWith(
        messages: updatedMessages,
        conversations: updatedConversations,
      ),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _conversationSub?.cancel();
    return super.close();
  }
}
