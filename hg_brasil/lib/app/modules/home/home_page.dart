import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

import '../../app_controller.dart';

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
        if (controller.app.isCupertino) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(widget.title),
            ),
            child: Column(
              children: <Widget>[],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Column(
              children: <Widget>[],
            ),
          );
        }
      },
    );
  }
}
