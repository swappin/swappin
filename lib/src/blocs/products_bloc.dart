import 'dart:async';
import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swappin/main.dart';
import 'package:swappin/src/models/product.dart';
import 'package:swappin/src/resources/repository.dart';
import 'package:swappin/src/utils/strings.dart';

class ProductsBloc {
  final _repository = Repository();
  final _search = BehaviorSubject<String>();
  final _showProgress = BehaviorSubject<bool>();
  final Distance distance = Distance();
  double range = 2500.0;

  Observable<String> get search => _search.stream.transform(_validateSearch);

  Observable<bool> get showProgress => _showProgress.stream;

  Function(String) get changeSearch => _search.sink.add;

  final _validateSearch = StreamTransformer<String, String>.fromHandlers(
      handleData: (search, sink) {
    if (search.length > 3) {
      sink.add(search);
    } else {
      sink.addError(StringConstant.storeValidateMessage);
    }
  });

  Stream<QuerySnapshot> productsList(store) {
    return _repository.productsList(store);
  }

  Stream<QuerySnapshot> searchProducts(String keyword) {
    return _repository.searchProducts(keyword);
  }

  List mapToList({DocumentSnapshot doc, List<DocumentSnapshot> docList}) {
    if (docList != null) {
      List<Product> productList = [];
      docList.forEach((document) {
        String name = document.data['name'];
        String code = document.data['code'];
        String photo = document.data['photo'];
        String description = document.data['description'];
        String storeName = document.data['storeName'];
        String storeAdress = document.data['storeAdress'];
        String storePhoto = document.data['storePhoto'];
        num storeScore = document.data['storeScore'];
        GeoPoint geoPoint = document.data['geopoint'];
        num price = document.data['price'];
        num promotionPrice = document.data['promotionPrice'];
        bool isPromotion = document.data['isPromotion'];
        bool isEnable = document.data['enable'];
        List<dynamic> productKeywords = document.data['keywords'];
        final double productDistance = distance(
          LatLng(latitude, longitude),
          LatLng(geoPoint.latitude, geoPoint.longitude),
        );
        Product productsList = Product(
          name,
          code,
          photo,
          description,
          storeName,
          storeAdress,
          storePhoto,
          storeScore,
          productDistance,
          price,
          promotionPrice,
          isPromotion,
          isEnable,
          productKeywords,
        );
        productList.add(productsList);
      });
      return productList;
    } else {
      return null;
    }
  }

  void dispose() async {
    await _search.drain();
    _search.close();
    await _showProgress.drain();
    _showProgress.close();
  }
}
