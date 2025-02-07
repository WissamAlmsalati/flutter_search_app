import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:search_app/data/model/search_result.dart';
import 'package:search_app/presentation/search_feature/theme_cubit/theme_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:search_app/presentation/search_feature/bloc/search_cubit.dart';
import 'package:search_app/presentation/search_feature/bloc/search_state.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search'),
            actions: [
              Switch(
                value: isDarkMode,
                onChanged: (value) =>
                    context.read<ThemeCubit>().toggleTheme(value),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Enter search term',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        context
                            .read<SearchCubit>()
                            .search(_searchController.text);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<SearchCubit>()
                        .search(_searchController.text);
                  },
                  child: const Text('Search'),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (state is SearchSuccess) {
                        return ListView.builder(
                          itemCount: state.results.length,
                          itemBuilder: (context, index) {
                            final SearchResult result = state.results[index];
                            return ListTile(
                              title: Text(result.title),
                              subtitle: Text(result.description),
                              onTap: () {
                                context.push(
                                  '/details',
                                  extra: result,
                                );
                              },
                            );
                          },
                        );
                      } else if (state is SearchError) {
                        return Center(child: Text(state.error));
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
