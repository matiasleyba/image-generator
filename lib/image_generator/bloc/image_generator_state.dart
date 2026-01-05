part of 'image_generator_bloc.dart';

/// {@template image_generator_state}
/// Base class for all image generator states.
/// {@endtemplate}
abstract class ImageGeneratorState extends Equatable {
  /// {@macro image_generator_state}
  const ImageGeneratorState();

  @override
  List<Object?> get props => [];
}

/// {@template image_generator_initial_state}
/// Initial state when the bloc is first created.
/// {@endtemplate}
class ImageGeneratorInitial extends ImageGeneratorState {
  /// {@macro image_generator_initial_state}
  const ImageGeneratorInitial();
}

/// {@template image_generator_loading_state}
/// State when an image is being fetched.
/// {@endtemplate}
class ImageGeneratorLoading extends ImageGeneratorState {
  /// {@macro image_generator_loading_state}
  const ImageGeneratorLoading();
}

/// {@template image_generator_loaded_state}
/// State when an image has been successfully fetched.
/// {@endtemplate}
class ImageGeneratorLoaded extends ImageGeneratorState {
  /// {@macro image_generator_loaded_state}
  const ImageGeneratorLoaded(this.imageUrl);

  /// The URL of the fetched image.
  final String imageUrl;

  @override
  List<Object?> get props => [imageUrl];
}

/// {@template image_generator_error_state}
/// State when an error occurs while fetching an image.
/// {@endtemplate}
class ImageGeneratorError extends ImageGeneratorState {
  /// {@macro image_generator_error_state}
  const ImageGeneratorError(this.message);

  /// The error message.
  final String message;

  @override
  List<Object?> get props => [message];
}
