part of 'image_bloc.dart';

sealed class ImageState extends Equatable {
  const ImageState();
}

final class ImageInitial extends ImageState {
  @override
  List<Object> get props => [];
}

class ImageLoading extends ImageState {
  @override
  List<Object> get props => [];
}

class ImageLoaded extends ImageState {
  final Uint8List image;
  const ImageLoaded(this.image);
  @override
  List<Object> get props => [image];
}

class ImageError extends ImageState {
  final String message;
  const ImageError(this.message);
  @override
  List<Object> get props => [message];
}