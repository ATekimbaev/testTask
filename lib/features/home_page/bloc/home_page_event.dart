part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class IncrementEvent extends HomePageEvent {
  final int counter;
  IncrementEvent(this.counter);
}

class DecrementEvent extends HomePageEvent {
  final int counter;
  DecrementEvent(this.counter);
}

class GetWeatherEvent extends HomePageEvent {}
