import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/models/bag.dart';
import 'package:swappin/src/resources/repository.dart';

class BagBloc {
  final _repository = Repository();
  final _showProgress = BehaviorSubject<bool>();

  Observable<bool> get showProgress => _showProgress.stream;

  void submitToBag(
      String storeName,
      String storeAdress,
      String storePhoto,
      num storeScore,
      String productName,
      String note,
      String photo,
      num price,
      int amount) {
    _showProgress.sink.add(true);
    _repository.submitToBag(storeName, storeAdress, storePhoto, storeScore, productName, note, photo, price, amount).then((value) {
      _showProgress.sink.add(false);
    });
  }

  Future<void> updateProductAmount(
      String email, String code, int amount, double total) {
    return _repository.updateProductAmount(email, code, amount, total);
  }

  Future<void> getChange(
      String email, String code, double change) {
    return _repository.getChange(email, code, change);
  }

  getTotalPrice(String email) {
    return _repository.getTotalPrice(email);
  }

  Stream<QuerySnapshot> getBagItens() {
    return _repository.getBagItens();
  }

  List mapToList(
      {DocumentSnapshot doc, List<DocumentSnapshot> docList}) {
    if (docList != null) {
      List<Bag> productList = [];
      docList.forEach((document) {
        String storeName = document.data['storeName'];
        String storeAdress = document.data['storeAdress'];
        String storePhoto = document.data['storePhoto'];
        num storeScore = document.data['storeScore'];
        String userName = document.data['userName'];
        String productName = document.data['productName'];
        String code = document.data['code'];
        String note = document.data['note'];
        String photo = document.data['photo'];
        num price = document.data['price'];
        num amount = document.data['amount'];
        num change = document.data['change'];
        Bag productsList = Bag(userName, storeName, storeAdress, storePhoto, storeScore, productName, code, note,
            photo, price.toDouble(), amount.toInt(), change);
        productList.add(productsList);
      });
      return productList;
    } else {
      return null;
    }
  }

  void removeBagItem(String email, String code) {
    return _repository.removeBagItem(email, code);
  }


  clearBag(
      String storeName,
      String storeAdress,
      String storePhoto,
      num storeScore,
      String productName,
      String note,
      String photo,
      num price,
      int amount) {
    return _repository.clearBag(storeName, storeAdress, storePhoto, storeScore, productName, note, photo, price, amount);
  }

  void dispose() async {
    await _showProgress.drain();
    _showProgress.close();
  }
}
