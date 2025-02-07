import 'package:bloc/bloc.dart';
import 'package:search_app/domain/repostry_impl/search_repostry_impl.dart';
import 'package:search_app/presentation/search_feature/bloc/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepositoryImpl searchRepositoryImpl = SearchRepositoryImpl();

  SearchCubit() : super(SearchInitial());

  Future<void> search(String query) async {
    if (query.isEmpty) return;

    print('Searching for: $query');
    emit(SearchLoading());
    try {
      final results = await searchRepositoryImpl.search(query);
      print('Search successful, results: ${results.length}');
      emit(SearchSuccess(results: results));
    } catch (e) {
      print('Search error: $e');
      emit(SearchError(error: e.toString()));
    }
  }
}
