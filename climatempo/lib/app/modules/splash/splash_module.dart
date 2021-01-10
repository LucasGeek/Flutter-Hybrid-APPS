import 'package:climatempo_app/app/modules/splash/splash_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:climatempo_app/app/modules/splash/pages/splash_page.dart';

import 'pages/permission_page.dart';

class SplashModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SplashController()),
      ];

  @override
  List<Router> get routers => [
        Router(
          Modular.initialRoute,
          child: (_, args) => SplashPage(),
          transition: TransitionType.fadeIn,
        ),
        Router(
          '/permission',
          child: (_, args) => PermissionPage(),
          transition: TransitionType.fadeIn,
        ),
      ];

  static Inject get to => Inject<SplashModule>.of();
}
