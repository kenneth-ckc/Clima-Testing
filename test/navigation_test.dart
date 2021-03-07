import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/screens/city_screen.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('Navigation tests', () {
    NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    Future<void> _buildLocationScreen(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LocationScreen(),
        navigatorObservers: [mockObserver],
      ));

      verify(mockObserver.didPush(any, any));
    }

    Future<void> _navigateToCityScreen(WidgetTester tester) async {
      final cityButton = find.widgetWithIcon(
        FlatButton,
        Icons.location_city,
      );
      await tester.tap(cityButton);
      await tester.pumpAndSettle();
    }

    testWidgets('when tapping city button, should push to city screen',
        (WidgetTester tester) async {
      await _buildLocationScreen(tester);
      await _navigateToCityScreen(tester);
      verify(mockObserver.didPush(any, any));
      expect(find.byType(CityScreen), findsOneWidget);
    });

    testWidgets(
        'tapping back button from city screen should pop to location screen',
        (WidgetTester tester) async {
      await _buildLocationScreen(tester);
      await _navigateToCityScreen(tester);

      final Route pushedRoute =
          verify(mockObserver.didPush(captureAny, any)).captured.single;

      String popResult;
      pushedRoute.popped.then((result) => popResult = result);

      final backButton = find.widgetWithIcon(
        FlatButton,
        Icons.arrow_back_ios,
      );

      await tester.tap(backButton);
      await tester.pumpAndSettle();

      verify(mockObserver.didPop(any, any));
      expect(find.byType(LocationScreen), findsOneWidget);
    });

    testWidgets(
        'tapping get weather from city screen should pop to location screen with CityName callback',
        (WidgetTester tester) async {
      await _buildLocationScreen(tester);
      await _navigateToCityScreen(tester);

      final Route pushedRoute =
          verify(mockObserver.didPush(captureAny, any)).captured.single;

      String popResult;
      pushedRoute.popped.then((result) => popResult = result);

      final getButton = find.widgetWithText(FlatButton, 'Get Weather');
      final textField = find.byType(TextField);
      await tester.enterText(textField, 'Hong Kong');
      await tester.tap(getButton);
      await tester.pumpAndSettle();

      expect(popResult, 'Hong Kong');
    });
  });
}
