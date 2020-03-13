import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swappin/src/app.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;

//  Future<void> registerStore(
//      String name,
//      String email,
//      String category,
//      String delivery,
//      String open,
//      String close,
//      String photo,
//      String adress,
//      String description) async {
//    CollectionReference stores = _firestore.collection('stores');
//    var querySnapshot = await stores.getDocuments();
//    return stores.document(name).setData(
//      {
//        'id': querySnapshot.documents.length,
//        'name': name,
//        'email': email,
//        'category': category,
//        'delivery': delivery,
//        'open': "1900-01-01 ${open}Z",
//        'close': "1900-01-01 ${close}Z",
//        'position': {
//          'geopoint': GeoPoint(0.0, 0.0),
//        },
//        'adress': adress,
//        'photo': photo,
//        'description': description,
//        'score': 0.0,
//        'isOpen': true,
//      },
//    );
//  }

  Future<void> submitToBag(
    String storeName,
    String storeAdress,
    String storePhoto,
    num storeScore,
    String productName,
    String note,
    String photo,
    num price,
    int amount,
  ) async {
    List<String> userInitials = currentUserName.split(" ");
    String letter1 = userInitials[0][0].toUpperCase();
    String letter2 = userInitials[1][0].toUpperCase();
    String digit1 = Random().nextInt(9).toString();
    String digit2 = Random().nextInt(9).toString();
    String digit3 = Random().nextInt(9).toString();
    String digit4 = Random().nextInt(9).toString();
    String digit5 = Random().nextInt(9).toString();
    String digit6 = Random().nextInt(9).toString();
    String code = letter1 +
        letter2 +
        "-" +
        digit1 +
        digit2 +
        digit3 +
        digit4 +
        digit5 +
        digit6;
    return _firestore
        .collection('users')
        .document(currentUserEmail)
        .collection('userOrders')
        .document(code)
        .setData(
      {
        'amount': amount,
        'code': code,
        'email': currentUserEmail,
        'note': note,
        'photo': photo,
        'price': price,
        'productName': productName,
        'storeName': storeName,
        'storeAdress': storeName,
        'storePhoto': storePhoto,
        'storeScore': storeScore,
        'total': price * amount,
        'change': 0,
      },
      merge: true,
    );
  }

  //Atualiza a quantidade do produto no documento temporário através da Sacola
  Future<void> updateProductAmount(
      String email, String code, int amount, double total) {
    DocumentReference ref = _firestore
        .collection('users')
        .document(email)
        .collection('userOrders')
        .document(code);
    ref.updateData({'total': total});
    ref.updateData({'amount': amount});
  }

  //Atualiza a quantidade do produto no documento temporário através da Sacola
  Future<void> getChange(String email, String code, double change) {
    DocumentReference ref = _firestore
        .collection('users')
        .document(email)
        .collection('userOrders')
        .document(code);
    ref.updateData({'change': change});
  }

  //Envia o pedido configurado pelo usuário para a loja
  Future<void> orderProducts(
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
  ) async {
    CollectionReference stores = _firestore.collection('stores');
    concludeUserOrder(currentUserEmail, code);
    return stores
        .document(storeName)
        .collection('orders')
        .document(code)
        .setData(
      {
        'storeName': storeName,
        'storeAdress': storeAdress,
        'storeScore': storeScore,
        'storePhoto': storePhoto,
        'storeLatitude': storeLatitude,
        'storeLongitude': storeLongitude,
        '_products': products,
        '_prices': prices,
        '_amounts': amounts,
        'code': code,
        'userName': currentUserName,
        'userEmail': currentUserEmail,
        'userUID': currentUserUID,
        'photo': photo,
        'note': note,
        'change': 0,
        'total': total,
        'method': method,
        'status': '1',
        'initialDate': DateTime.now(),
        'finalDate': DateTime.now(),
      },
    );
  }

  //Após a conclusão do pedido e avaliação do usuário, deleta o pedido da coleção de pedidos correntes e envia os dados para o histórico da Loja e do Usuário
  Future<void> registerOrder(
    String code,
    List<dynamic> products,
    List<dynamic> prices,
    List<dynamic> amounts,
    String userName,
    String storeName,
    String adress,
    String note,
    String method,
    num total,
    DateTime date,
    double score,
  ) async {
    concludeOrder(storeName, code);
    return _firestore
        .collection('stores')
        .document(storeName)
        .collection('historic')
        .document(code)
        .setData(
      {
        'storeName': storeName,
        '_products': products,
        '_prices': prices,
        '_amounts': amounts,
        'code': code,
        'userName': currentUserName,
        'userEmail': currentUserEmail,
        'userUID': currentUserUID,
        'note': note,
        'change': 0,
        'total': total,
        'method': method,
        'status': '1',
        'initialDate': date,
        'finalDate': DateTime.now(),
        'score': score,
      },
    );
  }

  Future<void> registerUserOrder(
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
      bool isReviwed,
  ) async {
    return _firestore
        .collection('users')
        .document(currentUserEmail)
        .collection('historic')
        .document(code)
        .setData(
      {
        '_products': products,
        '_prices': prices,
        '_amounts': amounts,
        'storeName': storeName,
        'storeAdress': storeAdress,
        'storePhoto': storePhoto,
        'code': code,
        'user': currentUserEmail,
        'note': note,
        'total': total,
        'method': method,
        'status': '1',
        'initialDate': date,
        'finalDate': DateTime.now(),
        'review': review,
        'isReviwed': isReviwed,
      },
    );
  }

  Future<void> reviewStore(
      String storeName, String userComment, String code, int userReview) async {
    var docs = _firestore
        .collection('stores')
        .document(storeName)
        .collection('reviews')
        .getDocuments();

    docs.then((value){
      if(value.documents.length == 0 || value.documents == null){
        return _firestore
            .collection('stores')
            .document(storeName)
            .collection('reviews')
            .document(code)
            .setData(
          {
            'code': code,
            'userName': currentUserName,
            'userReview': userReview,
            'userComment': userComment,
          },
        );
      }else{
        return _firestore
            .collection('stores')
            .document(storeName)
            .collection('reviews')
            .document(code)
            .setData(
          {
            'code': code,
            'userName': currentUserName,
            'userReview': userReview,
            'userComment': userComment,
          },
        );
      }
    });
  }

  Future<void> collectNPS(String userComment, int userReview) async {
    return _firestore.collection('nps').document().setData(
      {
        'userName': currentUserName,
        'userEmail': currentUserEmail,
        'userComment': userComment,
        'userReview': userReview,
      },
    );
  }

  //Após a conclusão do pedido e avaliação do usuário, deleta o pedido da coleção de pedidos correntes e envia os dados para o histórico da Loja e do Usuário
  Future<void> registerCoupon(
    String userName,
    num value,
    String photo,
    String validity,
  ) async {
    return _firestore
        .collection('users')
        .document(userName)
        .collection('coupons')
        .document()
        .setData(
      {
        'value': value,
        'photo': photo,
        'validity': validity,
      },
    );
  }

  Stream<QuerySnapshot> getNotifications() {
    return _firestore
        .collectionGroup('orders')
        .where('userEmail', isEqualTo: currentUserEmail)
        .snapshots();
  }

  Stream<QuerySnapshot> getOrderStatus(String code) {
    return _firestore
        .collectionGroup('orders')
        .where('code', isEqualTo: code)
        .snapshots();
  }
  Stream<QuerySnapshot> getStoreReview(String storeName) {
    return _firestore
        .collection('stores')
        .document(storeName)
        .collection('reviews')
        .where('userReview')
        .snapshots();
  }

  Stream<QuerySnapshot> userHistoric() {
    return _firestore
        .collection('users')
        .document(currentUserEmail)
        .collection('historic')
        .where('user', isEqualTo: currentUserEmail)
        .snapshots();
  }

  Stream<QuerySnapshot> verifyOrderStatus(String userName, String code) {
    return _firestore
        .collectionGroup('orders')
        .where('code', isEqualTo: code)
        .snapshots();
  }

  Stream<QuerySnapshot> getBagItens() {
    return _firestore
        .collection('users')
        .document(currentUserEmail)
        .collection('userOrders')
        .where('email', isEqualTo: currentUserEmail)
        .snapshots();
  }

  Stream<QuerySnapshot> storesList(
      bool isSubcategory, String category, String subcategory) {
    if (isSubcategory != false) {
      return _firestore
          .collection('stores')
          .where('subcategory', arrayContains: subcategory)
          .snapshots();
    } else {
      return _firestore
          .collection('stores')
          .where('category', isEqualTo: category)
          .snapshots();
    }
  }

  Stream<QuerySnapshot> searchList() {
    return _firestore.collection('stores').snapshots();
  }

  Stream<QuerySnapshot> searchProducts(String keyword) {
    return _firestore.collectionGroup('products').snapshots();
  }

  Stream<QuerySnapshot> getCoupon(String email) {
    return _firestore
        .collection('users')
        .document(email)
        .collection('coupons')
        .snapshots();
  }

  Future<List<Map<dynamic, dynamic>>> getCollection() async {
    List<DocumentSnapshot> templist;
    List<Map<dynamic, dynamic>> list = new List();
    CollectionReference collectionRef = _firestore
        .collection("stores")
        .document("Loja São José I")
        .collection("products");
    QuerySnapshot collectionSnapshot = await collectionRef.getDocuments();

    templist = collectionSnapshot.documents; // <--- ERROR

    list = templist.map((DocumentSnapshot docSnapshot) {
      return docSnapshot.data;
    }).toList();
    return list;
  }

  Stream<QuerySnapshot> productsList(store) {
    return _firestore
        .collection('stores')
        .document(store)
        .collection('products')
        .snapshots();
  }

  getTotalPrice(String email) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .document(email)
        .collection('userOrders')
        .where('price')
        .getDocuments();
    var orderList = querySnapshot.documents;
    List<double> priceList = List();

    orderList.asMap().forEach((index, data) {
      priceList.add(data['price']);
    });

    return priceList.reduce((a, b) => a + b);
  }

  removeUser(String email) async {
    return _firestore.collection('users').document(email).delete();
  }

  concludeOrder(String storeName, String code) async {
    return _firestore
        .collection('stores')
        .document(storeName)
        .collection('orders')
        .document(code)
        .delete();
  }

  concludeUserOrder(String userEmail, String code) async {
    return _firestore
        .collection('users')
        .document(userEmail)
        .collection('userOrders')
        .document(code)
        .delete();
  }

  removeStore(String name) async {
    return _firestore.collection('stores').document(name).delete();
  }

  removeBagItem(String email, String code) async {
    return _firestore
        .collection('users')
        .document(email)
        .collection('userOrders')
        .document(code)
        .delete();
  }

  removeProduct(String store, String product) async {
    return _firestore
        .collection('stores')
        .document(store)
        .collection('stores')
        .document(product)
        .delete();
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
      int amount) async {
    return _firestore
        .collection('users')
        .document(currentUserEmail)
        .collection('userOrders')
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot product in snapshot.documents) {
        product.reference.delete();
      }
    }).then((onValue) => submitToBag(storeName, storeAdress, storePhoto,
            storeScore, productName, note, photo, price, amount));
  }
}
