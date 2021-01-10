import 'dart:convert';

CityHelper cityHelperFromJson(String str) => CityHelper.fromJson(json.decode(str));

String cityHelperToJson(CityHelper data) => json.encode(data.toJson());

class CityHelper {
  CityHelper({
    this.id,
    this.name,
    this.state,
    this.country,
  });

  int id;
  String name;
  String state;
  String country;

  factory CityHelper.fromJson(Map<String, dynamic> json) => CityHelper(
        id: json["id"],
        name: json["name"],
        state: json["state"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state": state,
        "country": country,
      };

  static List<CityHelper> listFromJson(List<dynamic> json) {
    List<CityHelper> cities = List();

    for (final item in json) {
      CityHelper city = CityHelper();

      city.id = item["id"];
      city.name = item["name"];
      city.state = item["state"];
      city.country = item["country"];

      cities.add(city);
    }

    return cities;
  }
}
