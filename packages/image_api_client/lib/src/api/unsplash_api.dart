import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'unsplash_api.g.dart';

/// {@template unsplash_api}
/// Unsplash API
/// {@endtemplate}
@RestApi(baseUrl: 'https://november7-730026606190.europe-west1.run.app')
abstract class UnsplashApi {
  /// {@macro unsplash_api}
  factory UnsplashApi(Dio dio) = _UnsplashApi;

  @GET('/image')
  /// Get a random photo from Unsplash
  Future<UnsplashImage> getImage();
}

/// {@template unsplash_image}
/// Unsplash Image
/// {@endtemplate}
class UnsplashImage {
  /// {@macro unsplash_image}
  UnsplashImage({required this.url});

  /// {@macro unsplash_image_from_json}
  factory UnsplashImage.fromJson(Map<String, dynamic> json) =>
      UnsplashImage(url: json['url'] as String);

  /// The URL of the image.
  final String url;
}
