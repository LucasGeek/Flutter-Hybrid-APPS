import 'package:climatempo_app/app/shared/util/constant.dart';
import 'package:dio/dio.dart';

import 'dio/http.dart';

class CityService {
  Http _http;

  CityService() {
    _http = Http(BaseOptions());
  }

  Future<Response> getCity(String city, String state) async {
    var response = await _http.get(
      "/api/v1/locale/city?name=$city&state=$state&token=${ConstantApp.TOKEN}",
    );

    return response;
  }

  Future<Response> getCities() async {
    var response = await _http.get(
      "/api-manager/user-token/${ConstantApp.TOKEN}/locales",
    );

    return response;
  }

  Future<Response> setCity(int id) async {
    Map<String, String> body = {
      'localeId[]': '$id',
    };

    var response = await _http.put(
      "/api-manager/user-token/${ConstantApp.TOKEN}/locales",
      data: body,
      options: Options(
        contentType: "application/x-www-form-urlencoded",
      ),
    );

    return response;
  }
}
