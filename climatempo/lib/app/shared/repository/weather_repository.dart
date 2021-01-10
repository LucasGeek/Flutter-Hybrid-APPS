import 'package:climatempo_app/app/shared/database/_db/moor_database.dart';
import 'package:climatempo_app/app/shared/helper/city/city_helper.dart';
import 'package:climatempo_app/app/shared/helper/generic_result_helper.dart';
import 'package:climatempo_app/app/shared/helper/weather/weather_helper.dart';
import 'package:climatempo_app/app/shared/helper/weather/weather_moment_helper.dart';
import 'package:climatempo_app/app/shared/service/weather_service.dart';
import 'package:climatempo_app/app/shared/util/connectivity_network.dart';
import 'package:climatempo_app/app/shared/util/latlng_helper.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class WeatherRepository {
  WeatherService _service;
  MoorDatabase _db;

  WeatherRepository(MoorDatabase db) {
    _service = WeatherService();

    _db = db;
  }

  Future<GenericResultHelper> getWeatherLocal(CityHelper city) async {
    var cityWeather = await _db.cityWeather(city.id);

    if (cityWeather != null) {
      WeatherHelper weatherHelper = await getCityWeather(cityWeather.city);

      return GenericResultHelper(
        success: true,
        message: "Tempo clima buscado do db local!",
        data: weatherHelper,
      );
    } else {
      return getWeather(city);
    }
  }

  Future<GenericResultHelper> getWeather(CityHelper city) async {
    if (await ConnectivityNetwork.isConnected()) {
      var responseW = await _service.weather(city.id);

      if (responseW.statusCode == 200) {
        WeatherHelper weather = WeatherHelper.fromJson(responseW.data);

        var responseWM = await _service.weatherMoment(city.id);
        if (responseWM.statusCode == 200) {
          weather.moment = WeatherMoment.fromJson(responseWM.data["data"]);
        }

        await insertWeather(weather);

        return GenericResultHelper(
          success: true,
          message: "Tempo clima buscado com sucesso!",
          data: weather,
        );
      } else {
        final Map<String, dynamic> decodedMessage = json.decode(responseW.toString());

        return GenericResultHelper(
          success: false,
          message: "Ocorreu um erro ao buscar o clima. ${decodedMessage['detail']}",
        );
      }
    } else {
      return GenericResultHelper(
        success: false,
        message: "Sem conexão com a internet. Verifique!",
      );
    }
  }

  Future<WeatherHelper> getCityWeather(CityModel cityModel) async {
    WeatherMomentModel weatherMomentModel =
        await _db.weatherMomentLocalDAO.getWeatherMomentModel(cityModel.id, DateTime.now());

    List<WeatherModel> weatherModel = await _db.weatherLocalDAO.getWeatherByCity(cityModel.id);

    List<HumidityModel> humidityModel = await _db.humidityLocalDAO.getAll();

    List<DawnHumidityModel> dawnHumidityModel = await _db.dawnHumidityLocalDAO.getAll();
    List<MorningHumidityModel> morningHumidityModel = await _db.morningHumidityLocalDAO.getAll();
    List<AfternoonHumidityModel> afternoonHumidityModel = await _db.afternoonHumidityLocalDAO.getAll();
    List<NightHumidityModel> nightHumidityModel = await _db.nightHumidityLocalDAO.getAll();

    List<RainModel> rainModel = await _db.rainLocalDAO.getAll();

    List<WindModel> windModel = await _db.windLocalDAO.getAll();
    List<DawnWindModel> dawnWindModel = await _db.dawnWindLocalDAO.getAll();
    List<MorningWindModel> morningWindModel = await _db.morningWindLocalDAO.getAll();
    List<AfternoonWindModel> afternoonWindModel = await _db.afternoonWindLocalDAO.getAll();
    List<NightWindModel> nightWindModel = await _db.nightWindLocalDAO.getAll();

    List<UvModel> uvModel = await _db.uvLocalDAO.getAll();

    List<ThermalSensationModel> thermalSensationModel = await _db.thermalSensationLocalDAO.getAll();

    List<TextIconModel> textIconModel = await _db.textIconLocalDAO.getAll();
    List<IconModel> iconModel = await _db.iconLocalDAO.getAll();
    List<TextModel> textModel = await _db.textLocalDAO.getAll();
    List<PhraseModel> phraseModel = await _db.phraseLocalDAO.getAll();

    List<TemperatureModel> temperatureModel = await _db.temperatureLocalDAO.getAll();

    List<DawnTemperatureModel> dawnTemperatureModel = await _db.dawnTemperatureLocalDAO.getAll();
    List<MorningTemperatureModel> morningTemperatureModel = await _db.morningTemperatureLocalDAO.getAll();
    List<AfternoonTemperatureModel> afternoonTemperatureModel = await _db.afternoonTemperatureLocalDAO.getAll();
    List<NightTemperatureModel> nightTemperatureModel = await _db.nightTemperatureLocalDAO.getAll();

    List<CloudCoverageModel> cloudCoverageModel = await _db.cloudCoverageLocalDAO.getAll();

    List<DawnCloudCoverageModel> dawnCloudCoverageModel = await _db.dawnCloudCoverageLocalDAO.getAll();
    List<MorningCloudCoverageModel> morningCloudCoverageModel = await _db.morningCloudCoverageLocalDAO.getAll();
    List<AfternoonCloudCoverageModel> afternoonCloudCoverageModel = await _db.afternoonCloudCoverageLocalDAO.getAll();
    List<NightCloudCoverageModel> nightCloudCoverageModel = await _db.nightCloudCoverageLocalDAO.getAll();

    List<SunModel> sunModel = await _db.sunLocalDAO.getAll();

    return WeatherHelper(
      id: cityModel.id,
      name: cityModel.name,
      state: cityModel.state,
      country: cityModel.country,
      moment: WeatherMoment(
        temperature: weatherMomentModel.temperature,
        windDirection: weatherMomentModel.wind_direction,
        windVelocity: weatherMomentModel.wind_velocity,
        humidity: weatherMomentModel.humidity,
        condition: weatherMomentModel.condition,
        pressure: weatherMomentModel.pressure,
        icon: weatherMomentModel.icon,
        sensation: weatherMomentModel.sensation,
        date: weatherMomentModel.date,
      ),
      meteogram: "",
      data: weatherModel
          .map(
            (weather) => Datum(
              date: weather.date,
              dateBr: DateFormat("dd/MM/yyyy").format(weather.date),
              sun: sunModel
                  .where((sun) => sun.id_weather == weather.id)
                  .map((sun) => Sun(
                        sunrise: sun.sunrise,
                        sunset: sun.sunset,
                      ))
                  .first,
              cloudCoverage: cloudCoverageModel
                  .where((cloudCoverage) => cloudCoverage.id_weather == weather.id)
                  .map(
                    (cloudCoverage) => CloudCoverage(
                      low: cloudCoverage.low,
                      mid: cloudCoverage.mid,
                      high: cloudCoverage.high,
                      dawn: dawnCloudCoverageModel
                          .where((dawn) => dawn.id_cloud_coverage == cloudCoverage.id)
                          .map(
                            (dawn) => DawnCloudCoverage(
                              low: dawn.low,
                              mid: dawn.mid,
                              high: dawn.high,
                            ),
                          )
                          .first,
                      morning: morningCloudCoverageModel
                          .where((morning) => morning.id_cloud_coverage == cloudCoverage.id)
                          .map(
                            (morning) => MorningCloudCoverage(
                              low: morning.low,
                              mid: morning.mid,
                              high: morning.high,
                            ),
                          )
                          .first,
                      afternoon: afternoonCloudCoverageModel
                          .where((afternoon) => afternoon.id_cloud_coverage == cloudCoverage.id)
                          .map(
                            (afternoon) => AfternoonCloudCoverage(
                              low: afternoon.low,
                              mid: afternoon.mid,
                              high: afternoon.high,
                            ),
                          )
                          .first,
                      night: nightCloudCoverageModel
                          .where((night) => night.id_cloud_coverage == cloudCoverage.id)
                          .map(
                            (night) => NightCloudCoverage(
                              low: night.low,
                              mid: night.mid,
                              high: night.high,
                            ),
                          )
                          .first,
                    ),
                  )
                  .first,
              textIcon: textIconModel
                  .where((textIcon) => textIcon.id_weather == weather.id)
                  .map(
                    (textIcon) => TextIcon(
                      icon: iconModel
                          .where((icon) => icon.id_text_icon == textIcon.id)
                          .map(
                            (icon) => Icon(
                              dawn: icon.dawn,
                              morning: icon.morning,
                              afternoon: icon.afternoon,
                              night: icon.night,
                              day: icon.day,
                            ),
                          )
                          .first,
                      text: textModel
                          .where((text) => text.id_text_icon == textIcon.id)
                          .map(
                            (text) => Text(
                              pt: text.pt,
                              en: text.en,
                              es: text.es,
                              phrase: phraseModel
                                  .where((phrase) => phrase.id_text == text.id)
                                  .map(
                                    (phrase) => Phrase(
                                      reduced: phrase.reduced,
                                      morning: phrase.morning,
                                      afternoon: phrase.afternoon,
                                      night: phrase.night,
                                      dawn: phrase.dawn,
                                    ),
                                  )
                                  .first,
                            ),
                          )
                          .first,
                    ),
                  )
                  .first,
              thermalSensation: thermalSensationModel
                  .where((thermalSensation) => thermalSensation.id_weather == weather.id)
                  .map(
                    (thermalSensation) => ThermalSensation(
                      max: thermalSensation.max,
                      min: thermalSensation.min,
                    ),
                  )
                  .first,
              uv: uvModel
                  .where((uv) => uv.id_weather == weather.id)
                  .map(
                    (uv) => Uv(
                      max: uv.max,
                    ),
                  )
                  .first,
              wind: windModel
                  .where((wind) => wind.id_weather == weather.id)
                  .map(
                    (wind) => Wind(
                      velocityMin: wind.velocity_min,
                      velocityMax: wind.velocity_max,
                      velocityAvg: wind.velocity_avg,
                      gustMax: wind.gust_max,
                      directionDegrees: wind.direction_degrees,
                      direction: wind.direction,
                      dawn: dawnWindModel
                          .where((dawn) => dawn.id_wind == wind.id)
                          .map(
                            (dawn) => DawnWind(
                              direction: dawn.direction,
                              directionDegrees: dawn.direction_degrees,
                              gustMax: dawn.gust_max,
                              velocityAvg: dawn.velocity_avg,
                              velocityMax: dawn.velocity_max,
                            ),
                          )
                          .first,
                      morning: morningWindModel
                          .where((morning) => morning.id_wind == wind.id)
                          .map(
                            (morning) => MorningWind(
                              direction: morning.direction,
                              directionDegrees: morning.direction_degrees,
                              gustMax: morning.gust_max,
                              velocityAvg: morning.velocity_avg,
                              velocityMax: morning.velocity_max,
                            ),
                          )
                          .first,
                      afternoon: afternoonWindModel
                          .where((afternoon) => afternoon.id_wind == wind.id)
                          .map(
                            (afternoon) => AfternoonWind(
                              direction: afternoon.direction,
                              directionDegrees: afternoon.direction_degrees,
                              gustMax: afternoon.gust_max,
                              velocityAvg: afternoon.velocity_avg,
                              velocityMax: afternoon.velocity_max,
                            ),
                          )
                          .first,
                      night: nightWindModel
                          .where((night) => night.id_wind == wind.id)
                          .map(
                            (night) => NightWind(
                              direction: night.direction,
                              directionDegrees: night.direction_degrees,
                              gustMax: night.gust_max,
                              velocityAvg: night.velocity_avg,
                              velocityMax: night.velocity_max,
                            ),
                          )
                          .first,
                    ),
                  )
                  .first,
              rain: rainModel
                  .where((rain) => rain.id_weather == weather.id)
                  .map(
                    (rain) => Rain(
                      precipitation: rain.precipitation,
                      probability: rain.probability,
                    ),
                  )
                  .first,
              temperature: temperatureModel
                  .where((temperature) => temperature.id_weather == weather.id)
                  .map(
                    (temperature) => Temperature(
                      min: temperature.min,
                      max: temperature.max,
                      dawn: dawnTemperatureModel
                          .where((dawn) => dawn.id_temperature == temperature.id)
                          .map(
                            (dawn) => DawnTemperature(
                              min: dawn.min,
                              max: dawn.max,
                            ),
                          )
                          .first,
                      morning: morningTemperatureModel
                          .where((morning) => morning.id_temperature == temperature.id)
                          .map(
                            (morning) => MorningTemperature(
                              min: morning.min,
                              max: morning.max,
                            ),
                          )
                          .first,
                      afternoon: afternoonTemperatureModel
                          .where((afternoon) => afternoon.id_temperature == temperature.id)
                          .map(
                            (afternoon) => AfternoonTemperature(
                              min: afternoon.min,
                              max: afternoon.max,
                            ),
                          )
                          .first,
                      night: nightTemperatureModel
                          .where((night) => night.id_temperature == temperature.id)
                          .map(
                            (night) => NightTemperature(
                              min: night.min,
                              max: night.max,
                            ),
                          )
                          .first,
                    ),
                  )
                  .first,
              humidity: humidityModel
                  .where((humidity) => humidity.id_weather == weather.id)
                  .map(
                    (humidity) => Humidity(
                      min: humidity.min,
                      max: humidity.max,
                      dawn: dawnHumidityModel
                          .where((dawn) => dawn.id_humidity == humidity.id)
                          .map(
                            (dawn) => DawnHumidity(
                              min: dawn.min,
                              max: dawn.max,
                            ),
                          )
                          .first,
                      morning: morningHumidityModel
                          .where((morning) => morning.id_humidity == humidity.id)
                          .map(
                            (morning) => MorningHumidity(
                              min: morning.min,
                              max: morning.max,
                            ),
                          )
                          .first,
                      afternoon: afternoonHumidityModel
                          .where((afternoon) => afternoon.id_humidity == humidity.id)
                          .map(
                            (afternoon) => AfternoonHumidity(
                              min: afternoon.min,
                              max: afternoon.max,
                            ),
                          )
                          .first,
                      night: nightHumidityModel
                          .where((night) => night.id_humidity == humidity.id)
                          .map(
                            (night) => NightHumidity(
                              min: night.min,
                              max: night.max,
                            ),
                          )
                          .first,
                    ),
                  )
                  .first,
            ),
          )
          .toList(),
    );
  }

  Future<void> insertWeather(WeatherHelper helper) async {
    var cidade = await _db.cityLocalDAO.getCityById(helper.id);

    if (cidade != null) {
      await deleteWather(cidade);
    }

    //ADICIONA A CIDADE
    CityModel city = CityModel(
      id: helper.id,
      name: helper.name,
      state: helper.state,
      country: helper.country,
      data_insert: DateTime.now(),
    );

    await _db.cityLocalDAO.insertCity(city);

    WeatherMomentModel weatherMoment = WeatherMomentModel(
      id: null,
      id_city: helper.id,
      temperature: helper.moment.temperature,
      wind_velocity: helper.moment.windVelocity,
      humidity: helper.moment.humidity,
      pressure: helper.moment.pressure,
      sensation: helper.moment.sensation,
      wind_direction: helper.moment.windDirection,
      condition: helper.moment.condition,
      icon: helper.moment.icon,
      date_insert: DateTime.now(),
      date: helper.moment.date,
    );

    await _db.weatherMomentLocalDAO.insertWeatherMoment(weatherMoment);

    //LOOP PARA REALIZAR INSERTS
    helper.data.forEach((data) async {
      //ADICIONA O CLIMA DA CIDADE
      WeatherModel weather = WeatherModel(
        id: null,
        id_city: helper.id,
        date: data.date,
      );

      int weatherId = await _db.weatherLocalDAO.insertWeather(weather);

      //ADICIONA DE HUMIDADE DO CLIMA TEMPO
      HumidityModel humidity = HumidityModel(
        id: null,
        id_weather: weatherId,
        min: data.humidity.min,
        max: data.humidity.max,
      );

      int humidityId = await _db.humidityLocalDAO.insertHumidity(humidity);

      //ADICIONA DE HUMIDADE (MADRUGADA) DO CLIMA TEMPO
      DawnHumidityModel dawnHumidity = DawnHumidityModel(
        id: null,
        id_humidity: humidityId,
        min: data.humidity.dawn.min,
        max: data.humidity.dawn.max,
      );
      await _db.dawnHumidityLocalDAO.insertDawnHumidity(dawnHumidity);

      //ADICIONA DE HUMIDADE (MANHA) DO CLIMA TEMPO
      MorningHumidityModel morningHumidity = MorningHumidityModel(
        id: null,
        id_humidity: humidityId,
        min: data.humidity.dawn.min,
        max: data.humidity.dawn.max,
      );
      await _db.morningHumidityLocalDAO.insertMorningHumidity(morningHumidity);

      //ADICIONA DE HUMIDADE (TARDE) DO CLIMA TEMPO
      AfternoonHumidityModel afternoonHumidity = AfternoonHumidityModel(
        id: null,
        id_humidity: humidityId,
        min: data.humidity.dawn.min,
        max: data.humidity.dawn.max,
      );
      await _db.afternoonHumidityLocalDAO.insertAfternoonHumidity(afternoonHumidity);

      //ADICIONA DE HUMIDADE (NOITE) DO CLIMA TEMPO
      NightHumidityModel nightHumidity = NightHumidityModel(
        id: null,
        id_humidity: humidityId,
        min: data.humidity.dawn.min,
        max: data.humidity.dawn.max,
      );
      await _db.nightHumidityLocalDAO.insertNightHumidity(nightHumidity);

      //ADICIONA DE CHUVA DO CLIMA TEMPO
      RainModel rain = RainModel(
        id: null,
        id_weather: weatherId,
        probability: data.rain.probability,
        precipitation: data.rain.precipitation,
      );
      await _db.rainLocalDAO.insertRain(rain);

      //ADICIONAR DE VENTO DO CLIMA TEMPO
      WindModel wind = WindModel(
        id: null,
        id_weather: weatherId,
        velocity_min: data.wind.velocityMin,
        velocity_max: data.wind.velocityMax,
        velocity_avg: data.wind.velocityAvg,
        gust_max: data.wind.gustMax,
        direction_degrees: data.wind.directionDegrees,
        direction: data.wind.direction,
      );
      int windId = await _db.windLocalDAO.insertWind(wind);

      //ADICIONA DE VENTO (MADRUGADA) DO CLIMA TEMPO
      DawnWindModel dawnWind = DawnWindModel(
        id: null,
        id_wind: windId,
        direction_degrees: data.wind.dawn.directionDegrees,
        gust_max: data.wind.dawn.gustMax,
        velocity_max: data.wind.dawn.velocityMax,
        velocity_avg: data.wind.dawn.velocityAvg,
        direction: data.wind.dawn.direction,
      );
      await _db.dawnWindLocalDAO.insertDawnWind(dawnWind);

      //ADICIONA DE VENTO (MANHA) DO CLIMA TEMPO
      MorningWindModel morningWind = MorningWindModel(
        id: null,
        id_wind: windId,
        direction_degrees: data.wind.morning.directionDegrees,
        gust_max: data.wind.morning.gustMax,
        velocity_max: data.wind.morning.velocityMax,
        velocity_avg: data.wind.morning.velocityAvg,
        direction: data.wind.morning.direction,
      );
      await _db.morningWindLocalDAO.insertMorningWind(morningWind);

      //ADICIONA DE VENTO (TARDE) DO CLIMA TEMPO
      AfternoonWindModel afternoonWind = AfternoonWindModel(
        id: null,
        id_wind: windId,
        direction_degrees: data.wind.afternoon.directionDegrees,
        gust_max: data.wind.afternoon.gustMax,
        velocity_max: data.wind.afternoon.velocityMax,
        velocity_avg: data.wind.afternoon.velocityAvg,
        direction: data.wind.afternoon.direction,
      );
      await _db.afternoonWindLocalDAO.insertAfternoonWind(afternoonWind);

      //ADICIONA DE VENTO (NOITE) DO CLIMA TEMPO
      NightWindModel nightWind = NightWindModel(
        id: null,
        id_wind: windId,
        direction_degrees: data.wind.night.directionDegrees,
        gust_max: data.wind.night.gustMax,
        velocity_max: data.wind.night.velocityMax,
        velocity_avg: data.wind.night.velocityAvg,
        direction: data.wind.night.direction,
      );
      await _db.nightWindLocalDAO.insertNightWind(nightWind);

      //ADICIONA DE INDICE ULTRAVIOLETA DO CLIMA TEMPO
      UvModel uv = UvModel(
        id: null,
        id_weather: weatherId,
        max: data.uv.max,
      );
      await _db.uvLocalDAO.insertUv(uv);

      //ADICIONA DE SENSACAO TÉRMICA DO CLIMA TEMPO
      ThermalSensationModel thermalSensation = ThermalSensationModel(
        id: null,
        id_weather: weatherId,
        min: data.thermalSensation.min,
        max: data.thermalSensation.max,
      );
      await _db.thermalSensationLocalDAO.insertThermalSensation(thermalSensation);

      //ADICIONA DE TEXTO E ICONE DO CLIMA TEMPO
      TextIconModel textIcon = TextIconModel(
        id: null,
        id_weather: weatherId,
      );

      int textIconId = await _db.textIconLocalDAO.insertTextIcon(textIcon);

      //ADICIONA DE ICONE DO TEXTO E ICONE
      IconModel icon = IconModel(
        id: null,
        id_text_icon: textIconId,
        dawn: data.textIcon.icon.dawn,
        morning: data.textIcon.icon.morning,
        afternoon: data.textIcon.icon.afternoon,
        night: data.textIcon.icon.night,
        day: data.textIcon.icon.day,
      );
      await _db.iconLocalDAO.insertIcon(icon);

      //ADICIONA DE TEXTO DO TEXTO E ICONE
      TextModel text = TextModel(
        id: null,
        id_text_icon: textIconId,
        pt: data.textIcon.text.pt,
        en: data.textIcon.text.en,
        es: data.textIcon.text.es,
      );

      int textId = await _db.textLocalDAO.insertText(text);

      //ADICIONA DE FRASES DO TEXTO
      PhraseModel phrase = PhraseModel(
        id: null,
        id_text: textId,
        reduced: data.textIcon.text.phrase.reduced,
        morning: data.textIcon.text.phrase.morning,
        afternoon: data.textIcon.text.phrase.afternoon,
        night: data.textIcon.text.phrase.night,
        dawn: data.textIcon.text.phrase.dawn,
      );
      await _db.phraseLocalDAO.insertPharase(phrase);

      //ADICIONA DE TEMPERATURA DO CLIMA TEMPO
      TemperatureModel temperature = TemperatureModel(
        id: null,
        id_weather: weatherId,
        min: data.temperature.min,
        max: data.temperature.max,
      );

      int temperatureId = await _db.temperatureLocalDAO.insertTemperature(temperature);

      //ADICIONA DE TEMPERATURA (MADRUGADA) DO CLIMA TEMPO
      DawnTemperatureModel dawnTemperature = DawnTemperatureModel(
        id: null,
        id_temperature: temperatureId,
        min: data.temperature.dawn.min,
        max: data.temperature.dawn.max,
      );
      await _db.dawnTemperatureLocalDAO.insertDawnTemperature(dawnTemperature);

      //ADICIONA DE TEMPERATURA (MANHA) DO CLIMA TEMPO
      MorningTemperatureModel morningTemperature = MorningTemperatureModel(
        id: null,
        id_temperature: temperatureId,
        min: data.temperature.dawn.min,
        max: data.temperature.dawn.max,
      );
      await _db.morningTemperatureLocalDAO.insertMorningTemperature(morningTemperature);

      //ADICIONA DE TEMPERATURA (TARDE) DO CLIMA TEMPO
      AfternoonTemperatureModel afternoonTemperature = AfternoonTemperatureModel(
        id: null,
        id_temperature: temperatureId,
        min: data.temperature.dawn.min,
        max: data.temperature.dawn.max,
      );
      await _db.afternoonTemperatureLocalDAO.insertAfternoonTemperature(afternoonTemperature);

      //ADICIONA DE TEMPERATURA (NOITE) DO CLIMA TEMPO
      NightTemperatureModel nightTemperature = NightTemperatureModel(
        id: null,
        id_temperature: temperatureId,
        min: data.temperature.dawn.min,
        max: data.temperature.dawn.max,
      );
      await _db.nightTemperatureLocalDAO.insertNightTemperature(nightTemperature);

      //ADICIONA DE COBERTURA DE NUVENS DO CLIMA TEMPO
      CloudCoverageModel cloudCoverage = CloudCoverageModel(
        id: null,
        id_weather: weatherId,
        low: data.cloudCoverage.low,
        mid: data.cloudCoverage.mid,
        high: data.cloudCoverage.high,
      );

      int cloudCoverageId = await _db.cloudCoverageLocalDAO.insertCloudCoverage(cloudCoverage);

      //ADICIONA DE COBERTURA DE NUVENS (MADRUGADA) DO CLIMA TEMPO
      DawnCloudCoverageModel dawnCloudCoverage = DawnCloudCoverageModel(
        id: null,
        id_cloud_coverage: cloudCoverageId,
        low: data.cloudCoverage.dawn.low,
        mid: data.cloudCoverage.dawn.mid,
        high: data.cloudCoverage.dawn.high,
      );
      await _db.dawnCloudCoverageLocalDAO.insertDawnCloudCoverage(dawnCloudCoverage);

      //ADICIONA DE COBERTURA DE NUVENS (MANHA) DO CLIMA TEMPO
      MorningCloudCoverageModel morningCloudCoverage = MorningCloudCoverageModel(
        id: null,
        id_cloud_coverage: cloudCoverageId,
        low: data.cloudCoverage.morning.low,
        mid: data.cloudCoverage.morning.mid,
        high: data.cloudCoverage.morning.high,
      );
      await _db.morningCloudCoverageLocalDAO.insertMorningCloudCoverage(morningCloudCoverage);

      //ADICIONA DE COBERTURA DE NUVENS (TARDE) DO CLIMA TEMPO
      AfternoonCloudCoverageModel afternoonCloudCoverage = AfternoonCloudCoverageModel(
        id: null,
        id_cloud_coverage: cloudCoverageId,
        low: data.cloudCoverage.afternoon.low,
        mid: data.cloudCoverage.afternoon.mid,
        high: data.cloudCoverage.afternoon.high,
      );
      await _db.afternoonCloudCoverageLocalDAO.insertAfternoonCloudCoverage(afternoonCloudCoverage);

      //ADICIONA DE COBERTURA DE NUVENS (NOITE) DO CLIMA TEMPO
      NightCloudCoverageModel nightCloudCoverage = NightCloudCoverageModel(
        id: null,
        id_cloud_coverage: cloudCoverageId,
        low: data.cloudCoverage.night.low,
        mid: data.cloudCoverage.night.mid,
        high: data.cloudCoverage.night.high,
      );
      await _db.nightCloudCoverageLocalDAO.insertNightCloudCoverage(nightCloudCoverage);

      //ADICIONA DE SOL DO CLIMA TEMPO
      SunModel sun = SunModel(
        id: null,
        id_weather: weatherId,
        sunrise: data.sun.sunrise,
        sunset: data.sun.sunset,
      );

      await _db.sunLocalDAO.insertSun(sun);
    });
  }

  Future<void> deleteWather(CityModel cidade) async {
    //BUSCA OS CLIMA DA CIDADE JA CADASTRADOS
    List listWeather = await _db.weatherLocalDAO.getWeatherByCity(cidade.id);

    //BUSCA E DELETA CLIMA NO MOMENTO
    var weatherMomentModel = await _db.weatherMomentLocalDAO.getWeatherMomentModel(cidade.id, DateTime.now());
    await _db.weatherMomentLocalDAO.deleteWeatherMoment(weatherMomentModel);

    //LOOP PARA REALIZAR DELETES
    for (var weather in listWeather) {
      var humidity = await _db.humidityLocalDAO.getHumidityByWeather(weather.id);

      //DELETE DE HUMIDADE (MADRUGADA) DO CLIMA TEMPO
      await _db.dawnHumidityLocalDAO.deleteDawnHumidityByHumidity(humidity.id);

      //DELETE DE HUMIDADE (MANHA) DO CLIMA TEMPO
      await _db.morningHumidityLocalDAO.deleteMorningHumidityByHumidity(humidity.id);

      //DELETE DE HUMIDADE (TARDE) DO CLIMA TEMPO
      await _db.afternoonHumidityLocalDAO.deleteAfternoonHumidityByHumidity(humidity.id);

      //DELETE DE HUMIDADE (NOITE) DO CLIMA TEMPO
      await _db.nightHumidityLocalDAO.deleteNightHumidityByHumidity(humidity.id);

      //DELETE DE CHUVA DO CLIMA TEMPO
      var rain = await _db.rainLocalDAO.getRainByWeather(weather.id);
      await _db.rainLocalDAO.deleteRain(rain);

      var wind = await _db.windLocalDAO.getWindByWeather(weather.id);

      //DELETE DE VENDO (MADRUGADA) DO CLIMA TEMPO
      await _db.dawnWindLocalDAO.deleteDawnWindByWind(wind.id);

      //DELETE DE VENDO (MANHA) DO CLIMA TEMPO
      await _db.morningWindLocalDAO.deleteMorningWindByWind(wind.id);

      //DELETE DE VENDO (TARDE) DO CLIMA TEMPO
      await _db.afternoonWindLocalDAO.deleteAfternoonWindByWind(wind.id);

      //DELETE DE VENDO (NOITE) DO CLIMA TEMPO
      await _db.nightWindLocalDAO.deleteNightWindByWind(wind.id);

      //DELETE DE INDICE ULTRAVIOLETA DO CLIMA TEMPO
      var uv = await _db.uvLocalDAO.getUvByWeather(weather.id);
      await _db.uvLocalDAO.deleteUv(uv);

      //DELETE DE SENSACAO TERMICA DO CLIMA TEMPO
      var thermalSensation = await _db.thermalSensationLocalDAO.getThermalSensationByWeather(weather.id);
      await _db.thermalSensationLocalDAO.deleteThermalSensation(thermalSensation);

      var textIcon = await _db.textIconLocalDAO.getTextIconByWeather(weather.id);

      //DELETE DE ICONE DO TEXTO E ICONE
      await _db.iconLocalDAO.deleteIconByTextIcon(textIcon.id);

      var text = await _db.textLocalDAO.getTextByTextIcon(textIcon.id);

      //DELETE DE FRASE DO TEXTO
      await _db.phraseLocalDAO.deletePhraseByText(text.id);

      var temperature = await _db.temperatureLocalDAO.getTemperatureByWeather(weather.id);

      //DELETE DE TEMPERATURA (MADRUGADA) DO CLIMA TEMPO
      await _db.dawnTemperatureLocalDAO.deleteDawnTemperatureByTemperature(temperature.id);

      //DELETE DE TEMPERATURA (MANHA) DO CLIMA TEMPO
      await _db.morningTemperatureLocalDAO.deleteMorningTemperatureByTemperature(temperature.id);

      //DELETE DE TEMPERATURA (TARDE) DO CLIMA TEMPO
      await _db.afternoonTemperatureLocalDAO.deleteAfternoonTemperatureByTemperature(temperature.id);

      //DELETE DE TEMPERATURA (NOITE) DO CLIMA TEMPO
      await _db.nightTemperatureLocalDAO.deleteNightTemperatureByTemperature(temperature.id);

      var cloudCoverage = await _db.cloudCoverageLocalDAO.getCloudCoverageByWeather(weather.id);

      //DELETE DE COBERTURA DE NUVENS (MADRUGADA) DO CLIMA TEMPO
      await _db.dawnCloudCoverageLocalDAO.deleteDawnCloudCoverageByCloudCoverage(cloudCoverage.id);

      //DELETE DE COBERTURA DE NUVENS (MANHA) DO CLIMA TEMPO
      await _db.morningCloudCoverageLocalDAO.deleteMorningCloudCoverageByCloudCoverage(cloudCoverage.id);

      //DELETE DE COBERTURA DE NUVENS (TARDE) DO CLIMA TEMPO
      await _db.afternoonCloudCoverageLocalDAO.deleteAfternoonCloudCoverageByCloudCoverage(cloudCoverage.id);

      //DELETE DE COBERTURA DE NUVENS (NOITE) DO CLIMA TEMPO
      await _db.nightCloudCoverageLocalDAO.deleteNightCloudCoverageByCloudCoverage(cloudCoverage.id);

      //DELETE DE SOL DO CLIMA TEMPO
      var sun = await _db.sunLocalDAO.getSunByWeather(weather.id);
      await _db.sunLocalDAO.deleteSun(sun);

      //DELETE DE TEXTO DO TEXTO E ICONE
      await _db.textLocalDAO.deleteText(text);

      //DELETE DE HUMIDADE DO CLIMA TEMPO
      await _db.humidityLocalDAO.deleteHumidity(humidity);

      //DELETE DE VENTO DO CLIMA TEMPO
      await _db.windLocalDAO.deleteWind(wind);

      //DELETE DE TEXTO E ICONE DO CLIMA TEMPO
      await _db.textIconLocalDAO.deleteTextIcon(textIcon);

      //DELETE DE TEMPERATURA DO CLIMA TEMPO
      await _db.temperatureLocalDAO.deleteTemperature(temperature);

      //DELETE DE COBERTURA DE NUVENS DO CLIMA TEMPO
      await _db.cloudCoverageLocalDAO.deleteCloudCoverage(cloudCoverage);

      //DELETE DO CLIMA TEMPO
      await _db.weatherLocalDAO.deleteWeather(weather);
    }

    //DELETA A CIDADE
    await _db.cityLocalDAO.deleteCity(cidade);
  }
}
