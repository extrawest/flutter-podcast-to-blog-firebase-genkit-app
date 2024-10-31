import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:podcast_index_app/features/podcast/models/podcast_model.dart';

import '../../../services/api_service.dart';

part 'podcast_event.dart';
part 'podcast_state.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  final ApiService _apiService = GetIt.I<ApiService>();

  PodcastBloc() : super(PodcastInitial()) {
    on<FetchPodcastEpisodes>(_onFetchPodcastEpisodes);
  }

  _onFetchPodcastEpisodes(FetchPodcastEpisodes event, Emitter<PodcastState> emit) async {
    try {
      emit(PodcastLoading());
      final result = await _apiService.getPodcastEpisodes(id: event.id);
      emit(PodcastLoaded(result));
    } catch (e) {
      emit(PodcastError(e.toString()));
    }
  }
}
