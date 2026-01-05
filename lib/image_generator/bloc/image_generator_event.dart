part of 'image_generator_bloc.dart';

/// {@template image_generator_event}
/// Base class for all image generator events.
/// {@endtemplate}
abstract class ImageGeneratorEvent extends Equatable {
  /// {@macro image_generator_event}
  const ImageGeneratorEvent();

  @override
  List<Object?> get props => [];
}

/// {@template fetch_random_image_event}
/// Event to fetch a random image.
/// {@endtemplate}
class FetchRandomImageEvent extends ImageGeneratorEvent {
  /// {@macro fetch_random_image_event}
  const FetchRandomImageEvent();
}
