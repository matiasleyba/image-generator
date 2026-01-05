import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_api_client/image_api_client.dart';
import 'package:image_generator/image_generator/bloc/image_generator_bloc.dart';
import 'package:image_generator/image_generator/view/image_generator_view.dart';

/// {@template image_generator_page}
/// Page that provides the ImageGeneratorBloc and displays the ImageGeneratorView.
/// {@endtemplate}
class ImageGeneratorPage extends StatelessWidget {
  /// {@macro image_generator_page}
  const ImageGeneratorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageGeneratorBloc(
        imageApiClient: context.read<ImageApiClient>(),
      )..add(const FetchRandomImageEvent()),
      child: const ImageGeneratorView(),
    );
  }
}
