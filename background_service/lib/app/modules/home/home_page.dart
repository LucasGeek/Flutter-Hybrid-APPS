import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: controller.isExecute ? Colors.red : null,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => controller.isExecute
                ? controller.stopService()
                : controller.startService(),
            label: Text(controller.isExecute ? "Pausar" : "Iniciar"),
            icon: Icon(controller.isExecute ? Icons.pause : Icons.play_arrow),
            backgroundColor: controller.isExecute ? Colors.red : null,
          ),
          body: Column(
            children: <Widget>[],
          ),
        );
      },
    );
  }
}
