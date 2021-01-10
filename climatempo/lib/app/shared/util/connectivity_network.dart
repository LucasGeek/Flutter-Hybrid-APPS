import 'package:connectivity/connectivity.dart';

class ConnectivityNetwork {
  static Future<bool> isConnected() async {
    return await Connectivity().checkConnectivity() != ConnectivityResult.none;
  }
}
