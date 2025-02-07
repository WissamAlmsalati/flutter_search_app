import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:search_app/data/model/search_result.dart';
import 'package:search_app/data/repostry/search_repostry.dart';

class SearchRepositoryImpl extends SearchRepository {
  final Dio dio = Dio();
  @override
  Future<List<SearchResult>> search(String query) async {
    final options = Options(headers: {
      'X-RapidAPI-Key': '07c2dff7e9msh5220551122f1450p1ce299jsnd53257de907a',
      'X-RapidAPI-Host': 'google-search74.p.rapidapi.com'
    });

    final response = await dio.get(
      'https://google-search74.p.rapidapi.com/',
      queryParameters: {'query': query, 'limit': 100, 'related_keywords': true},
      options: options,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['results'];
      return data.map((e) => SearchResult.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
