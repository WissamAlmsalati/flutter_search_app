

import 'package:search_app/data/model/search_result.dart';

abstract class SearchRepository {
  Future<List<SearchResult>> search(String query);
}

