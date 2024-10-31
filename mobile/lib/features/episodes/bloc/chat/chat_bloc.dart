import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../../services/api_service.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ApiService apiService = GetIt.I<ApiService>();

  ChatBloc() : super(const ChatInitialState([])) {
    on<SendMessageEvent>(_onSendMessage);
    on<AddMessageEvent>(_onAddMessage);
  }

  Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoadingState(state.messages));

      final response = await apiService.startChat(
        context: event.context,
        message: event.message,
      );

      if (response.isNotEmpty) {
        final messages = List<String>.from(state.messages)
          ..add('User: ${event.message}')
          ..add('Bot: $response');
        emit(ChatSuccessState(messages));
      } else {
        emit(ChatErrorState('Failed to fetch response', state.messages));
      }
    } catch (e) {
      emit(ChatErrorState(e.toString(), state.messages));
    }
  }

  Future<void> _onAddMessage(AddMessageEvent event, Emitter<ChatState> emit) async {
    try {
      emit(ChatSuccessState(event.messages));
    } catch (e) {
      emit(ChatErrorState(e.toString(), event.messages));
    }
  }
}
