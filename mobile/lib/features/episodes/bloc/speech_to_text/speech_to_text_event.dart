part of 'speech_to_text_bloc.dart';

sealed class SpeechToTextEvent extends Equatable {
  const SpeechToTextEvent();
}


class FetchSpeechToText extends SpeechToTextEvent {
  final String id;
  const FetchSpeechToText({required this.id});

  @override
  List<Object?> get props => [id];
}