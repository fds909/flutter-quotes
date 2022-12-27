import 'package:http/http.dart' as http;
import 'dart:convert';

class QuotesRepositories {
  static Future<String> get() async {
    final url = Uri.parse("https://api.api-ninjas.com/v1/quotes");
    const apiKey = "ofJUw6tXVERTzBn1S8b4nA==DkdUZ9xHTbYgNwnX";

    final response = await http.get(url, headers: {'X-Api-Key': apiKey});

    final jsonData = json.decode(response.body);
    return jsonData[0]['quote'];
  }
}
