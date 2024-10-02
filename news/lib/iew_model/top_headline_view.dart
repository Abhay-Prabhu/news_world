import 'package:news/data/models/top_headlines_model.dart.dart';
import 'package:news/data/repositories/top_headline_repo.dart';

class TopHeadlineView {
  final _repo = TopHeadlinesRepo();

  Future<TopHeadline> fetchTopHeadlines(String selectedOption) async {
    final response = await _repo.fetchTopHeadlines(selectedOption);
    return response;
  }
}
