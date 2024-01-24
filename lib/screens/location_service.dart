import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String key = 'AIzaSyDraCeE-7hWzlSmYeFrhcp0ohiT7Hltsdk';

  Future<String> getPlaceId(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
    print(url);
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    print(json);
    var placeId = json['candidates'][0]['place_id'] as String;

    print(placeId);
    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    final placeId = await getPlaceId(input);
    print(placeId);
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;

    print(results);

    return results;
  }

  Future<Map<String, dynamic>> getDirections(
     geolocator.Position currentLocation, String destination) async {
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${currentLocation.latitude},${currentLocation.longitude}&destination=$destination&key=$key';
    print("maps.googleapis.com");
    print(url);
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    var results = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'distance': json['routes'][0]['legs'][0]['distance'],
      'duration': json['routes'][0]['legs'][0]['duration'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded': PolylinePoints()
          .decodePolyline(json['routes'][0]['overview_polyline']['points']),
    };
    print(results);
    return results;
  }
}
