import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core/theme/theme_builder.dart';
import 'package:test_task/features/home_page/bloc/home_page_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyIncrementBlocState();
}

class _MyIncrementBlocState extends State<MyHomePage> {
  int _counter = 0;
  final int _maxCounterValue = 10;
  final int _minCounterValue = 0;
  final IconData _iconLight = Icons.wb_sunny;
  final IconData _iconDark = Icons.nights_stay;
  bool _isDark = false;

  String? currentWeather;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomePageBloc, HomePageState>(
      listener: (context, state) {
        if (state is HomePageSuccess) {
          _counter = state.counter ?? 0;
          currentWeather = state.model?.main?.temp.toString() ?? 'Not found';
          setState(() {});
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weather counter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Current weather is $currentWeather'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      buttonPress(context, GetWeatherEvent());
                    },
                    child: const Icon(Icons.cloud_circle),
                  ),
                  const SizedBox(height: 10),
                  FloatingActionButton(
                    onPressed: () {
                      _isDark = !_isDark;
                      ThemeBuilder.of(context)?.changeTheme();
                    },
                    child: Icon(_isDark ? _iconDark : _iconLight),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _counter < _maxCounterValue
                      ? FloatingActionButton(
                          onPressed: () {
                            buttonPress(context, IncrementEvent(_counter));
                          },
                          child: const Icon(Icons.add),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 10),
                  _counter > _minCounterValue
                      ? FloatingActionButton(
                          onPressed: () {
                            buttonPress(context, DecrementEvent(_counter));
                          },
                          child: const Icon(Icons.remove),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void buttonPress(BuildContext context, HomePageEvent event) {
    BlocProvider.of<HomePageBloc>(context).add(event);
  }
}
