import 'dart:convert';

GeoLocationGoogleHelper geoLocationGoogleHelperFromJson(String str) =>
    GeoLocationGoogleHelper.fromJson(json.decode(str));

String geoLocationGoogleHelperToJson(GeoLocationGoogleHelper data) => json.encode(data.toJson());

class GeoLocationGoogleHelper {
  GeoLocationGoogleHelper({
    this.plusCode,
    this.results,
    this.status,
  });

  PlusCode plusCode;
  List<Result> results;
  String status;

  factory GeoLocationGoogleHelper.fromJson(Map<String, dynamic> json) => GeoLocationGoogleHelper(
        plusCode: PlusCode.fromJson(json["plus_code"]),
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "plus_code": plusCode.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "status": status,
      };
}

class PlusCode {
  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  String compoundCode;
  String globalCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
      );

  Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
      };
}

class Result {
  Result({
    this.accessPoints,
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.placeId,
    this.plusCode,
    this.types,
  });

  List<AccessPoint> accessPoints;
  List<AddressComponent> addressComponents;
  String formattedAddress;
  Geometry geometry;
  String placeId;
  PlusCode plusCode;
  List<String> types;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        accessPoints: List<AccessPoint>.from(json["access_points"].map((x) => AccessPoint.fromJson(x))),
        addressComponents:
            List<AddressComponent>.from(json["address_components"].map((x) => AddressComponent.fromJson(x))),
        formattedAddress: json["formatted_address"],
        geometry: Geometry.fromJson(json["geometry"]),
        placeId: json["place_id"],
        plusCode: json["plus_code"] == null ? null : PlusCode.fromJson(json["plus_code"]),
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "access_points": List<dynamic>.from(accessPoints.map((x) => x.toJson())),
        "address_components": List<dynamic>.from(addressComponents.map((x) => x.toJson())),
        "formatted_address": formattedAddress,
        "geometry": geometry.toJson(),
        "place_id": placeId,
        "plus_code": plusCode == null ? null : plusCode.toJson(),
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}

class AccessPoint {
  AccessPoint({
    this.accessPointType,
    this.location,
    this.locationOnSegment,
    this.placeId,
    this.segmentPosition,
    this.unsuitableTravelModes,
  });

  String accessPointType;
  LocationOnSegmentClass location;
  LocationOnSegmentClass locationOnSegment;
  String placeId;
  double segmentPosition;
  List<dynamic> unsuitableTravelModes;

  factory AccessPoint.fromJson(Map<String, dynamic> json) => AccessPoint(
        accessPointType: json["access_point_type"],
        location: LocationOnSegmentClass.fromJson(json["location"]),
        locationOnSegment:
            json["location_on_segment"] == null ? null : LocationOnSegmentClass.fromJson(json["location_on_segment"]),
        placeId: json["place_id"],
        segmentPosition: json["segment_position"] == null ? null : json["segment_position"].toDouble(),
        unsuitableTravelModes: List<dynamic>.from(json["unsuitable_travel_modes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "access_point_type": accessPointType,
        "location": location.toJson(),
        "location_on_segment": locationOnSegment == null ? null : locationOnSegment.toJson(),
        "place_id": placeId,
        "segment_position": segmentPosition == null ? null : segmentPosition,
        "unsuitable_travel_modes": List<dynamic>.from(unsuitableTravelModes.map((x) => x)),
      };
}

class LocationOnSegmentClass {
  LocationOnSegmentClass({
    this.latitude,
    this.longitude,
  });

  double latitude;
  double longitude;

  factory LocationOnSegmentClass.fromJson(Map<String, dynamic> json) => LocationOnSegmentClass(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class AddressComponent {
  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  String longName;
  String shortName;
  List<String> types;

  factory AddressComponent.fromJson(Map<String, dynamic> json) => AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}

class Geometry {
  Geometry({
    this.location,
    this.locationType,
    this.viewport,
    this.bounds,
  });

  NortheastClass location;
  String locationType;
  Viewport viewport;
  Viewport bounds;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: NortheastClass.fromJson(json["location"]),
        locationType: json["location_type"],
        viewport: Viewport.fromJson(json["viewport"]),
        bounds: json["bounds"] == null ? null : Viewport.fromJson(json["bounds"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "location_type": locationType,
        "viewport": viewport.toJson(),
        "bounds": bounds == null ? null : bounds.toJson(),
      };
}

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  NortheastClass northeast;
  NortheastClass southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: NortheastClass.fromJson(json["northeast"]),
        southwest: NortheastClass.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
      };
}

class NortheastClass {
  NortheastClass({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory NortheastClass.fromJson(Map<String, dynamic> json) => NortheastClass(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
