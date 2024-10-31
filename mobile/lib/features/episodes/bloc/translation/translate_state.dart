part of 'translate_bloc.dart';

sealed class TranslateState extends Equatable {
  const TranslateState();
}

final class TranslateInitial extends TranslateState {
  @override
  List<Object> get props => [];
}


class TranslateLoading extends TranslateState {
  @override
  List<Object> get props => [];
}

class TranslateLoaded extends TranslateState {
  final String text;
  const TranslateLoaded({required this.text});
  @override
  List<Object> get props => [text];
}

class TranslateError extends TranslateState {
  final String message;
  const TranslateError({required this.message});
  @override
  List<Object> get props => [message];
}