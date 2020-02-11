import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swappin/main.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/blocs/stores_bloc.dart';
import 'package:swappin/src/blocs/stores_bloc_provider.dart';
import 'package:swappin/src/models/store.dart';
import 'package:swappin/src/ui/products.dart';
import 'package:swappin/src/ui/widgets/no-stores.dart';
import 'package:swappin/src/ui/animations/loader.dart';
import 'package:swappin/src/ui/widgets/no-stores.dart';
import 'package:swappin/src/ui/widgets/store-list-item.dart';
import 'package:http/http.dart' as http;

class MapTypes {
  const MapTypes({this.title});

  final String title;
}

const List<MapTypes> types = const <MapTypes>[
  const MapTypes(title: 'Normal'),
  const MapTypes(title: 'Híbrido'),
  const MapTypes(title: 'Satélite'),
  const MapTypes(title: 'Terreno'),
];

BitmapDescriptor sourceIcon;
BitmapDescriptor destinationIcon;

const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
LatLng SOURCE_LOCATION = LatLng(latitude, longitude);
LatLng DEST_LOCATION = LatLng(-23.535731, -46.545725);

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  StoresBloc _bloc;
  GoogleMapController _mapController;
  MapType _type = MapType.normal;
  Map<CircleId, Circle> circles = <CircleId, Circle>{};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<PolylineId, Polyline> polyLines = <PolylineId, Polyline>{};
  String _mapStyle;
  String category = "Comidas & Bebidas";
  String subcategory = "Comida Japonesa";
  bool isSubcategory = false;
  String cover = "assets/food-category.jpg";
  bool _nightMode = false;
  int _indexStore = 0;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = StoresBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  static final _options = CameraPosition(
    target: LatLng(latitude, longitude),
    zoom: 16,
  );

  void _select(MapTypes types) {
    setState(() {
      if (types.title == "Normal") {
        _type = MapType.normal;
      } else if (types.title == "Híbrido") {
        _type = MapType.hybrid;
      } else if (types.title == "Satélite") {
        _type = MapType.satellite;
      } else if (types.title == "Terreno") {
        _type = MapType.terrain;
      }
    });
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
      _mapController.setMapStyle(_mapStyle);
    });
  }

  Future<String> _getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Stack(
              children: <Widget>[
                GoogleMap(
                  initialCameraPosition: _options,
                  onMapCreated: onMapCreated,
                  mapType: _type,
                  circles: Set<Circle>.of(circles.values),
                  myLocationEnabled: true,
                  polylines: Set<Polyline>.of(polyLines.values),
                  markers: Set<Marker>.of(markers.values),
                ),
                Container(
                  height: 148,
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [Colors.white, Color(0x00FFFFFF)],
                    stops: [0.5, 6],
                    begin: Alignment(0, -3),
                    end: Alignment(0, 1),
                  )),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 55,
                        height: 58,
                        child: FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Image.asset(
                            "assets/icons/black/arrow_left_1.png",
                            width: 10,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: Text(
                          "Meu Mapa",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(
                              0xFF00BFB2,
                            ),
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.white,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
                      )),
                      Container(
                        width: 60,
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ],
            )),
            Container(
              height: 300.0,
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x44333333),
                    blurRadius: 15.0,
                    spreadRadius: 4.0,
                    offset: Offset(
                      0.0,
                      10.0,
                    ),
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                    width: double.infinity,
                    height: 60.0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Próximos",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: Color(0xFF444444),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Distância",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: Color(0xFF00BFB2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: StreamBuilder(
                        stream: _bloc.searchList(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            List<DocumentSnapshot> docs =
                                snapshot.data.documents;
                            List<Store> storesList =
                                _bloc.mapToList(docList: docs);
                            if (storesList.isNotEmpty) {
                              storesList
                                  .sort((a, b) => a.meters.compareTo(b.meters));
                              return storeListBuilder(storesList);
                            } else {
                              return NoStoresScreen();
                            }
                          } else {
                            return LoaderScreen();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget storeListBuilder(List<Store> storesList) {
    final Marker marker = Marker(
      markerId: MarkerId(_indexStore.toString()),
      position: LatLng(
          storesList[_indexStore].latitude, storesList[_indexStore].longitude),
      infoWindow: InfoWindow(
          title: storesList[_indexStore].name,
          snippet: storesList[_indexStore].score.toString()),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Products(
                store: storesList[_indexStore].name,
                adress: storesList[_indexStore].adress),
          ),
        );
      },
    );

    final Polyline polyline = Polyline(
      polylineId: PolylineId(_indexStore.toString()),
      consumeTapEvents: true,
      color: Colors.blueAccent,
      width: 10,
      points: [
        LatLng(storesList[_indexStore].latitude,
            storesList[_indexStore].longitude),
        LatLng(latitude, longitude),
      ],
      onTap: () {
        _onPolylineTapped(PolylineId(_indexStore.toString()));
      },
    );

    polyLines[PolylineId(_indexStore.toString())] = polyline;
    markers[MarkerId(_indexStore.toString())] = marker;

    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      itemCount: storesList.length,
      itemBuilder: (BuildContext context, int index) {
        addMarker(
            storesList[index].name,
            storesList[index].photo,
            storesList[index].score,
            storesList[index].latitude,
            storesList[index].longitude,
            index);
        if (userRange > storesList[index].meters.floor()) {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 100.0,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0xEEE9FF))),
                ),
                child: FlatButton(
                  padding:
                  EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Products(
                          store: storesList[index].name,
                          adress: storesList[index].adress,
                          photo: storesList[index].photo,
                          delivery: storesList[index].delivery,
                          score: storesList[index].score,
                          distance: storesList[index].meters,
                        ),
                      ),
                    );
                  },
                  child: StoreListItem(
                    photo: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.0),
                        image: DecorationImage(
                          image: NetworkImage(storesList[index].photo),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    name: storesList[index].name,
                    score: storesList[index].score,
                    adress: storesList[index].adress,
                    meters: storesList[index].meters.floor().toString(),
                    subcategories: storesList[index].subcategories,
                  ),
                ),
              ),
              Container(
                child: Divider(),
              ),
            ],
          );
        } else {
          return null;
        }
      },
    );
  }
  void _nightModeToggle() {
    if (_nightMode) {
      setState(() {
        _nightMode = false;
        _mapController.setMapStyle(null);
      });
    } else {
      _getFileData('asset/night_mode.json').then((style) {
        setState(() {
          _nightMode = true;
          _mapController.setMapStyle(style);
        });
      });
    }
  }
  void addMarker(String storeName, String storePhoto, num storeScore,
      double storeLatitude, double storeLongitude, int index) async {
    var iconurl = storePhoto;
    var dataBytes;
    var request = await http.get(iconurl);
    var bytes = await request.bodyBytes;

    setState(() {
      dataBytes = bytes;
    });

    final Marker marker = Marker(
//      icon: BitmapDescriptor.fromBytes(dataBytes.buffer.asUint8List()),
      markerId: MarkerId(index.toString()),
      position: LatLng(storeLatitude, storeLongitude),
      infoWindow: InfoWindow(title: storeName, snippet: storeScore.toString()),
      onTap: () {
        _onMarkerTapped(MarkerId(index.toString()));
      },
    );
    markers[MarkerId(index.toString())] = marker;
  }
  void addCircle() {
    final Circle circle = Circle(
      circleId: CircleId("1"),
      consumeTapEvents: true,
      strokeColor: Colors.blueAccent.withOpacity(0.5),
      fillColor: Colors.lightBlue.withOpacity(0.5),
      center: LatLng(-23.532547, -46.532404),
      strokeWidth: 2,
      radius: 5000,
      onTap: () {},
    );

    setState(() {
      circles[CircleId("1")] = circle;
    });
  }

  void addPolyline(String storeName, double storeLatitude,
      double storeLongitude, int index) {
    final Polyline polyline = Polyline(
      polylineId: PolylineId(index.toString()),
      consumeTapEvents: true,
      color: Colors.blueAccent,
      width: 2,
      points: [
        LatLng(latitude, longitude),
        LatLng(storeLatitude, storeLongitude),
      ],
      onTap: () {
        _onPolylineTapped(PolylineId(index.toString()));
      },
    );

    setState(() {
      polyLines[PolylineId(index.toString())] = polyline;
    });
  }

  void _onMarkerTapped(MarkerId markerId) {
    print("Marker $markerId Tapped!");
  }

  void _onPolylineTapped(PolylineId polylineId) {
    print("Polyline $polylineId Tapped!");
  }
}
