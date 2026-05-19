import 'package:chat_app/src/features/landing/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/src/features/landing/presentation/bloc/chat_event.dart';
import 'package:chat_app/src/features/landing/presentation/bloc/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LandingPage extends StatelessWidget {
  final int userId;
  final String token;

  const LandingPage({super.key, required this.userId, required this.token});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<ChatBloc>()..add(ConnectSocket(userId, token)),
      child: Scaffold(
        body: Column(
          children: [
            const _HeaderSection(),
            Expanded(child: _ConversationList()),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 80, bottom: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
        ),
      ),
      child: Column(
        children: const [
          Icon(Icons.chat_bubble, size: 80, color: Colors.white),
          SizedBox(height: 20),
          Text(
            "Realtime Chat",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Chat instantly with your friends",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _ConversationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        final conversations = state.conversations;

        if (conversations.isEmpty) {
          return const Center(child: Text("No conversations yet"));
        }

        return ListView.builder(
          itemCount: conversations.length,
          itemBuilder: (context, index) {
            final item = conversations[index];

            return ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text("User ${item.receiverId}"),
              subtitle: Text(item.content),
              trailing: Text(
                item.createdAt.toString().substring(11, 16),
                style: const TextStyle(fontSize: 12),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/chat');
              },
            );
          },
        );
      },
    );
  }
}
