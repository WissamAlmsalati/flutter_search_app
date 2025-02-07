import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_app/data/model/search_result.dart';
import 'package:search_app/presentation/search_feature/theme_cubit/theme_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  final SearchResult result;

  const DetailsPage({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return Scaffold(
          appBar: AppBar(
            title: Text(result.title),
            actions: [
              // Keep the theme switch in the AppBar if desired.
              Switch(
                value: isDarkMode,
                onChanged: (value) =>
                    context.read<ThemeCubit>().toggleTheme(value),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    result.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final Uri uri = Uri.parse(result.url);
                        final bool launched = await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                        if (!launched) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Could not launch URL'),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error launching URL: $e')),
                        );
                      }
                    },
                    child: const Text('Open URL'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
