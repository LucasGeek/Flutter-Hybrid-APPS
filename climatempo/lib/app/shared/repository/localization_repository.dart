import 'dart:convert';

import 'package:climatempo_app/app/shared/helper/generic_result_helper.dart';
import 'package:climatempo_app/app/shared/helper/geo_location_google_helper.dart';
import 'package:climatempo_app/app/shared/service/localization_service.dart';
import 'package:climatempo_app/app/shared/util/connectivity_network.dart';

class LocalizationRepository {
  LocalizationService _service;

  LocalizationRepository() {
    _service = LocalizationService();
  }

  Future<GenericResultHelper> buscarEndereco(double latitude, double longitude) async {
    if (await ConnectivityNetwork.isConnected()) {
      final response = await _service.endereco(latitude, longitude);

      if (response.statusCode == 200) {
        var geoLocation = GeoLocationGoogleHelper.fromJson(jsonDecode(response.data));

        if (geoLocation.status == "OK") {
          return GenericResultHelper(
            success: true,
            message: "Sucesso obter o endereço",
            data: geoLocation,
          );
        } else {
          return GenericResultHelper(
            success: false,
            message: "Ocorreu um erro ao obter o endereço",
          );
        }
      } else {
        return GenericResultHelper(
          success: false,
          message: "Ocorreu um erro ao buscar o endereço",
        );
      }
    } else {
      return GenericResultHelper(
        success: false,
        message: "Verifique sua conexão com a internet!",
      );
    }
  }
}
