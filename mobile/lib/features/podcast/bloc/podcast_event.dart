
part of 'podcast_bloc.dart';

sealed class PodcastEvent extends Equatable {
  const PodcastEvent();
}

class FetchPodcastEpisodes extends PodcastEvent {
  const FetchPodcastEpisodes({required this.id});

  final String id;
  @override
  List<Object> get props => [id];
}

