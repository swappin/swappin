import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:swappin/main.dart';
import 'package:swappin/src/models/bag.dart';
import 'package:swappin/src/models/coupon.dart';
import 'package:swappin/src/models/order.dart';
import 'package:swappin/src/models/product.dart';
import 'package:swappin/src/models/store.dart';
import 'package:swappin/src//utils/strings.dart';
import 'package:swappin/src//resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/models/user.dart';

class Bloc {
  double range = 100000;
  static bool isAuthMethod = false;
  final Distance distance = Distance();
  final _repository = Repository();
  final _email = BehaviorSubject<String>();
  final _resetEmail = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _confirmPassword = BehaviorSubject<String>();
  final _newPassword = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();
  final _cpf = BehaviorSubject<String>();
  final _birth = BehaviorSubject<String>();
  final _genre = BehaviorSubject<String>();
  final _photo = BehaviorSubject<String>();
  final _isSignedIn = BehaviorSubject<bool>();
  final _isSignedUp = BehaviorSubject<bool>();
  final _search = BehaviorSubject<String>();
  final _showProgress = BehaviorSubject<bool>();



  Observable<String> get email => _email.stream.transform(_validateEmail);

  Observable<String> get resetEmail =>
      _resetEmail.stream.transform(_validateResetEmail);

  Observable<String> get password =>
      _password.stream.transform(_validatePassword);

  Observable<String> get confirmPassword =>
      _confirmPassword.stream.transform(_validateConfirmPassword);

  Observable<String> get newPassword =>
      _newPassword.stream.transform(_validateNewPassword);

  Observable<String> get name => _name.stream.transform(_validateName);

  Observable<String> get cpf => _cpf.stream.transform(_validateCpf);

  Observable<String> get birth => _birth.stream.transform(_validateBirth);

  Observable<String> get genre => _genre.stream.transform(_validateGenre);

  Observable<String> get photo => _photo.stream;

  Observable<bool> get signInStatus => _isSignedIn.stream;

  Observable<bool> get signUpStatus => _isSignedUp.stream;

  //Procurar por Produtos
  Observable<String> get search => _search.stream.transform(_validateSearch);

  Observable<bool> get showProgress => _showProgress.stream;

  Function(String) get changeSearch => _search.sink.add;


  String get emailAddress => _email.value;

  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changeResetEmail => _resetEmail.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Function(String) get changeConfirmPassword => _confirmPassword.sink.add;

  Function(String) get changeNewPassword => _newPassword.sink.add;

  Function(String) get changeName => _name.sink.add;

  Function(String) get changeCpf => _cpf.sink.add;

  Function(String) get changeBirth => _birth.sink.add;

  Function(String) get changeGenre => _genre.sink.add;

  Function(String) get changePhoto => _photo.add;

  Function(bool) get showProgressBar => _isSignedIn.sink.add;

  Function(bool) get showProgressReg => _isSignedUp.sink.add;

