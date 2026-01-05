import 'package:dio/dio.dart' show Dio;
import 'package:image_api_client/image_api_client.dart';
import 'package:image_api_client/src/api/api.dart';

/// Unsplash Image API Client
class UnsplashImageApiClient implements ImageApiClient {
  /// {@macro image_api_client}
  UnsplashImageApiClient({UnsplashApi? unsplashApi})
    : _unsplashApi = unsplashApi ?? UnsplashApi(Dio());

  final UnsplashApi _unsplashApi;

  @override
  Future<String> fetchImage() {
    return _unsplashApi.getImage();
  }
}
