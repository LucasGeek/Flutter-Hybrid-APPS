import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
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
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () => controller.setVal(description),
        child: Container(
          height: 90,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            backgroundColor: CupertinoTheme.of(context).primaryColor,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      color: Colors.orangeAccent,
                      child: Observer(
                        builder: (context) {
                          return Text(
                            controller.value,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 132,
                              color: Colors.white70,
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
                                  description: "/",
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
                                  description: "X",
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
          )
        : Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(),
                  ),
                ],
              ),
            ),
          );
  }
}
