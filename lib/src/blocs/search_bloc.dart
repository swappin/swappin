//import 'dart:async';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:location/location.dart';
//import 'package:latlong/latlong.dart';
//import '../../main.dart';
//import '../models/store.dart';
//import '../utils/strings.dart';
//import '../resources/repository.dart';
//import 'package:rxdart/rxdart.dart';
//
//class SearchBloc {
//  final _repository = Repository();
//  final _search = BehaviorSubject<String>();
//  LocationData currentLocation;
//  var location = new Location();
//  final Distance distance = new Distance();
//  double currentLatitude = 0.0;
//  double currentLongitude = 0.0;
//  double range = 2500.0;
//
//  Observable<String> get search => _search.stream.transform(_validateSearch);
//
//  Function(String) get changeSearch => _search.sink.add;
//
//  final _validateSearch = StreamTransformer<String, String>.fromHandlers(
//    handleData: (search, sink) {
//      if (search.length > 1) {
//        sink.add(search);
//      } else {
//        sink.addError(StringConstant.storeValidateMessage);
//      }
//    },
//  );
//
//  Stream<QuerySnapshot> searchList() {
//    return _repository.searchList();
//  }
//
//  Stream<QuerySnapshot> searchProducts(String product) {
//    return _repository.searchProducts(product);
//  }
//
//  //dispose all open sink
//  void dispose() async {
//    await _search.drain();
//    _search.close();
//  }
//
//  //Convert map to goal list
//  List mapToList({DocumentSnapshot doc, List<DocumentSnapshot> docList}) {
//    if (docList != null) {
//      List<Store> storeList = [];
//      docList.forEach((document) {
//        String productName;
//        String name = document.data[StringConstant.nameField];
//        String adress = document.data[StringConstant.adressField];
//        num score = document.data[StringConstant.scoreField];
//        String delivery = document.data[StringConstant.deliveryField];
//        String photo = document.data[StringConstant.photoField];
//        String description = document.data[StringConstant.descriptionField];
//        String open = document.data[StringConstant.openField];
//        String close = document.data[StringConstant.closeField];
//        GeoPoint geoPoint = document.data[StringConstant.positionField]
//            [StringConstant.geopointField];
//
//        bool isOpen = document.data[StringConstant.isOpenField];
//        final currentHour = DateTime.now();
//        final openHour = DateTime.parse("1900-01-01 ${open}Z").hour;
//        final closeHour = DateTime.parse("1900-01-01 ${close}Z").hour;
//        int openMin = DateTime.parse("1900-01-01 ${open}Z").minute;
//        int closeMin = DateTime.parse("1900-01-01 ${close}Z").minute;
//        if (openHour <= currentHour.hour && currentHour.hour <= closeHour) {
//          isOpen = true;
//          if ((currentHour.hour == openHour && currentHour.minute < openMin) ||
//              (currentHour.hour == closeHour &&
//                  currentHour.minute > closeMin)) {
//            isOpen = false;
//          }
//        } else {
//          isOpen = false;
//        }
//        final double meter = distance(
//          LatLng(latitude, longitude),
//          LatLng(geoPoint.latitude, geoPoint.longitude),
//        );
//
////        QuerySnapshot productRef = await document.reference.collection('products').getDocuments();
////        productRef.documents.forEach((value){
////          productName = value["name"];
////        });
//
//        if (meter <= range && isOpen == true) {
//          Store otherStore = Store(
//              name,
//              adress,
//              photo,
//              score.toDouble(),
//              delivery,
//              meter,
//              geoPoint.latitude,
//              geoPoint.longitude,
//              description,
//              productName,
//              10.0,
//              "");
//          storeList.add(otherStore);
//        }
//      });
//      return storeList;
//    } else {
//      return null;
//    }
//  }
//
//  Future<double> getLatitude() async {
//    LocationData currentLocation = await location.getLocation();
//    return Future.delayed(Duration(seconds: 4), () => currentLocation.latitude);
//  }
//
//  //Remove item from the store list
//  void removeStore(name) {
//    return _repository.removeStore(name);
//  }
//}
