part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();
}

class SendMessageEvent extends ChatEvent {
  final String message;
  final String context;

  const SendMessageEvent({required this.message, required this.context});

  @override
  List<Object?> get props => [message, context];
}

class AddMessageEvent extends ChatEvent {
  final List<String> messages;

  const AddMessageEvent({this.messages = const []});

  @override
  List<Object?> get props => [messages];
}