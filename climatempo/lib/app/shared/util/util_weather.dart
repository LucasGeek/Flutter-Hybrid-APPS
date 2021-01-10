import 'package:climatempo_app/app/shared/helper/weather/weather_helper.dart' as w;
import 'package:intl/intl.dart';

class UtilWeather {
  String formatarData(DateTime data) => DateFormat("dd/MM/yyyy").format(data);

  String capitalize(String text) => text[0].toUpperCase() + text.substring(1);

  String titleDay(DateTime data) {
    var dateNow = DateTime.now();

    if (formatarData(data) == formatarData(dateNow)) {
      return "Hoje";
    } else if (formatarData(data) == formatarData(dateNow.add(Duration(days: 1)))) {
      return "Amanhã";
    } else {
      return capitalize(DateFormat("EEEE", "pt_BR").format(data));
    }
  }

  String momentDay() {
    var dateNow = DateTime.now();

    if (dateNow.hour > 0 && dateNow.hour < 6) {
      return "dawn";
    } else if (dateNow.hour > 6 && dateNow.hour < 12) {
      return "morning";
    } else if (dateNow.hour > 12 && dateNow.hour < 18) {
      return "afternoon";
    } else if (dateNow.hour > 18 && dateNow.hour < 0) {
      return "night";
    }
  }

  String iconMomentDayUrl(w.TextIcon textIcon) {
    String url = "https://www.climatempo.com.br/dist/images/";

    switch (momentDay()) {
      case "dawn":
        url = "${url + textIcon.icon.dawn}.png";
        break;
      case "morning":
        url = "${url + textIcon.icon.morning}.png";
        break;
      case "afternoon":
        url = "${url + textIcon.icon.afternoon}.png";
        break;
      case "night":
        url = "${url + textIcon.icon.night}.png";
        break;
    }

    return url;
  }

  String iconMomentDayAsset(w.TextIcon textIcon) {
    String url = "assets/weather/";

    switch (momentDay()) {
      case "dawn":
        url = "${url + textIcon.icon.dawn}.png";
        break;
      case "morning":
        url = "${url + textIcon.icon.morning}.png";
        break;
      case "afternoon":
        url = "${url + textIcon.icon.afternoon}.png";
        break;
      case "night":
        url = "${url + textIcon.icon.night}.png";
        break;
    }

    return url;
  }
}
