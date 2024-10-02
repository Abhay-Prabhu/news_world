import 'package:news/data/models/category_news_model.dart';
import 'package:news/data/repositories/category_news_repo.dart';

class NewsCategoryView{

  final _repo = NewsCategoryRepo();

  Future <newsCategoryModel> fetchNewsSources(String category) async{
    
    final response = await _repo.fetchNews(category);
    return response;
  }
} 