import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/data/models/list_news_model.dart';

class NewsSourcesRepo {
  Future<newsSources> fetchNewsSources() async {
    final String apiKey = dotenv.env['API_KEY'] ?? '';
    String url =
        "https://api.mediastack.com/v1/news?access_key=$apiKey&countries=in";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return newsSources.fromJson(body);
    }
    throw Exception("error");
  }
}
