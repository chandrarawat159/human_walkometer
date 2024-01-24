import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:humanwalkometer_app/screens/location_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Tracker',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _transportController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  Set<Marker> _markers = Set<Marker>();

  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polygonLatlings = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;
  String _distance = "0 km";
  //String _duration = "0 min";
  // var _transport = [
  //   "cycle",
  //   "walk",
  //   "car",
  // ];
  // var _currentItemSelected = "walk";

  late LatLng _center;
  late Position currentLocation;
  late double latitude;
  late double longitude;
  late String distance;
  late Position finalLocation;
  late Position endlocation;

  late String duration;

  @override
  void initState() {
    super.initState();
    // _setMarker(LatLng(27.6695, 85.3408));
    _setCurrentLocation();
  }

  Future<void> _setCurrentLocation() async {
    currentLocation = await Geolocator.getCurrentPosition();
  }
  

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('origin'),
          position: point,
        ),
      );
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;
    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatlings,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      ),
    );
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 5,
        color: Colors.blueAccent,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
              
            )
            .toList(),
      ),
    );
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.688910, 85.360321),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('हुँमन वलकोमिटर एप्स '),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      controller: _destinationController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            top: 20), // add padding to adjust text
                        isDense: true,
                        hintText: "तपाईंको गन्तब्य ",
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              top: 15), // add padding to adjust icon
                          child: Icon(Icons.place_outlined),
                        ),
                      ),
                    ),

                    // TextFormField(
                    //   controller: _destinationController,
                    //   textCapitalization: TextCapitalization.words,
                    //   decoration: InputDecoration(hintText: 'Destination'),
                    //   onChanged: (value) {
                    //     print(value);

                    //   },
                    // ),
                    // TextField(
                      
                    //   decoration: InputDecoration(
                        
                    //     contentPadding: EdgeInsets.only(
                    //         top: 20), // add padding to adjust text
                    //     isDense: true,
                    //     hintText: "Mode of Travel",
                        
                        

                    //     prefixIcon: Padding(
                    //       padding: EdgeInsets.only(
                    //           top: 15), // add padding to adjust icon
                    //       child: Icon(Icons.emoji_transportation),
                          
                          
                    //     ),
                        
                    //   ),
                      
                    // ),
                    // DropdownButton<String>(
                      
                      
                    //   icon: Icon(
                    //     Icons.emoji_transportation,
                    //     size: 20,
                    //   ),
                    //   items: _transport.map((String dropDownStringItem){
                    //     return DropdownMenuItem<String>(
                    //       value: dropDownStringItem,
                    //       child: Text(dropDownStringItem),
                    //       );
                    //   }).toList(),
                    //   onChanged: ( newValueSelected) {
                    //     setState(() {
                    //       this._currentItemSelected = newValueSelected!;
                    //     });
                    //   },
                    //   value: _currentItemSelected,
                    // ),


                  ],
                ),
              ),
              Container(
                child: SizedBox(
                  child: Expanded(
                    child: Text('$_distance'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                //child: Expanded(child: Text('$_duration')),
              ),
              IconButton(
                onPressed: () async {
                  var directions = await LocationService().getDirections(
                      currentLocation, _destinationController.text);
                  print("distance " + directions['distance']['text']);
                  _setDistance(directions['distance']['text']);

                  Divider();
                  //print("duration " + directions['duration']['text']);

                  //_setDuration(directions['duration']['text']);

                  _goToPlace(
                    directions['start_location']['lat'],
                    directions['start_location']['lng'],
                    directions['bounds_ne'],
                    directions['bounds_sw'],
                  );
                  _setPolyline(directions['polyline_decoded']);

                  double endLat = directions['end_location']['lat'];
                  double endLng = directions['end_location']['lng'];
                  print(endlocation);
                  _setMarker(LatLng(endLat, endLng));
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.hybrid,
              myLocationEnabled: true,
              tiltGesturesEnabled: true,
              indoorViewEnabled: true,
              markers: _markers,
              polygons: _polygons,
              polylines: _polylines,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (point) {

                setState(() {
                  polygonLatlings.add(point);
                  _setPolygon();
                });
              },

              //markers:markers.map((e)=>e).toSet(),
            ),
          ),
          // Expanded(
          //   child:

          //    Text('$_distance'),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: getUserLocation,
        label: Text('तपाईं रहेको ठाउँ .. '),
        icon: Icon(Icons.people_outline),
      ),
    );
  }

  void _setDistance(String distance) {
    setState(() {
      _distance = distance;
    });
  }

  

  Future<void> _goToPlace(
    //Map<String, dynamic> place,
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
    //final double lat = place['geometry']['location']['lat'];
    //final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      (CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 40)))
          );

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          ),
          20),
    );
    _setMarker(LatLng(lat, lng));
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() async {
      latitude = currentLocation.latitude;
      longitude = currentLocation.longitude;
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 20)));
    });
    print('center $_center');
  }
}
