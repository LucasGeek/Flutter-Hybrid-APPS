import 'package:climatempo_app/app/shared/helper/weather/weather_helper.dart' as w;
import 'package:climatempo_app/app/shared/util/colors.dart';
import 'package:climatempo_app/app/shared/util/screen.dart';
import 'package:climatempo_app/app/shared/util/util_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeDetailPage extends StatelessWidget {
  final w.Datum weather;
  final util = UtilWeather();

  HomeDetailPage(this.weather);

  @override
  Widget build(BuildContext context) {
    final screen = Modular.get<Screen>();

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        centerTitle: true,
        title: Text(util.titleDay(weather.date)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: screen.setWidth(40),
                    right: screen.setWidth(40),
                    top: screen.setHeight(20),
                    bottom: screen.setHeight(20),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Título",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondary,
                            fontSize: screen.setSp(45),
                          ),
                        ),
                        subtitle: Text(
                          "${weather.textIcon.text.phrase.reduced}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: screen.setSp(35),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screen.setWidth(40),
                right: screen.setWidth(40),
                top: screen.setHeight(20),
                bottom: screen.setHeight(20),
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Temperatura",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondary,
                            fontSize: screen.setSp(45),
                          ),
                        ),
                        subtitle: Text(
                          "Máxima ${weather.temperature.max.round()}° - Mínima ${weather.temperature.min.round()}°",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: screen.setSp(35),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            child: ListTile(
                              title: Text(
                                "Madrugada",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.secondary,
                                  fontSize: screen.setSp(35),
                                ),
                              ),
                              subtitle: Text(
                                "Máxima ${weather.temperature.dawn.max.round()}° - Mínima ${weather.temperature.dawn.min.round()}°",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screen.setSp(30),
                                ),
                              ),
                            ),
                            width: screen.screenHeightDp / 4,
                          ),
                          Container(
                            child: ListTile(
                              title: Text(
                                "Manhã",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.secondary,
                                  fontSize: screen.setSp(35),
                                ),
                              ),
                              subtitle: Text(
                                "Máxima ${weather.temperature.morning.max.round()}° - Mínima ${weather.temperature.morning.min.round()}°",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screen.setSp(30),
                                ),
                              ),
                            ),
                            width: screen.screenHeightDp / 4,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            child: ListTile(
                              title: Text(
                                "Tarde",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.secondary,
                                  fontSize: screen.setSp(35),
                                ),
                              ),
                              subtitle: Text(
                                "Máxima ${weather.temperature.afternoon.max.round()}° - Mínima ${weather.temperature.afternoon.min.round()}°",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screen.setSp(30),
                                ),
                              ),
                            ),
                            width: screen.screenHeightDp / 4,
                          ),
                          Container(
                            child: ListTile(
                              title: Text(
                                "Noite",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.secondary,
                                  fontSize: screen.setSp(35),
                                ),
                              ),
                              subtitle: Text(
                                "Máxima ${weather.temperature.night.max.round()}° - Mínima ${weather.temperature.night.min.round()}°",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screen.setSp(30),
                                ),
                              ),
                            ),
                            width: screen.screenHeightDp / 4,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screen.setWidth(40),
                right: screen.setWidth(40),
                top: screen.setHeight(20),
                bottom: screen.setHeight(20),
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Humidade",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondary,
                            fontSize: screen.setSp(45),
                          ),
                        ),
                        subtitle: Text(
                          "Máxima ${weather.humidity.max.round()}% - Mínima ${weather.humidity.min.round()}%",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: screen.setSp(35),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            child: ListTile(
                              title: Text(
                                "Madrugada",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.secondary,
                                  fontSize: screen.setSp(35),
                                ),
                              ),
                              subtitle: Text(
                                "Máxima ${weather.humidity.dawn.max.round()}% - Mínima ${weather.humidity.dawn.min.round()}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screen.setSp(30),
                                ),
                              ),
                            ),
                            width: screen.screenHeightDp / 4,
                          ),
                          Container(
                            child: ListTile(
                              title: Text(
                                "Manhã",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.secondary,
                                  fontSize: screen.setSp(35),
                                ),
                              ),
                              subtitle: Text(
                                "Máxima ${weather.humidity.morning.max.round()}% - Mínima ${weather.humidity.morning.min.round()}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screen.setSp(30),
                                ),
                              ),
                            ),
                            width: screen.screenHeightDp / 4,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            child: ListTile(
                              title: Text(
                                "Tarde",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.secondary,
                                  fontSize: screen.setSp(35),
                                ),
                              ),
                              subtitle: Text(
                                "Máxima ${weather.humidity.afternoon.max.round()}% - Mínima ${weather.humidity.afternoon.min.round()}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screen.setSp(30),
                                ),
                              ),
                            ),
                            width: screen.screenHeightDp / 4,
                          ),
                          Container(
                            child: ListTile(
                              title: Text(
                                "Noite",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.secondary,
                                  fontSize: screen.setSp(35),
                                ),
                              ),
                              subtitle: Text(
                                "Máxima ${weather.humidity.night.max.round()}% - Mínima ${weather.humidity.night.min.round()}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screen.setSp(30),
                                ),
                              ),
                            ),
                            width: screen.screenHeightDp / 4,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
