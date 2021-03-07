import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../lib/services/networking.dart';
import 'dart:convert';

class MockClient extends Mock implements http.Client {}

main() {
  final NetworkHelper networkHelper = NetworkHelper(
      'https://api.openweathermap.org/data/2.5/weather?lat=1&lon=1&appid=8f08f0f6f12fc26b507728b82e2d28e5&&units=metric');

  group('getData', () {
    test('returns weather data if the http call completes successfully',
        () async {
      final client = MockClient();

      networkHelper.client = client;

      when(client.get(
              'https://api.openweathermap.org/data/2.5/weather?lat=1&lon=1&appid=8f08f0f6f12fc26b507728b82e2d28e5&&units=metric'))
          .thenAnswer((_) async => http.Response(
              json.encode({
                "coord": {"lon": 1, "lat": 1},
                "weather": [
                  {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                  }
                ],
                "base": "stations",
                "main": {
                  "temp": 28.48,
                  "feels_like": 30.85,
                  "temp_min": 28.48,
                  "temp_max": 28.48,
                  "pressure": 1011,
                  "humidity": 77,
                  "sea_level": 1011,
                  "grnd_level": 1011
                },
                "visibility": 10000,
                "wind": {"speed": 4.96, "deg": 170},
                "clouds": {"all": 0},
                "dt": 1615056672,
                "sys": {"sunrise": 1615010667, "sunset": 1615054220},
                "timezone": 0,
                "id": 0,
                "name": "",
                "cod": 200
              }),
              200));

      dynamic data = await networkHelper.getData();

      expect(data, {
        "coord": {"lon": 1, "lat": 1},
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01n"
          }
        ],
        "base": "stations",
        "main": {
          "temp": 28.48,
          "feels_like": 30.85,
          "temp_min": 28.48,
          "temp_max": 28.48,
          "pressure": 1011,
          "humidity": 77,
          "sea_level": 1011,
          "grnd_level": 1011
        },
        "visibility": 10000,
        "wind": {"speed": 4.96, "deg": 170},
        "clouds": {"all": 0},
        "dt": 1615056672,
        "sys": {"sunrise": 1615010667, "sunset": 1615054220},
        "timezone": 0,
        "id": 0,
        "name": "",
        "cod": 200
      });
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockClient();

      networkHelper.client = client;

      when(client.get(
              'https://api.openweathermap.org/data/2.5/weather?lat=1&lon=1&appid=8f08f0f6f12fc26b507728b82e2d28e5&&units=metric'))
          .thenAnswer((_) async => http.Response(
              json.encode({"cod": "404", "message": "Internal error"}), 404));

      expect(networkHelper.getData(), throwsException);
    });
  });
}
