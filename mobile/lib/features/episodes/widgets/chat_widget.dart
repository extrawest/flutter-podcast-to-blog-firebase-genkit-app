import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat/chat_bloc.dart';
import '../bloc/speech_to_text/speech_to_text_bloc.dart';
import 'chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  String? speechToText = '';

  @override
  void initState() {
    final speechToTextState = context.read<SpeechToTextBloc>().state;
    if (speechToTextState is SpeechToTextLoaded) {
      speechToText = speechToTextState.text;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('speechToText: $speechToText');
    final speechToTextState = context.watch<SpeechToTextBloc>().state;

    return speechToTextState is SpeechToTextLoading
        ? const Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator(), Text('Loading...')],
                  ),
                ),
              ),
            ],
          )
        : BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              return Column(
                children: [
                  _buildChatList(state),
                  _buildInput(state, context),
                  const SizedBox(
                    height: 20,
                  )
                ],
              );
            },
          );
  }

  Widget _buildInput(ChatState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter your message',
              ),
            ),
          ),
          state is ChatLoadingState
              ? const CircularProgressIndicator()
              : IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final message = _controller.text;
                    if (message.isNotEmpty) {
                      context.read<ChatBloc>().add(SendMessageEvent(
                            message: message,
                            context: speechToText ?? '',
                          ));
                      _controller.clear();
                    }
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildChatList(ChatState state) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.messages.length,
        itemBuilder: (context, index) {
          return ChatBubble(
            message: state.messages[index],
            isUserMessage: index % 2 == 0,
          );
        },
      ),
    );
  }
}
