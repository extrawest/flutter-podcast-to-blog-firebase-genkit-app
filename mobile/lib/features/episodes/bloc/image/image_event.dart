part of 'image_bloc.dart';

sealed class ImageEvent extends Equatable {
  const ImageEvent();
}

class FetchImage extends ImageEvent {
  final String text;

  const FetchImage(this.text);

  @override
  List<Object> get props => [text];
}
