import 'package:permission_handler/permission_handler.dart';

import '../util/toast_message.dart';

class PermissionHelper {
  Future<bool> verifyPermission() async {
    bool location = await Permission.location.isGranted;
    bool notification = await Permission.notification.isGranted;

    return (location && notification);
  }

  Future<bool> enablePermission() async {
    bool isGrantedNotification = false;
    bool isGrantedLocation = false;

    Map<Permission, PermissionStatus> permissions = await [
      Permission.location,
      Permission.notification,
    ].request();

    switch (permissions[Permission.location]) {
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        isGrantedLocation = false;
        break;
      case PermissionStatus.permanentlyDenied:
        ToastMessage.notificationError("Ops..!", "É necessario conceder a permissão de localização!");

        Future.delayed(Duration(seconds: 2), () => openAppSettings());
        break;
      case PermissionStatus.granted:
        isGrantedLocation = true;
        break;
      default:
        break;
    }

    switch (permissions[Permission.notification]) {
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        isGrantedNotification = false;
        break;
      case PermissionStatus.permanentlyDenied:
        ToastMessage.notificationError("Ops..!", "É necessario conceder a permissão de notificação!");

        Future.delayed(Duration(seconds: 2), () => openAppSettings());
        break;
      case PermissionStatus.granted:
        isGrantedNotification = true;
        break;
      default:
        break;
    }

    return (isGrantedNotification && isGrantedLocation);
  }
}
