import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_generator/image_generator/bloc/image_generator_bloc.dart';

/// {@template image_generator_view}
/// View that displays a square image centered on screen with a button to load another image.
/// {@endtemplate}
class ImageGeneratorView extends StatelessWidget {
  /// {@macro image_generator_view}
  const ImageGeneratorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ImageGeneratorBloc, ImageGeneratorState>(
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 300,
                      height: 300,
                      child: ImageContentWidget(),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: state is ImageGeneratorLoading
                          ? null
                          : () {
                              context
                                  .read<ImageGeneratorBloc>()
                                  .add(const FetchRandomImageEvent());
                            },
                      child: const Text('Load Another Image'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// {@template image_content_widget}
/// Widget that displays the appropriate content based on the current state.
/// {@endtemplate}
class ImageContentWidget extends StatelessWidget {
  /// {@macro image_content_widget}
  const ImageContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageGeneratorBloc, ImageGeneratorState>(
      builder: (context, state) {
        switch (state) {
          case ImageGeneratorLoading():
            return const LoadingImageWidget();
          case ImageGeneratorError():
            return ErrorImageWidget(message: state.message);
          case ImageGeneratorLoaded():
            return LoadedImageWidget(imageUrl: state.imageUrl);
          default:
            return const LoadingImageWidget();
        }
      },
    );
  }
}

/// {@template loading_image_widget}
/// Widget that displays a loading indicator.
/// {@endtemplate}
class LoadingImageWidget extends StatelessWidget {
  /// {@macro loading_image_widget}
  const LoadingImageWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}

/// {@template error_image_widget}
/// Widget that displays an error message.
/// {@endtemplate}
class ErrorImageWidget extends StatelessWidget {
  /// {@macro error_image_widget}
  const ErrorImageWidget({
    super.key,
    required this.message,
  });

  /// The error message to display.
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// {@template loaded_image_widget}
/// Widget that displays the loaded image.
/// {@endtemplate}
class LoadedImageWidget extends StatelessWidget {
  /// {@macro loaded_image_widget}
  const LoadedImageWidget({
    super.key,
    required this.imageUrl,
  });

  /// The URL of the image to display.
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const LoadingImageWidget(),
        errorWidget: (context, url, error) => const BrokenImageWidget(),
      ),
    );
  }
}

/// {@template broken_image_widget}
/// Widget that displays a broken image icon.
/// {@endtemplate}
class BrokenImageWidget extends StatelessWidget {
  /// {@macro broken_image_widget}
  const BrokenImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Icon(
          Icons.broken_image,
          size: 48,
          color: Colors.grey,
        ),
      ),
    );
  }
}

/// {@template initial_image_widget}
/// Widget that displays a placeholder for the initial state.
/// {@endtemplate}
class InitialImageWidget extends StatelessWidget {
  /// {@macro initial_image_widget}
  const InitialImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Icon(
          Icons.image,
          size: 48,
          color: Colors.grey,
        ),
      ),
    );
  }
}
