part of 'translate_bloc.dart';

sealed class TranslateEvent extends Equatable {
  const TranslateEvent();
}

class FetchTranslation extends TranslateEvent {
  final String text;

  const FetchTranslation({required this.text});

  @override
  List<Object> get props => [text];
}
