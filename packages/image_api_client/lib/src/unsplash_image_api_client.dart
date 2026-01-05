import 'dart:typed_data';

import 'package:dio/dio.dart' show Dio, Options, ResponseType;
import 'package:image_api_client/image_api_client.dart';
import 'package:image_api_client/src/api/api.dart';

/// Unsplash Image API Client
class UnsplashImageApiClient implements ImageApiClient {
  /// {@macro image_api_client}
  UnsplashImageApiClient({UnsplashApi? unsplashApi})
    : _unsplashApi = unsplashApi ?? UnsplashApi(Dio()),
      _dio = Dio();

  final UnsplashApi _unsplashApi;
  final Dio _dio;

  @override
  Future<String> fetchImage() async {
    final unsplashImage = await _unsplashApi.getImage();
    return unsplashImage.url;
  }

  @override
  Future<Uint8List> fetchImageBytes(String imageUrl) async {
    final response = await _dio.get<List<int>>(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data!);
  }
}
