import 'package:climatempo_app/app/shared/util/constant.dart';
import 'package:dio/dio.dart';
import 'dio/http.dart';

class LocalizationService {
  Http _http;

  LocalizationService() {
    _http = Http(BaseOptions());
  }

  Future<Response> endereco(double latitude, double longitude) async {
    var response = await Dio().get(
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=${ConstantApp.TOKEN_MAP}",
    );

    return response;
  }
}
