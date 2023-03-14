part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageSuccess extends HomePageState {
  final int? counter;
  final WeatherModel? model;
  HomePageSuccess({this.counter, this.model});
}

class HomePageError extends HomePageState {}

class HomePageLoading extends HomePageState {}
