part of 'summarize_bloc.dart';

sealed class SummarizeEvent extends Equatable {
  const SummarizeEvent();
}

class FetchSummary extends SummarizeEvent {
  const FetchSummary({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}

