import 'package:climatempo_app/app/shared/util/constant.dart';
import 'package:dio/dio.dart';

import 'dio/http.dart';

class WeatherService {
  Http _http;

  WeatherService() {
    _http = Http(BaseOptions());
  }

  Future<Response> getCity(String city, String state) async {
    var response = await _http.get(
      "/api/v1/locale/city?name=$city&state=$state&token=${ConstantApp.TOKEN}",
    );

    return response;
  }

  Future<Response> weather(int cityId) async {
    var response = await _http.get(
      "/api/v1/forecast/locale/$cityId/days/15?token=${ConstantApp.TOKEN}",
    );

    return response;
  }

  Future<Response> weatherMoment(int cityId) async {
    var response = await _http.get(
      "/api/v1/weather/locale/$cityId/current?token=${ConstantApp.TOKEN}",
    );

    return response;
  }
}
