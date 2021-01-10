import 'principal_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'principal_page.dart';

class PrincipalModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $PrincipalController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => PrincipalPage()),
      ];

  static Inject get to => Inject<PrincipalModule>.of();
}
