import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_api_client/image_api_client.dart';
import 'package:image_generator/image_generator/bloc/image_generator_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockImageApiClient extends Mock implements ImageApiClient {}

void main() {
  group('ImageGeneratorBloc', () {
    late MockImageApiClient mockImageApiClient;

    setUp(() {
      mockImageApiClient = MockImageApiClient();
    });

    test('initial state is ImageGeneratorInitial', () {
      final bloc = ImageGeneratorBloc(
        imageApiClient: mockImageApiClient,
      );
      expect(bloc.state, equals(const ImageGeneratorInitial()));
    });

    blocTest<ImageGeneratorBloc, ImageGeneratorState>(
      'emits [loading, loaded] when FetchRandomImageEvent succeeds',
      build: () {
        when(() => mockImageApiClient.fetchImage())
            .thenAnswer((_) async => 'https://example.com/image.jpg');
        return ImageGeneratorBloc(imageApiClient: mockImageApiClient);
      },
      act: (bloc) => bloc.add(const FetchRandomImageEvent()),
      expect: () => [
        const ImageGeneratorLoading(),
        const ImageGeneratorLoaded('https://example.com/image.jpg'),
      ],
      verify: (_) {
        verify(() => mockImageApiClient.fetchImage()).called(1);
      },
    );

    blocTest<ImageGeneratorBloc, ImageGeneratorState>(
      'emits [loading, error] when FetchRandomImageEvent fails',
      build: () {
        when(() => mockImageApiClient.fetchImage())
            .thenThrow(Exception('Network error'));
        return ImageGeneratorBloc(imageApiClient: mockImageApiClient);
      },
      act: (bloc) => bloc.add(const FetchRandomImageEvent()),
      expect: () => [
        const ImageGeneratorLoading(),
        const ImageGeneratorError('Exception: Network error'),
      ],
      verify: (_) {
        verify(() => mockImageApiClient.fetchImage()).called(1);
      },
    );
  });
}
