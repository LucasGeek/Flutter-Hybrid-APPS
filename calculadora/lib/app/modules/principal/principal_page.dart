import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'principal_controller.dart';

class PrincipalPage extends StatefulWidget {
  final String title;
  const PrincipalPage({Key key, this.title = "Principal"}) : super(key: key);

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends ModularState<PrincipalPage, PrincipalController> {
  Widget createButton({
    String description = "",
    Color color = Colors.grey,
    Color textColor = Colors.white,
    int flex = 1,
  }) {
    return Platform.isIOS
        ? Expanded(
            flex: flex,
            child: GestureDetector(
              onTap: () => controller.setVal(description),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  shape: flex != 1 ? BoxShape.rectangle : BoxShape.circle,
                  borderRadius: flex != 1 ? BorderRadius.all(Radius.circular(50)) : null,
                ),
                child: Center(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 32,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ),
          )
        : Expanded(
            flex: flex,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 10,
              ),
              child: RawMaterialButton(
                onPressed: () => controller.setVal(description),
                constraints: BoxConstraints(),
                elevation: 0.0,
                child: Center(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 32,
                      color: textColor,
                    ),
                  ),
                ),
                shape: CircleBorder(),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
            ),
            child: CupertinoPageScaffold(
              backgroundColor: CupertinoTheme.of(context).primaryColor,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(24.0),
                        width: double.infinity,
                        height: double.infinity,
                        child: Observer(
                          builder: (context) {
                            return Text(
                              controller.value,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 132,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  createButton(
                                    description: "AC",
                                    textColor: Colors.black87,
                                  ),
                                  createButton(
                                    description: "+/-",
                                    textColor: Colors.black87,
                                  ),
                                  createButton(
                                    description: "%",
                                    textColor: Colors.black87,
                                  ),
                                  createButton(
                                    description: "÷",
                                    color: Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  createButton(
                                    description: "7",
                                    color: Colors.white12,
                                  ),
                                  createButton(
                                    description: "8",
                                    color: Colors.white12,
                                  ),
                                  createButton(
                                    description: "9",
                                    color: Colors.white12,
                                  ),
                                  createButton(
                                    description: "×",
                                    color: Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  createButton(
                                    description: "4",
                                    color: Colors.white12,
                                  ),
                                  createButton(
                                    description: "5",
                                    color: Colors.white12,
                                  ),
                                  createButton(
                                    description: "6",
                                    color: Colors.white12,
                                  ),
                                  createButton(
                                    description: "-",
                                    color: Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  createButton(
                                    description: "1",
                                    color: Colors.white12,
                                  ),
                                  createButton(
                                    description: "2",
                                    color: Colors.white12,
                                  ),
                                  createButton(
                                    description: "3",
                                    color: Colors.white12,
                                  ),
                                  createButton(
                                    description: "+",
                                    color: Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  createButton(
                                    description: "0",
                                    flex: 2,
                                    color: Colors.white12,
                                  ),
                                  createButton(
                                    description: ",",
                                    color: Colors.white12,
                                  ),
                                  createButton(
                                    description: "=",
                                    color: Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Theme.of(context).primaryColor,
              systemNavigationBarDividerColor: Colors.black26,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(24.0),
                        width: double.infinity,
                        height: double.infinity,
                        child: Observer(
                          builder: (context) {
                            return Text(
                              controller.value,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 120,
                                color: Colors.black87,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        createButton(
                                          description: "7",
                                          textColor: Colors.black54,
                                        ),
                                        createButton(
                                          description: "8",
                                          textColor: Colors.black54,
                                        ),
                                        createButton(
                                          description: "9",
                                          textColor: Colors.black54,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        createButton(
                                          description: "4",
                                          textColor: Colors.black54,
                                        ),
                                        createButton(
                                          description: "5",
                                          textColor: Colors.black54,
                                        ),
                                        createButton(
                                          description: "6",
                                          textColor: Colors.black54,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        createButton(
                                          description: "1",
                                          textColor: Colors.black54,
                                        ),
                                        createButton(
                                          description: "2",
                                          textColor: Colors.black54,
                                        ),
                                        createButton(
                                          description: "3",
                                          textColor: Colors.black54,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        createButton(
                                          description: "0",
                                          textColor: Colors.black54,
                                        ),
                                        createButton(
                                          description: ".",
                                          textColor: Colors.black54,
                                        ),
                                        createButton(
                                          description: "=",
                                          textColor: Colors.black54,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.black26,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  createButton(
                                    description: "C",
                                    textColor: Theme.of(context).accentColor,
                                  ),
                                  createButton(
                                    description: "/",
                                    textColor: Theme.of(context).accentColor,
                                  ),
                                  createButton(
                                    description: "×",
                                    textColor: Theme.of(context).accentColor,
                                  ),
                                  createButton(
                                    description: "-",
                                    textColor: Theme.of(context).accentColor,
                                  ),
                                  createButton(
                                    description: "+",
                                    textColor: Theme.of(context).accentColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
