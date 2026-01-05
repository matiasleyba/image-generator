import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_api_client/image_api_client.dart';

import 'image_generator/view/image_generator_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ImageApiClient>(
      create: (context) => UnsplashImageApiClient(),
      child: MaterialApp(
        title: 'Image Generator',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ImageGeneratorPage(),
      ),
    );
  }
}
