import 'package:example/api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  MockHttpClient mockHttpClient;
  Api api;

  setUp(() {
    mockHttpClient = MockHttpClient();
    api = Api(client: mockHttpClient);
  });

  group('Api class GetRandomJoke', () {
    test('Should return a random joke when successful', () async {
      when(
        mockHttpClient.get(any, headers: anyNamed('headers')),
      ).thenAnswer(
        (_) => Future.value(Response(
            '{"setup": "the setup", "punchline": "the punchline"}', 200)),
      );

      final joke = await api.getRandomJoke();

      expect(joke, equals('the setup\nthe punchline'));
    });
    test('Should return "Something went wrong" when un-successful', () async {
      when(
        mockHttpClient.get(any, headers: anyNamed('headers')),
      ).thenAnswer(
        (_) => Future.value(Response('Error 400', 400)),
      );

      final joke = await api.getRandomJoke();

      expect(joke, equals('Something went wrong'));
    });
    test('Should return "An error occured" when error occurs', () async {
      when(
        mockHttpClient.get(any, headers: anyNamed('headers')),
      ).thenThrow(Error());

      final joke = await api.getRandomJoke();

      expect(joke, equals('An error occured'));
    });
  });
}
