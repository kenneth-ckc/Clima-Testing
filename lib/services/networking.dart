import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;
  var client = http.Client();

  Future<dynamic> getData() async {
    final response = await client.get(url);
    dynamic data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception(data['message']);
    }
  }
}
