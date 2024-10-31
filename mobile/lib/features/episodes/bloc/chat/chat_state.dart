part of 'chat_bloc.dart';
abstract class ChatState extends Equatable {
  final List<String> messages;

  const ChatState(this.messages);

  @override
  List<Object> get props => [messages];

  ChatState copyWith({List<String>? messages});
}

class ChatInitialState extends ChatState {
  const ChatInitialState(super.messages);

  @override
  ChatInitialState copyWith({List<String>? messages}) {
    return ChatInitialState(messages ?? this.messages);
  }
}

class ChatLoadingState extends ChatState {
  const ChatLoadingState(super.messages);

  @override
  ChatLoadingState copyWith({List<String>? messages}) {
    return ChatLoadingState(messages ?? this.messages);
  }
}

class ChatSuccessState extends ChatState {
  const ChatSuccessState(super.messages);

  @override
  ChatSuccessState copyWith({List<String>? messages}) {
    return ChatSuccessState(messages ?? this.messages);
  }
}

class ChatErrorState extends ChatState {
  final String error;

  const ChatErrorState(this.error, List<String> messages) : super(messages);

  @override
  ChatErrorState copyWith({List<String>? messages}) {
    return ChatErrorState(error, messages ?? this.messages);
  }

  @override
  List<Object> get props => [error, messages];
}