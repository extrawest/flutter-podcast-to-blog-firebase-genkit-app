import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:podcast_index_app/services/api_service.dart';

part 'speech_to_text_event.dart';
part 'speech_to_text_state.dart';

class SpeechToTextBloc extends Bloc<SpeechToTextEvent, SpeechToTextState> {
  final ApiService apiService = GetIt.I<ApiService>();

  SpeechToTextBloc() : super(SpeechToTextInitial()) {
    on<FetchSpeechToText>(_onFetchSpeechToText);
  }

  _onFetchSpeechToText(FetchSpeechToText event, Emitter<SpeechToTextState> emit) async {
    try {
      emit(SpeechToTextLoading());
      final result = await apiService.getSpeechToText(
        id: event.id,
      );
      emit(SpeechToTextLoaded(
        text: result,
      ));
    } catch (e) {
      emit(SpeechToTextError(
        message: e.toString(),
      ));
    }
  }
}
