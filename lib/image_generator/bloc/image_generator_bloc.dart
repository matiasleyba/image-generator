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
    emit(const ImageGeneratorLoading());
    try {
      final imageUrl = await _imageApiClient.fetchImage();
      emit(ImageGeneratorLoaded(imageUrl));
    } catch (error) {
      emit(ImageGeneratorError(error.toString()));
    }
  }
}
