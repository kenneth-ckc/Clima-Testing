import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/screens/city_screen.dart';

void main() {
  testWidgets('location screen widgets', (WidgetTester tester) async {
    Widget buildTestableWidget(Widget widget) {
      return new MediaQuery(
          data: new MediaQueryData(), child: new MaterialApp(home: widget));
    }

    LocationScreen locationScreen = LocationScreen();
    await tester.pumpWidget(buildTestableWidget(locationScreen));

    final locateButton = find.widgetWithIcon(
      FlatButton,
      Icons.near_me,
    );

    final cityButton = find.widgetWithIcon(
      FlatButton,
      Icons.location_city,
    );

    expect(locateButton, findsOneWidget,
        reason: 'locate button appear on screen');
    expect(cityButton, findsOneWidget, reason: 'city button appear on screen');

    await tester.tap(cityButton);
  });

  testWidgets('change city screen widgets', (WidgetTester tester) async {
    Widget buildTestableWidget(Widget widget) {
      return new MediaQuery(
          data: new MediaQueryData(), child: new MaterialApp(home: widget));
    }

    CityScreen cityScreen = CityScreen();
    await tester.pumpWidget(buildTestableWidget(cityScreen));

    expect(find.widgetWithText(FlatButton, 'Get Weather'), findsOneWidget);

    expect(find.byType(TextField), findsOneWidget);

    expect(
        find.widgetWithIcon(
          FlatButton,
          Icons.arrow_back_ios,
        ),
        findsOneWidget);
  });
}
