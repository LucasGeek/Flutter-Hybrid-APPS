import 'dart:convert';

import 'package:climatempo_app/app/shared/database/_db/moor_database.dart';
import 'package:climatempo_app/app/shared/helper/city/city_helper.dart';
import 'package:climatempo_app/app/shared/helper/city/registered_cities_helper.dart';
import 'package:climatempo_app/app/shared/helper/generic_result_helper.dart';
import 'package:climatempo_app/app/shared/service/city_service.dart';
import 'package:climatempo_app/app/shared/util/connectivity_network.dart';

class CityRepository {
  CityService _service;
  MoorDatabase _db;

  CityRepository(MoorDatabase db) {
    _service = CityService();

    _db = db;
  }

  Future<GenericResultHelper> getCityLocal(String city, String state) async {
    CityModel cityModel = await _db.cityLocalDAO.getCityByName(city, state);

    if (cityModel != null) {
      return GenericResultHelper(
        success: true,
        message: "Sucesso ao buscar a cidade",
        data: CityHelper(
          id: cityModel.id,
          name: cityModel.name,
          state: cityModel.state,
          country: cityModel.country,
        ),
      );
    } else {
      return getCity(city, state);
    }
  }

  Future<GenericResultHelper> getCity(String city, String state) async {
    if (await ConnectivityNetwork.isConnected()) {
      var response = await _service.getCity(city, state);

      if (response.statusCode == 200) {
        List cities = CityHelper.listFromJson(response.data);

        if (cities.length != 0) {
          var generic = await verifyCity(cities.first);

          if (generic.success) {
            return GenericResultHelper(
              success: true,
              message: "Sucesso ao buscar a cidade",
              data: cities.first,
            );
          } else {
            return generic;
          }
        } else {
          return GenericResultHelper(
            success: false,
            message: "Cidade não encontrada",
          );
        }
      } else {
        final Map<String, dynamic> decodedMessage = json.decode(response.toString());

        return GenericResultHelper(
          success: false,
          message: "Ocorreu um erro ao buscar a cidade. ${decodedMessage['detail']}",
        );
      }
    } else {
      return GenericResultHelper(
        success: false,
        message: "Sem conexão com a internet. Verifique!",
      );
    }
  }

  Future<GenericResultHelper> verifyCity(CityHelper city) async {
    if (await ConnectivityNetwork.isConnected()) {
      var response = await _service.getCities();

      if (response.statusCode == 200) {
        var cities = RegisteredCitiesHelper.fromJson(response.data);

        if (cities.locales.contains(city.id)) {
          return GenericResultHelper(
            success: true,
            message: "Essa cidade está cadastrada",
            data: city,
          );
        } else {
          return registerCity(city);
        }
      } else {
        final Map<String, dynamic> decodedMessage = json.decode(response.toString());

        return GenericResultHelper(
          success: false,
          message: "Ocorreu um erro ao buscar lista das cidades cadastradas. ${decodedMessage['detail']}",
        );
      }
    } else {
      return GenericResultHelper(
        success: false,
        message: "Sem conexão com a internet. Verifique!",
      );
    }
  }

  Future<GenericResultHelper> registerCity(CityHelper city) async {
    if (await ConnectivityNetwork.isConnected()) {
      var response = await _service.setCity(city.id);

      if (response.statusCode == 200) {
        return GenericResultHelper(
          success: true,
          message: "Cidade cadastrada com sucesso!",
          data: city,
        );
      } else {
        final Map<String, dynamic> decodedMessage = json.decode(response.toString());

        return GenericResultHelper(
          success: false,
          message: "Ocorreu um erro ao cadastra a cidade. ${decodedMessage['detail']}",
        );
      }
    } else {
      return GenericResultHelper(
        success: false,
        message: "Sem conexão com a internet. Verifique!",
      );
    }
  }
}
