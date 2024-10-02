import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/data/models/top_headlines_model.dart.dart';

class TopHeadlinesRepo {
  Future<TopHeadline> fetchTopHeadlines(String selectedOption) async {
    final String apiKey = dotenv.env['API_KEY'] ?? '';
    String url =
        "https://api.mediastack.com/v1/news?access_key=$apiKey&sources=$selectedOption";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return TopHeadline.fromJson(body);
    }
    throw Exception("error");
  }
}
