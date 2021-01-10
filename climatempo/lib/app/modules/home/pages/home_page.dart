import 'package:cached_network_image/cached_network_image.dart';
import 'package:climatempo_app/app/modules/home/widgets/card_weather.dart';
import 'package:climatempo_app/app/shared/util/button.dart';
import 'package:climatempo_app/app/shared/util/colors.dart';
import 'package:climatempo_app/app/shared/util/loading.dart';
import 'package:climatempo_app/app/shared/util/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Clima tempo"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final screen = Modular.get<Screen>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        centerTitle: true,
        title: Text("Clima Tempo"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.get(force: true);
        },
        child: Observer(
          builder: (context) {
            if (controller.loadingWeather) {
              if (controller.weather != null && controller.weather.data != null) {
                if (controller.weather.moment != null) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: screen.setWidth(40),
                          right: screen.setWidth(40),
                          top: screen.setHeight(20),
                          bottom: screen.setHeight(20),
                        ),
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 2.0,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 16.0,
                                    left: 8.0,
                                    right: 8.0,
                                    bottom: 12.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        MdiIcons.mapMarker,
                                        size: screen.setSp(75),
                                        color: AppColors.primary,
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        controller.endereco,
                                        style: TextStyle(
                                          fontSize: screen.setSp(50),
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.primary,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.0,
                                    left: 8.0,
                                    right: 8.0,
                                    bottom: 12.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: 80,
                                        width: 80,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://www.climatempo.com.br/dist/images/${controller.weather.moment.icon}.png",
                                          placeholder: (context, url) => Container(
                                            child: Center(
                                              child: ThreeSizeDot(
                                                color_1: AppColors.primary,
                                                color_2: AppColors.primary,
                                                color_3: AppColors.primary,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) {
                                            return Image.asset(
                                              "assets/weather/${controller.weather.moment.icon}.png",
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 32.0,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            "${controller.weather.moment.temperature.round()}°",
                                            style: TextStyle(
                                              fontSize: screen.setSp(120),
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            "${controller.weather.moment.condition}",
                                            style: TextStyle(
                                              fontSize: screen.setSp(45),
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Sensação",
                                              style: TextStyle(
                                                fontSize: screen.setSp(35),
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Text(
                                              "${controller.weather.moment.sensation.round()}°",
                                              style: TextStyle(
                                                fontSize: screen.setSp(35),
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Umidade",
                                              style: TextStyle(
                                                fontSize: screen.setSp(35),
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Text(
                                              "${controller.weather.moment.humidity.round()} %",
                                              style: TextStyle(
                                                fontSize: screen.setSp(35),
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Pressão",
                                              style: TextStyle(
                                                fontSize: screen.setSp(35),
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Text(
                                              "${controller.weather.moment.pressure.round()} hPa",
                                              style: TextStyle(
                                                fontSize: screen.setSp(35),
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Vento",
                                              style: TextStyle(
                                                fontSize: screen.setSp(35),
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Text(
                                              "${controller.weather.moment.windVelocity.round()} km/h",
                                              style: TextStyle(
                                                fontSize: screen.setSp(35),
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Última atualização às ${DateFormat("dd/MM/yyyy hh:mm:ss").format(controller.weather.moment.date)}",
                                    style: TextStyle(
                                      fontSize: screen.setSp(35),
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.weather.data.length,
                          itemBuilder: (context, index) {
                            return CardWeather(controller.weather.data[index]);
                          },
                        ),
                      )
                    ],
                  );
                } else {
                  return ListView.builder(
                    itemCount: controller.weather.data.length,
                    itemBuilder: (context, index) {
                      return CardWeather(controller.weather.data[index]);
                    },
                  );
                }
              } else {
                return Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Não foi possível carregar o clima!",
                          style: TextStyle(
                            fontSize: screen.setSp(45),
                            fontWeight: FontWeight.w800,
                            color: Colors.black54,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DefaultButton(
                            "Recarregar",
                            () async {
                              await controller.get();
                            },
                            width: screen.setWidth(screen.width * .6),
                            colorButton: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            } else {
              return Center(
                child: ThreeSizeDot(
                  color_1: AppColors.primary,
                  color_2: AppColors.primary,
                  color_3: AppColors.primary,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
