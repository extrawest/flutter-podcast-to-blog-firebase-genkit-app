import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../services/api_service.dart';

part 'translate_event.dart';
part 'translate_state.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  final ApiService _apiService = GetIt.I<ApiService>();

  TranslateBloc() : super(TranslateInitial()) {
    on<FetchTranslation>(_onFetchTranslation);
  }

  _onFetchTranslation(FetchTranslation event, Emitter<TranslateState> emit) async{

    try {
      emit(TranslateLoading());
      String translation = await _apiService.getTranslation(text: event.text);
      emit(TranslateLoaded(text: translation));
    } catch (e) {
      emit(TranslateError(message: e.toString()));
    }
  }
}
