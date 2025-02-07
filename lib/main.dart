import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:search_app/presentation/search_feature/bloc/search_cubit.dart';
import 'package:search_app/presentation/search_feature/theme_cubit/theme_cubit.dart';
import 'package:search_app/app_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(
          create: (_) => SearchCubit(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Search App',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routerConfig: _appRouter.router,
          );
        },
      ),
    );
  }
}
