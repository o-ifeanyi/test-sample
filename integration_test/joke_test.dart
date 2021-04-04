import 'package:example/api.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Get joke test", (WidgetTester tester) async {
    final getJokeButton = find.byKey(ValueKey('getJokeButton'));
    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePage(api: Api(client: Client())),
      ),
    );

    await tester.tap(getJokeButton);
    await tester.pumpAndSettle();

    expect(find.textContaining('HERE\'S THE JOKE'), findsOneWidget);
    await Future.delayed(Duration(seconds: 2));
  });
}
