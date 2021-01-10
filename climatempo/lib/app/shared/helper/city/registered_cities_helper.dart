import 'dart:convert';

RegisteredCitiesHelper registeredCitiesHelperFromJson(String str) => RegisteredCitiesHelper.fromJson(json.decode(str));

String registeredCitiesHelperToJson(RegisteredCitiesHelper data) => json.encode(data.toJson());

class RegisteredCitiesHelper {
  RegisteredCitiesHelper({
    this.maxAllowed,
    this.locales,
  });

  int maxAllowed;
  List<int> locales;

  factory RegisteredCitiesHelper.fromJson(Map<String, dynamic> json) => RegisteredCitiesHelper(
        maxAllowed: json["max_allowed"],
        locales: List<int>.from(json["locales"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "max_allowed": maxAllowed,
        "locales": List<dynamic>.from(locales.map((x) => x)),
      };
}
