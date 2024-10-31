import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../services/api_service.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ApiService apiService = GetIt.I<ApiService>();

  ImageBloc() : super(ImageInitial()) {
    on<FetchImage>(_onFetchImage);
  }

  _onFetchImage(FetchImage event, Emitter<ImageState> emit) async {
    try {
      emit(ImageLoading());
      final Uint8List image = await apiService.getImage(text: event.text);
      emit(ImageLoaded(image));
    } catch (error) {
      emit(ImageError(error.toString()));
    }
  }
}
