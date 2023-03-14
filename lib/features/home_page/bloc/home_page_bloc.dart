import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_task/features/home_page/models/weather_model.dart';
import 'package:test_task/features/home_page/repositories/get_weather_repo.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc({required this.repo}) : super(HomePageInitial()) {
    on<IncrementEvent>((event, emit) {
      final result = event.counter + 1;
      emit(HomePageSuccess(counter: result));
    });
    on<DecrementEvent>((event, emit) {
      final result = event.counter - 1;
      emit(HomePageSuccess(counter: result));
    });
    on<GetWeatherEvent>((event, emit) async {
      try {
        emit(HomePageLoading());
        final result = await repo.getWeather();
        emit(HomePageSuccess(model: result));
      } catch (e) {
        emit(HomePageError());
      }
    });
  }
  final GetWeatherRepo repo;
}
