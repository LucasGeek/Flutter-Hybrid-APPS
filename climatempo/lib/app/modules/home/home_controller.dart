import 'package:climatempo_app/app/shared/helper/geo_location_google_helper.dart';
import 'package:climatempo_app/app/shared/helper/weather/weather_helper.dart';
import 'package:climatempo_app/app/shared/repository/city_repository.dart';
import 'package:climatempo_app/app/shared/repository/localization_repository.dart';
import 'package:climatempo_app/app/shared/repository/weather_repository.dart';
import 'package:climatempo_app/app/shared/util/location.dart';
import 'package:climatempo_app/app/shared/util/toast_message.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final LocalizationRepository _localizationRepository = Modular.get<LocalizationRepository>();
  final CityRepository _cityRepository = Modular.get<CityRepository>();
  final WeatherRepository _weatherRepository = Modular.get<WeatherRepository>();

  _HomeControllerBase() {
    get();
  }

  @observable
  bool loadingWeather = false;

  @observable
  String endereco = "";

  @observable
  WeatherHelper weather = WeatherHelper();

  @action
  Future<void> get({bool force = false}) async {
    endereco = "";
    String cidadeEndereco = "";
    String estadoEndereco = "";

    var location = await LocationHelper.getCurrentLocation();

    if (location.latitude != 0 && location.longitude != 0) {
      try {
        final List<Placemark> placemarks = await Geolocator().placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );

        placemarks.forEach((item) {
          String cidade = item.subAdministrativeArea;
          String estado = acronymName(item.administrativeArea);

          endereco = "$cidade - $estado";
          cidadeEndereco = cidade;
          estadoEndereco = estado;
        });
      } catch (e) {
        var genericLocalization = await _localizationRepository.buscarEndereco(location.latitude, location.longitude);

        if (genericLocalization.success) {
          GeoLocationGoogleHelper geoLocationGoogleHelper = genericLocalization.data;

          String cidade = geoLocationGoogleHelper.results[0].addressComponents[3].longName;
          String estado = geoLocationGoogleHelper.results[0].addressComponents[4].shortName;

          endereco = "$cidade - $estado";
          cidadeEndereco = cidade;
          estadoEndereco = estado;
        } else {
          ToastMessage.notificationError("Ops..!", genericLocalization.message);
        }
      }

      loadingWeather = false;
      if (cidadeEndereco.isNotEmpty && estadoEndereco.isNotEmpty) {
        var genericCity = force
            ? await _cityRepository.getCity(cidadeEndereco, estadoEndereco)
            : await _cityRepository.getCityLocal(cidadeEndereco, estadoEndereco);

        if (genericCity.success) {
          var genericWeather = force
              ? await _weatherRepository.getWeather(genericCity.data)
              : await _weatherRepository.getWeatherLocal(genericCity.data);

          if (genericWeather.success) {
            weather = genericWeather.data as WeatherHelper;
          } else {
            ToastMessage.notificationError("Ops..!", genericWeather.message);
          }
        } else {
          ToastMessage.notificationError("Ops..!", genericCity.message);
        }
      }
      loadingWeather = true;
    } else {
      endereco = "Não foi possível carregar o endereço...";
    }
  }

  String acronymName(String name) {
    switch (name) {
      case "Acre":
        return "AC";
      case "Alagoas":
        return "AL";
      case "Amapá":
        return "AP";
      case "Amazonas":
        return "AM";
      case "Bahia":
        return "BA";
      case "Ceará":
        return "CE";
      case "Espírito Santo":
        return "ES";
      case "Goiás":
        return "GO";
      case "Maranhão":
        return "MA";
      case "Mato Grosso":
        return "MT";
      case "Mato Grosso do Sul":
        return "MS";
      case "Minas Gerais":
        return "MG";
      case "Pará":
        return "PA";
      case "Paraíba":
        return "PB";
      case "Paraná":
        return "PR";
      case "Pernambuco":
        return "PE";
      case "Piauí":
        return "PI";
      case "Rio de Janeiro":
        return "RJ";
      case "Rio Grande do Norte":
        return "RN";
      case "Rio Grande do Sul":
        return "RS";
      case "Rondônia":
        return "RO";
      case "Roraima":
        return "RR";
      case "Santa Catarina":
        return "SC";
      case "São Paulo":
        return "SP";
      case "Sergipe":
        return "SE";
      case "Tocantins":
        return "TO";
      case "Distrito Federal":
      case "Brasília":
        return "DF";
    }
  }
}
