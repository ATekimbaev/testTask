import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_task/core/consts/app_consts.dart';
import 'package:test_task/features/home_page/models/weather_model.dart';

class GetWeatherRepo {
  final Dio dio;

  double currentLat = 0;
  double currentLng = 0;

  GetWeatherRepo({required this.dio});

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    await Geolocator.getCurrentPosition().then(
      (value) => {
        currentLat = value.latitude,
        currentLng = value.longitude,
      },
    );
  }

  Future<WeatherModel> getWeather() async {
    await _determinePosition();
    final result = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather?',
      queryParameters: {
        'lat': currentLat,
        'lon': currentLng,
        'appid': AppConsts.openWeatherApiKey,
      },
    );
    return WeatherModel.fromJson(result.data);
  }
}
