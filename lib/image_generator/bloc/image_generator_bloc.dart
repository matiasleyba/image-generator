import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_api_client/image_api_client.dart';
import 'package:equatable/equatable.dart';

part 'image_generator_event.dart';
part 'image_generator_state.dart';

/// {@template image_generator_bloc}
/// BLoC that manages the state of image generation.
/// {@endtemplate}
class ImageGeneratorBloc
    extends Bloc<ImageGeneratorEvent, ImageGeneratorState> {
  /// {@macro image_generator_bloc}
  ImageGeneratorBloc({
    required ImageApiClient imageApiClient,
  })  : _imageApiClient = imageApiClient,
        super(const ImageGeneratorInitial()) {
    on<FetchRandomImageEvent>(_onFetchRandomImage);
  }

  final ImageApiClient _imageApiClient;

  Future<void> _onFetchRandomImage(
    FetchRandomImageEvent event,
    Emitter<ImageGeneratorState> emit,
  ) async {
    final previousColors = switch (state) {
      ImageGeneratorLoading(:final previousColors) => previousColors,
      ImageGeneratorLoaded(:final previousColors) => previousColors,
      _ => const <Color>[Colors.white, Colors.grey],
    };

    emit(ImageGeneratorLoading(previousColors));
    try {
      // Fetch the image from the API
      final imageUrl = await _imageApiClient.fetchImage();
      final imageBytes = await _imageApiClient.fetchImageBytes(imageUrl);
      final imageProvider = MemoryImage(imageBytes);

      // TODO(matiasleyba): improve color extraction
      final colorScheme = await ColorScheme.fromImageProvider(
        provider: imageProvider,
      );

      // Emit the loaded state with the image and palette
      emit(
        ImageGeneratorLoaded(
          imageUrl,
          [colorScheme.primary, colorScheme.secondary],
          previousColors,
        ),
      );
    } catch (error) {
      emit(ImageGeneratorError(error.toString()));
    }
  }
}
