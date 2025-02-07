import 'package:go_router/go_router.dart';
import 'package:search_app/data/model/search_result.dart';
import 'package:search_app/presentation/search_feature/screens/detail_page.dart';
import 'package:search_app/presentation/search_feature/screens/search_page.dart';

class AppRouter {
  final GoRouter router;

  AppRouter() : router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SearchPage(),
        routes: [
          GoRoute(
            path: 'details',
            builder: (context, state) {
              final result = state.extra as SearchResult;
              return DetailsPage(result: result);
            },
          ),
        ],
      ),
    ],
  );
}
