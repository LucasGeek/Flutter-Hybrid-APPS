import 'dart:async';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:location/location.dart';

import 'latlng_helper.dart';

class LocationHelper {
  static Future<LatLngHelper> getCurrentLocation() async {
    double latitude = 0.0;
    double longitude = 0.0;

    var localizacao = await geo.Geolocator()
        .getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high)
        .timeout(Duration(seconds: 5), onTimeout: () async {
      geo.Position position = await geo.Geolocator().getLastKnownPosition(desiredAccuracy: geo.LocationAccuracy.high);
      return position;
    });

    if (localizacao == null || (localizacao.latitude == null || localizacao.longitude == null)) {
      var location = await Location().getLocation();

      if (location == null || (location.latitude == null || location.longitude == null)) {
        latitude = location.latitude;
        longitude = location.longitude;
      }
    } else {
      latitude = localizacao.latitude;
      longitude = localizacao.longitude;
    }

    return LatLngHelper(latitude, longitude);
  }
}

class LocationService {
  final _location = Location();

  StreamController<LatLngHelper> _locationController = StreamController<LatLngHelper>()..add(LatLngHelper(0.0, 0.0));

  Stream<LatLngHelper> get locationStream => _locationController.stream;

  LocationService() {
    // Request permission to use location
    _location.serviceEnabled().then((granted) {
      if (granted) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        _location.onLocationChanged.listen((LocationData locationData) {
          if (locationData != null) {
            _locationController.add(LatLngHelper(
              locationData.latitude,
              locationData.longitude,
            ));
          } else {
            LocationHelper.getCurrentLocation().then((location) {
              _locationController.add(LatLngHelper(
                location.latitude,
                location.longitude,
              ));
            });
          }
        });
      }
    });
  }
}
