import 'package:example/api.dart';
import 'package:example/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockApi extends Mock implements Api {}

void main() {
  MockApi mockApi;

  setUp(() {
    mockApi = MockApi();
  });

  group('MyHomePage test', () {
    testWidgets('Should display a random joke when getJoke button is pressed',
        (tester) async {
      final getJokeButton = find.byKey(ValueKey('getJokeButton'));

      when(mockApi.getRandomJoke()).thenAnswer(
        (_) => Future.value('Programming is too easy'),
      );

      await tester.pumpWidget(MaterialApp(home: MyHomePage(api: mockApi)));
      await tester.tap(getJokeButton);
      await tester.pump();

      expect(find.text('Programming is too easy'), findsOneWidget);
    });

    testWidgets('Should display error message returned from api',
        (tester) async {
      final getJokeButton = find.byKey(ValueKey('getJokeButton'));

      when(mockApi.getRandomJoke()).thenAnswer(
        (_) => Future.value('An error occured'),
      );

      await tester.pumpWidget(MaterialApp(home: MyHomePage(api: mockApi)));
      await tester.tap(getJokeButton);
      await tester.pump();

      expect(find.text('An error occured'), findsOneWidget);
    });
  });
}
