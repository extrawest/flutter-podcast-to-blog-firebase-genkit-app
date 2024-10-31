part of 'podcast_bloc.dart';

sealed class PodcastState extends Equatable {
  const PodcastState();
}

final class PodcastInitial extends PodcastState {
  @override
  List<Object> get props => [];
}

class PodcastLoading extends PodcastState {
  @override
  List<Object> get props => [];
}

class PodcastLoaded extends PodcastState {
  final PodcastModel podcasts;

  const PodcastLoaded(this.podcasts);

  @override
  List<Object> get props => [podcasts];
}

class PodcastError extends PodcastState {
  final String message;

  const PodcastError(this.message);

  @override
  List<Object> get props => [message];
}