import 'dart:math';

import 'package:chat_app/core/models/chat_message.dart';
import 'package:chat_app/core/models/chat_user.dart';
import 'package:chat_app/core/services/chat/chat_service.dart';
import 'dart:async';

class ChatMockervice implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'Bom dia',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Diego',
      userImageURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Reunião Hoje?',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Jessica',
      userImageURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '3',
      text: 'Sim.',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Diego',
      userImageURL: 'assets/images/avatar.png',
    ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageUrl,
    );
    _msgs.add(newMessage);
    _controller?.add(_msgs);
    return newMessage;
  }
}
