import 'package:cached_network_image/cached_network_image.dart';
import 'package:climatempo_app/app/modules/home/pages/home_detail_page.dart';
import 'package:climatempo_app/app/shared/helper/weather/weather_helper.dart' as w;
import 'package:climatempo_app/app/shared/util/colors.dart';
import 'package:climatempo_app/app/shared/util/loading.dart';
import 'package:climatempo_app/app/shared/util/screen.dart';
import 'package:climatempo_app/app/shared/util/util_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CardWeather extends StatelessWidget {
  final w.Datum weather;
  final util = UtilWeather();

  CardWeather(this.weather);

  @override
  Widget build(BuildContext context) {
    final screen = Modular.get<Screen>();

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeDetailPage(weather),
        ),
      ),
      child: Padding(
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
          child: Container(
            height: screen.screenHeightDp / 7,
            child: Center(
              child: ListTile(
                leading: Container(
                  height: 80,
                  width: 80,
                  child: CachedNetworkImage(
                    imageUrl: util.iconMomentDayUrl(weather.textIcon),
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
                        util.iconMomentDayAsset(weather.textIcon),
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
                title: Text(
                  util.titleDay(weather.date),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondary,
                  ),
                ),
                subtitle: Text(
                  "Máxima ${weather.temperature.max.round()}° - Mínima ${weather.temperature.min.round()}°",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: FloatingActionButton(
                  heroTag: weather.dateBr.toString(),
                  elevation: .5,
                  backgroundColor: AppColors.backgroundLight,
                  mini: true,
                  child: Icon(
                    MdiIcons.chevronRight,
                    color: Theme.of(context).primaryColor,
                    size: screen.setSp(70),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
