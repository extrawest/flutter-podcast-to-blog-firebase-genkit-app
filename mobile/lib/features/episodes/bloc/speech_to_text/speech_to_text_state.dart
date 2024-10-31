part of 'speech_to_text_bloc.dart';

sealed class SpeechToTextState extends Equatable {
  const SpeechToTextState();
}

final class SpeechToTextInitial extends SpeechToTextState {
  @override
  List<Object> get props => [];
}

class SpeechToTextLoading extends SpeechToTextState {
  @override
  List<Object> get props => [];
}

class SpeechToTextLoaded extends SpeechToTextState {
  final String text;

  const SpeechToTextLoaded({required this.text});

  @override
  List<Object> get props => [text];
}

class SpeechToTextError extends SpeechToTextState {
  final String message;

  const SpeechToTextError({required this.message});

  @override
  List<Object> get props => [message];
}
