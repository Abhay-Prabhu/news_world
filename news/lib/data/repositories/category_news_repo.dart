import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news/data/models/category_news_model.dart';

class NewsCategoryRepo {
  Future<newsCategoryModel> fetchNews(String category) async {
    final String apiKey = dotenv.env['API_KEY'] ?? '';
    String url =
        "https://api.mediastack.com/v1/news?access_key=$apiKey&category=$category";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return newsCategoryModel.fromJson(body);
    }
    throw Exception("error");
  }
}
