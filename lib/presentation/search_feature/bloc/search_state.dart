



import 'package:search_app/data/model/search_result.dart';

class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<SearchResult> results;

  SearchSuccess({required this.results});
}

class SearchError extends SearchState {
  final String error;

  SearchError({required this.error});
}

