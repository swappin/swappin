import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import '../../main.dart';
import '../models/store.dart';
import '../utils/strings.dart';
import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoresBloc {
  final _repository = Repository();
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _category = BehaviorSubject<String>();
  final _subcategory = BehaviorSubject<String>();
  final _delivery = BehaviorSubject<String>();
  final _open = BehaviorSubject<String>();
  final _close = BehaviorSubject<String>();
  final _photo = BehaviorSubject<String>();
  final _adress = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();
  final _showProgress = BehaviorSubject<bool>();
  final Distance distance = Distance();
  double range = 100000;

//  void submit() {
//    _showProgress.sink.add(true);
//    _repository
//        .registerStore(
//            _name.value,
//            _email.value,
//            _category.value,
//            _delivery.value,
//            _open.value,
//            _close.value,
//            _photo.value,
//            _adress.value,
//            _description.value)
//        .then((value) {
//      _showProgress.sink.add(false);
//    });
//  }



  Stream<QuerySnapshot> storesList(
      bool isSubcategory, String category, String subcategory) {
    return _repository.storesList(isSubcategory, category, subcategory);
  }

  Stream<QuerySnapshot> searchList() {
    return _repository.searchList();
  }
  Stream<QuerySnapshot> getStoreReview(String storeName) {
    return _repository.getStoreReview(storeName);
  }

  List mapToList({DocumentSnapshot doc, List<DocumentSnapshot> docList}) {
    if (docList != null) {
      List<Store> storeList = [];
      docList.forEach((document) async {
        String name = document.data[StringConstant.nameField];
        String adress = document.data[StringConstant.adressField];
        num score = document.data[StringConstant.scoreField];
        String delivery = document.data[StringConstant.deliveryField];
        String photo = document.data[StringConstant.photoField];
        String description = document.data[StringConstant.descriptionField];
        String open = document.data[StringConstant.openField];
        String close = document.data[StringConstant.closeField];
        List subcategories = document.data["subcategory"];
        GeoPoint geoPoint = document.data[StringConstant.geopointField];
        bool isOpen = document.data[StringConstant.isOpenField];
        final currentHour = DateTime.now();
        final openHour = DateTime.parse("1900-01-01 ${open}Z").hour;
        final closeHour = DateTime.parse("1900-01-01 ${close}Z").hour;
        int openMin = DateTime.parse("1900-01-01 ${open}Z").minute;
        int closeMin = DateTime.parse("1900-01-01 ${close}Z").minute;
        if (openHour <= currentHour.hour && currentHour.hour <= closeHour) {
          isOpen = true;
          if ((currentHour.hour == openHour && currentHour.minute < openMin) ||
              (currentHour.hour == closeHour &&
                  currentHour.minute > closeMin)) {
            isOpen = false;
          }
        } else {
          isOpen = false;
        }

        location.onLocationChanged().listen((LocationData currentLocation) {
          latitude = currentLocation.latitude;
          longitude = currentLocation.longitude;
        });

        final double meter = distance(
          LatLng(latitude, longitude),
          LatLng(geoPoint.latitude, geoPoint.longitude),
        );
        if (meter <= range && isOpen == true) {
          Store store = Store(
              name,
              adress,
              photo,
              delivery,
              description,
              meter,
              geoPoint.latitude,
              geoPoint.longitude,
              score.toDouble(),
              subcategories);
          await storeList.add(store);
        }
      });
      return storeList;
    } else {
      return null;
    }
  }

  Future<double> getLatitude() async {
    LocationData currentLocation = await location.getLocation();
    return Future.delayed(Duration(seconds: 4), () => currentLocation.latitude);
  }

  void dispose() async {
    await _name.drain();
    _name.close();
    await _email.drain();
    _email.close();
    await _category.drain();
    _category.close();
    await _delivery.drain();
    _category.close();
    await _open.drain();
    _open.close();
    await _close.drain();
    _close.close();
    await _photo.drain();
    _photo.close();
    await _adress.drain();
    _adress.close();
    await _description.drain();
    _description.close();
    await _showProgress.drain();
    _showProgress.close();
  }

  void removeStore(name) {
    return _repository.removeStore(name);
  }
}
