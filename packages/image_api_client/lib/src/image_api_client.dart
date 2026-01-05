import 'dart:typed_data';

/// {@template image_api_client}
/// Image Api Client
/// {@endtemplate}
abstract class ImageApiClient {
  /// {@macro image_api_client}
  const ImageApiClient();

  /// Fetch an image from the API
  Future<String> fetchImage();

  /// Fetch image bytes from the API
  Future<Uint8List> fetchImageBytes(String imageUrl);
}
