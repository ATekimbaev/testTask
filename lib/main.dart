import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core/dio/dio_settings.dart';
import 'package:test_task/core/theme/theme_builder.dart';
import 'package:test_task/features/home_page/bloc/home_page_bloc.dart';
import 'package:test_task/features/home_page/repositories/get_weather_repo.dart';

import 'features/home_page/ui/screens/home_page_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DioSettings(),
        ),
        RepositoryProvider(
          create: (context) => GetWeatherRepo(
              dio: RepositoryProvider.of<DioSettings>(context).dio),
        ),
      ],
      child: BlocProvider(
        create: (context) =>
            HomePageBloc(repo: RepositoryProvider.of<GetWeatherRepo>(context)),
        child: Builder(builder: (
          context,
        ) {
          return ThemeBuilder(
            defaultBrightness: Brightness.dark,
            builder: (context, brightness) => MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                brightness: brightness,
              ),
              home: const MyHomePage(),
            ),
          );
        }),
      ),
    );
  }
}
