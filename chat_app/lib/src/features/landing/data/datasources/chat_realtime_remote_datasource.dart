import 'dart:async';
import 'dart:convert';
import 'package:chat_app/src/core/local/message_service.dart';
import 'package:chat_app/src/core/local/secure_storage_service.dart';
import 'package:chat_app/src/core/network/api_client.dart';
import 'package:chat_app/src/features/landing/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ReverbSocketDataSource {
  final ApiClient client;
  ReverbSocketDataSource(this.client);

  late WebSocketChannel channel;
  final _conversationController =
      StreamController<List<MessageModel>>.broadcast();

  Stream<List<MessageModel>> get conversations =>
      _conversationController.stream;

  List<MessageModel> _currentConversations = [];
  final _controller = StreamController<MessageModel>.broadcast();
  Stream<MessageModel> get messages => _controller.stream;

  Future<void> connect(int userId, String token) async {
    client.setToken(token);
    channel = WebSocketChannel.connect(
      Uri.parse(
        'ws://127.0.0.1:8080/app/localkey?protocol=7&client=flutter&version=1.0&flash=false',
      ),
    );

    channel.stream.listen((message) async {
      final data = jsonDecode(message);

      if (data['event'] == 'pusher:connection_established') {
        final socketId = jsonDecode(data['data'])['socket_id'];

        final res = await client.post(
          '/broadcasting/auth',
          body: {"socket_id": socketId, "channel_name": "private-chat.$userId"},
        );

        final authData = res.data;

        channel.sink.add(
          jsonEncode({
            "event": "pusher:subscribe",
            "data": {
              "channel": "private-chat.$userId",
              "auth": authData['auth'],
            },
          }),
        );
      }
      if (data['event'] == 'message.sent') {
        final messageData = jsonDecode(data['data']);
        final newMessage = MessageModel.fromJson(messageData);

        _controller.add(newMessage);

        _updateConversation(newMessage);
      }
    });
  }

  Future<List<MessageModel>> fetchConversations() async {
    final token = await SecureStorageService().getItem("token");

    if (token == null || token.isEmpty) {
      MessageService.showError("Token not found");
      return [];
    }
    client.setToken(token);

    final res = await client.get('/api/messages/conversations');
    debugPrint("debug: $res");
    final data = res.data as List;

    _currentConversations = data.map((e) => MessageModel.fromJson(e)).toList();

    _conversationController.add(_currentConversations);

    return _currentConversations;
  }

  void _updateConversation(MessageModel newMessage) {
    bool isSameConversation(MessageModel a, MessageModel b) {
      return (a.senderId == b.senderId && a.receiverId == b.receiverId) ||
          (a.senderId == b.receiverId && a.receiverId == b.senderId);
    }

    final index = _currentConversations.indexWhere(
      (c) => isSameConversation(c, newMessage),
    );

    if (index != -1) {
      _currentConversations[index] = newMessage;

      final item = _currentConversations.removeAt(index);
      _currentConversations.insert(0, item);
    } else {
      _currentConversations.insert(0, newMessage);
    }

    _conversationController.add(_currentConversations);
  }
}
