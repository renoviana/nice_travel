import 'package:google_maps_webservice/places.dart';

class Result {
  List<AddressComponents> addressComponents = [];
  String adrAddress;
  String formattedAddress;
  Geometry geometry;
  String icon;
  String id;
  String name;
  List<Photos> photos = [];
  String placeId;
  String reference;
  String scope;
  List<String> types = [];
  String url;
  int utcOffset;
  String vicinity;

  Result(
      {this.addressComponents,
      this.adrAddress,
      this.formattedAddress,
      this.geometry,
      this.icon,
      this.id,
      this.name,
      this.photos,
      this.placeId,
      this.reference,
      this.scope,
      this.types,
      this.url,
      this.utcOffset,
      this.vicinity});

  Result.fromJson(Map<dynamic, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = new List<AddressComponents>();
      json['address_components'].forEach((v) {
        addressComponents.add(new AddressComponents.fromJson(v));
      });
    }
    adrAddress = json['adr_address'];
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    icon = json['icon'];
    id = json['id'];
    name = json['name'];
    if (json['photos'] != null) {
      photos = new List<Photos>();
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    placeId = json['place_id'];
    reference = json['reference'];
    scope = json['scope'];
    types = json['types'].cast<String>();
    url = json['url'];
    utcOffset = json['utc_offset'];
    vicinity = json['vicinity'];
  }

  Result.fromPlaceDetails(PlaceDetails place) {
    place.addressComponents.forEach((f) {
      this.addressComponents.add(AddressComponents(
          longName: f.longName, types: f.types, shortName: f.shortName));
    });
    adrAddress = place.adrAddress;
    formattedAddress = place.formattedAddress;

    icon = place.icon;
    id = place.id;
    name = place.name;
    if (place.photos != null) {
      place.photos.forEach((f) {
        this.photos.add(Photos(
            height: f.height,
            width: f.width,
            photoReference: f.photoReference,
            htmlAttributions: f.htmlAttributions));
      });
    }
    geometry = Geometry(
        location: Location(
            lat: place.geometry.location.lat,
            lng: place.geometry.location.lng));
    placeId = place.placeId;
    reference = place.reference;
    scope = place.scope;
    types = place.types.cast<String>();
    url = place.url;
    utcOffset = place.utcOffset;
    vicinity = place.vicinity;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addressComponents != null) {
      data['address_components'] =
          this.addressComponents.map((v) => v.toJson()).toList();
    }
    data['adr_address'] = this.adrAddress;
    data['formatted_address'] = this.formattedAddress;
    if (this.geometry != null) {
      data['geometry'] = this.geometry.toJson();
    }
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    data['place_id'] = this.placeId;
    data['reference'] = this.reference;
    data['scope'] = this.scope;
    data['types'] = this.types;
    data['url'] = this.url;
    data['utc_offset'] = this.utcOffset;
    data['vicinity'] = this.vicinity;
    return data;
  }
}

class AddressComponents {
  String longName;
  String shortName;
  List<String> types;

  AddressComponents({this.longName, this.shortName, this.types});

  AddressComponents.fromJson(Map<dynamic, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['long_name'] = this.longName;
    data['short_name'] = this.shortName;
    data['types'] = this.types;
    return data;
  }
}

class Geometry {
  Location location;
  Viewport viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<dynamic, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    viewport = json['viewport'] != null
        ? new Viewport.fromJson(json['viewport'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.viewport != null) {
      data['viewport'] = this.viewport.toJson();
    }
    return data;
  }
}

class Location {
  double lat;
  double lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<dynamic, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Viewport {
  Northeast northeast;
  Southwest southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? new Northeast.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? new Southwest.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.northeast != null) {
      data['northeast'] = this.northeast.toJson();
    }
    if (this.southwest != null) {
      data['southwest'] = this.southwest.toJson();
    }
    return data;
  }
}

class Northeast {
  double lat;
  double lng;

  Northeast({this.lat, this.lng});

  Northeast.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Southwest {
  double lat;
  double lng;

  Southwest({this.lat, this.lng});

  Southwest.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Photos {
  int height;
  List<String> htmlAttributions;
  String photoReference;
  int width;

  Photos({this.height, this.htmlAttributions, this.photoReference, this.width});

  Photos.fromJson(Map<dynamic, dynamic> json) {
    height = json['height'];
    htmlAttributions = json['html_attributions'].cast<String>();
    photoReference = json['photo_reference'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['html_attributions'] = this.htmlAttributions;
    data['photo_reference'] = this.photoReference;
    data['width'] = this.width;
    return data;
  }
}
