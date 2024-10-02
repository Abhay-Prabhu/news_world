import 'package:news/data/models/list_news_model.dart';
import 'package:news/data/repositories/list_news_repo.dart';

class NewsSourcesView{
  final _repo = NewsSourcesRepo();

  Future <newsSources> fetchNewsSources() async{
    
    final response = await _repo.fetchNewsSources();
    return response;
  }
}