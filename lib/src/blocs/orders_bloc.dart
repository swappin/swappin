import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swappin/src/models/order.dart';
import 'package:swappin/src//utils/strings.dart';
import 'package:swappin/src/resources/repository.dart';

class OrdersBloc {
  final _repository = Repository();
  final _showProgress = BehaviorSubject<bool>();

  Observable<bool> get showProgress => _showProgress.stream;

  void orderProducts(
      String storeName,
      String storeAdress,
      String storePhoto,
      num storeScore,
      double storeLatitude,
      double storeLongitude,
    String code,
    List<dynamic> products,
    List<dynamic> prices,
    List<dynamic> amounts,
    String photo,
    String note,
    String method,
    num total,
  ) {
    _showProgress.sink.add(true);
    _repository
        .orderProducts(
      storeName,
      storeAdress,
      storePhoto,
      storeScore,
      storeLatitude,
      storeLongitude,
      code,
      products,
      prices,
      amounts,
      photo,
      note,
      method,
      total,
    )
        .then((value) {
      _showProgress.sink.add(false);
    });
  }

  void registerOrders(
      String code,
      List<dynamic> products,
      List<dynamic> prices,
      List<dynamic> amounts,
      String userName,
      String storeName,
      String storeAdress,
      String storePhoto,
      String note,
      String method,
      num total,
      DateTime date,
      double review,
      bool isReviwed
      ) {
    _showProgress.sink.add(true);
    _repository
        .registerOrder(code, products, prices, amounts, userName, storeName,
            storeAdress, note, method, total, date, review)
        .then((value) {
      _showProgress.sink.add(false);
    });
    _repository
        .registerUserOrder(code, products, prices, amounts, userName, storeName,
            storeAdress, storePhoto, note, method, total, date, review, isReviwed)
        .then((value) {
      _showProgress.sink.add(false);
    });
  }


  void reviewStore(String storeName, String userComment, String code, int userReview) =>
      _repository.reviewStore(storeName, userComment, code, userReview);

  void collectNPS(String userComment, int userReview) =>
      _repository.collectNPS(userComment, userReview);

  Stream<QuerySnapshot> verifyOrderStatus(String userName, String code) {
    return _repository.verifyOrderStatus(userName, code);
  }

  Stream<QuerySnapshot> getNotifications() {
    return _repository.getNotifications();
  }

  Stream<QuerySnapshot> getOrderStatus(String code){
    return _repository.getOrderStatus(code);
  }

  Stream<QuerySnapshot> userHistoric() {
    return _repository.userHistoric();
  }

  //Convert map to goal list
  List mapToList({DocumentSnapshot doc, List<DocumentSnapshot> docList}) {
    if (docList != null) {
      List<Order> orderList = [];
      docList.forEach((document) {
        String storeName = document.data['storeName'];
        String storeAdress = document.data['storeAdress'];
        String storePhoto = document.data['storePhoto'];
        num storeScore = document.data['storeScore'];
        double storeLatitude = document.data['storeLatitude'];
        double storeLongitude = document.data['storeLongitude'];
        String status = document.data['status'];
        String code = document.data['code'];
        String photo = document.data['photo'];
        String note = document.data['note'];
        String method = document.data['method'];
        DateTime initialDate = document.data['initialDate'].toDate();
        DateTime finalDate = document.data['finalDate'].toDate();
        num total = document.data['total'];
        List<dynamic> productList = document.data['_products'];
        List<dynamic> priceList = document.data['_prices'];
        List<dynamic> amountList = document.data['_amounts'];

        Order ordersList = Order(
            storeName,
            storeAdress,
            storePhoto,
            storeScore,
            storeLatitude,
            storeLongitude,
            status,
            code,
            photo,
            note,
            method,
            initialDate,
            finalDate,
            total,
            productList,
            priceList,
            amountList);
        orderList.add(ordersList);
      });
      return orderList;
    } else {
      return null;
    }
  }

  //Remove item from the goal list
  void concludeOrder(String storeName, String docID) {
    return _repository.concludeOrder(storeName, docID);
  }

  //dispose all open sink
  void dispose() async {
    await _showProgress.drain();
    _showProgress.close();
  }
}
