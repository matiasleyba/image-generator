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
  Future<String> getImage();
}
