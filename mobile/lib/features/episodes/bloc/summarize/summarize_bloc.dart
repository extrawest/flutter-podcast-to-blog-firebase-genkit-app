import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../services/api_service.dart';

part 'summarize_event.dart';
part 'summarize_state.dart';

class SummarizeBloc extends Bloc<SummarizeEvent, SummarizeState> {
  final ApiService _apiService = GetIt.I<ApiService>();

  SummarizeBloc() : super(SummarizeInitial()) {
    on<FetchSummary>(_onFetchSummary);
  }

  _onFetchSummary(FetchSummary event, Emitter<SummarizeState> emit) async {
    try {
      emit(SummarizeLoading());
      String summary = await _apiService.getEpisodeSummary(id: event.id);

      emit(SummarizeLoaded(summary: summary));
      if (summary.isNotEmpty) {
        final audioBytes = await _apiService.getAudio(summary: summary);
        final filePath = await _apiService.saveRawResponse(audioBytes);

        final file = File(filePath);
        if (await file.exists()) {
          log('File exists and its size is: ${await file.length()} bytes');
        } else {
          log('File does not exist');
          return;
        }

        emit(AudioLoaded(audioPath: filePath, summary: summary));
      }
    } catch (e) {
      emit(SummarizeError(message: e.toString()));
    }
  }
}