  final _validateEmail =
  StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email) ||
        RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
            .hasMatch(email)) {
      isAuthMethod = true;
      sink.add(email);
    } else {
      sink.addError(StringConstant.emailValidateMessage);
    }
  });

  final _validateResetEmail =
  StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email) ||
        RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
            .hasMatch(email)) {
      isAuthMethod = true;
      sink.add(email);
    } else {
      sink.addError(StringConstant.emailValidateMessage);
    }
  });

  final _validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (password.length > 3) {
          sink.add(password);
        } else {
          sink.addError(StringConstant.passwordValidateMessage);
        }
      });

  final _validateConfirmPassword =
  StreamTransformer<String, String>.fromHandlers(
      handleData: (confirmPassword, sink) {
        if (confirmPassword.length > 3) {
          sink.add(confirmPassword);
        } else {
          sink.addError(StringConstant.passwordValidateMessage);
        }
      });

  final _validateNewPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (newPassword, sink) {
        if (newPassword.length > 3) {
          sink.add(newPassword);
        } else {
          sink.addError(StringConstant.passwordValidateMessage);
        }
      });

  final _validateName =
  StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(name)) {
      sink.addError(StringConstant.nameValidateMessage);
    } else {
      sink.add(name);
    }
  });

  final _validateCpf =
  StreamTransformer<String, String>.fromHandlers(handleData: (cpf, sink) {
    if (RegExp(r'^[0-9]*$').hasMatch(cpf)) {
      sink.add(cpf);
    } else {
      sink.addError(StringConstant.cpfValidateMessage);
    }
  });

  final _validateBirth = StreamTransformer<String, String>.fromHandlers(
    handleData: (birth, sink) {
      if (birth == null) {
        sink.addError(StringConstant.genreValidateMessage);
      }
    },
//      handleData: (cpf, sink) {
//    if (RegExp(r'([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))').hasMatch(cpf)) {
//      sink.add(cpf);
//    } else {
//      sink.addError(StringConstant.birthValidateMessage);
//    }
//  },
  );

  final _validateGenre =
  StreamTransformer<String, String>.fromHandlers(handleData: (genre, sink) {
    if (genre == null) {
      sink.addError(StringConstant.genreValidateMessage);
    }
  });

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

  //MÉTODOS DE GRAVAÇÃO
  Future<void> signout() {
    return _repository.signout();
  }

  Future<int> authenticateUser(String email) {
    return _repository.authenticateUser(email);
  }

  Future<void> registerUser(String uid, String email, String name, String birth,
      String genre, String photo, bool isSocialAuth) {
    return _repository.registerUser(
        uid, email, name, birth, genre, photo, isSocialAuth);
  }

  Future<void> registerDeletedUser(String birth, String genre, String photo,
      String reason, String message, String registerDate) {
    return _repository.registerDeletedUser(
        birth, genre, photo, reason, message, registerDate);
  }

  Future<void> updateUserData({File image}) {
    return _repository.updateUserData(
        name: _name.value != null ? _name.value : currentUserName,
        cpf: _cpf.value != null ? _cpf.value : "Não Informado",
        image: image);
  }

  Future<void> updateUserEmail() {
    return _repository.updateUserEmail(_email.value, _password.value);
  }

  Future<int> updateUserPassword() {
    return _repository.updateUserPassword(_password.value, _newPassword.value);
  }

  Future<int> signUpWithEmailAndPassword(File image, String genre) {
    return _repository.signUpWithEmailAndPassword(
        _email.value, _password.value, _name.value, _birth.value, genre, image);
  }

  Future<int> signInWithEmailAndPassword() {
    return _repository.signInWithEmailAndPassword(
        _email.value, _password.value);
  }

  Future<void> resetPassword() {
    return _repository.resetPassword(_resetEmail.value);
  }

  Future<void> resetPasswordLogged() {
    return _repository.resetPasswordLogged();
  }

  Future<List> signInWithGoogle() {
    return _repository.signInWithGoogle();
  }

  Future<List> signInWithFacebook() {
    return _repository.signInWithFacebook();
  }

  Future<void> updateProductAmount(
      String email, String code, int amount, double total) {
    return _repository.updateProductAmount(email, code, amount, total);
  }

  Future<void> getChange(
      String email, String code, double change) {
    return _repository.getChange(email, code, change);
  }

  Stream<QuerySnapshot> getCurrentUser()  {
    return _repository.getCurrentUser();
  }

  Stream<QuerySnapshot> getBagItens() {
    return _repository.getBagItens();
  }
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

  Stream<QuerySnapshot> getCoupon(String email){
    return _repository.getCoupon(email);
  }

  getTotalPrice(String email) {
    return _repository.getTotalPrice(email);
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

  void removeBagItem(String email, String code) {
    return _repository.removeBagItem(email, code);
  }


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

  void concludeOrder(String storeName, String docID) {
    return _repository.concludeOrder(storeName, docID);
  }

  void removeCouponItem(String email, String code) {
    return _repository.removeBagItem(email, code);
  }
  //MÉTODOS DE CONSTRUÇÃO DE LISTA

  List loginToList({DocumentSnapshot doc, List<DocumentSnapshot> docList}) {
    if (docList != null) {
      List<User> userData = [];
      docList.forEach((document) {
        num id = document.data['id'];
        String name = document.data['name'];
        String email = document.data['email'];
        String cpf = document.data['cpf'];
        String birth = document.data['birth'];
        String genre = document.data['genre'];
        String photo = document.data['photo'];
        num range = document.data['range'];
        num experience = document.data['experience'];
        Map<dynamic, dynamic> badges = document.data['badges'];
        bool isSocialAuth = document.data[['isSocialAuth']];

        String registerDate = document.data['register-date'].toString();
        User user = User(id, name, email, cpf, birth, genre, photo, range,
            experience, badges, isSocialAuth, registerDate);
        userData.add(user);
      });
      return userData;
    } else {
      return null;
    }
  }

  List userToList(
      {DocumentSnapshot doc, List<DocumentSnapshot> docList}) {
    if (docList != null) {
      List<User> userData = [];
      docList.forEach((document) {
        num id = document.data['id'];
        String name = document.data['name'];
        String email = document.data['email'];
        String cpf = document.data['cpf'];
        String birth = document.data['birth'];
        String genre = document.data['genre'];
        String photo = document.data['photo'];
        num range = document.data['range'];
        num experience = document.data['experience'];
        Map<dynamic, dynamic> badges = document.data['badges'];
        bool isSocialAuth =  document.data['isSocialAuth'];
        String registerDate = document.data['registerDate'];
        User user = User(id, name, email, cpf, birth, genre, photo, range, experience, badges, isSocialAuth, registerDate);
        userData.add(user);
      });
      return userData;
    } else {
      return null;
    }
  }

  List storesToList({DocumentSnapshot doc, List<DocumentSnapshot> docList}) {
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
          storeList.add(store);
        }
      });
      return storeList;
    } else {
      return null;
    }
  }

  List productsToList({DocumentSnapshot doc, List<DocumentSnapshot> docList}) {
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

  List bagItensToList(
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

  List ordersToList({DocumentSnapshot doc, List<DocumentSnapshot> docList}) {
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

  List couponToList(
      {DocumentSnapshot doc, List<DocumentSnapshot> docList, String store}) {
    if (docList != null) {
      List<Coupon> couponList = [];
      docList.forEach((document) {
        num value = document.data['value'];
        String photo = document.data['photo'];
        String validity = document.data['validity'];
        Coupon couponsList = Coupon(value, photo, validity);
        couponList.add(couponsList);
      });
      return couponList;
    } else {
      return null;
    }
  }

  //DISPOSE
  void dispose() async {
    await _email.drain();
    _email.close();
    await _password.drain();
    _password.close();
    await _resetEmail.drain();
    _resetEmail.close();
    await _confirmPassword.drain();
    _confirmPassword.close();
    await _newPassword.drain();
    _newPassword.close();
    await _name.drain();
    _name.close();
    await _cpf.drain();
    _cpf.close();
    await _birth.drain();
    _birth.close();
    await _photo.drain();
    _photo.close();
    await _genre.drain();
    _genre.close();
    await _resetEmail.drain();
    _resetEmail.close();
    await _isSignedIn.drain();
    _isSignedIn.close();
    await _isSignedUp.drain();
    _isSignedUp.close();
    await _search.drain();
    _search.close();
    await _showProgress.drain();
    _showProgress.close();
  }

  //MÉTODOS DE VALIDAÇÃO
  bool validateFields() {
    if (_email.value != null &&
        _email.value.isNotEmpty &&
        _password.value != null &&
        _password.value.isNotEmpty &&
        isAuthMethod == true &&
        _password.value.length > 3) {
      return true;
    } else {
      return false;
    }
  }

  bool validateConfirmPasswordFields() {
    if (isAuthMethod == true &&
        _password.value.length > 3 &&
        _confirmPassword.value.length > 3 &&
        _confirmPassword.value == _password.value) {
      return true;
    } else {
      return false;
    }
  }

  bool validateNewPasswordFields() {
    if (_password.value != null &&
        _password.value.isNotEmpty &&
        _newPassword.value != null &&
        _newPassword.value.isNotEmpty &&
        _confirmPassword.value != null &&
        _confirmPassword.value.isNotEmpty &&
        _newPassword.value != _password.value &&
        _newPassword.value == _confirmPassword.value) {
      return true;
    } else {
      return false;
    }
  }

  bool validateResetField() {
    if (_resetEmail.value != null && _resetEmail.value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFieldsRegister(String birth, String genre) {
    _birth.value = birth;
    _genre.value = genre;
    if (_email.value != null &&
        _email.value.isNotEmpty &&
        _password.value != null &&
        _password.value.isNotEmpty &&
        _name.value != null &&
        _name.value.isNotEmpty &&
        birth != null &&
        genre != null) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFieldsSocialRegister(
      String email, String name, String birth, String genre) {
    if (email != null && name != null && birth != null && genre != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<double> getLatitude() async {
    LocationData currentLocation = await location.getLocation();
    return Future.delayed(Duration(seconds: 4), () => currentLocation.latitude);
  }

  //MENSAGENS DE ERRO
  String errorPasswordConfirm() {
    return "Por favor, verifique se a senha e a confirmação de senha são iguais.";
  }

  String errorValidateField() {
    return "Parece que um dos campos foi preenchido de forma errada.";
  }
}