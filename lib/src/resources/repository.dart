import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:swappin/src/models/user.dart';
import 'package:swappin/src/resources/authentication_provider.dart';

import 'firestore_provider.dart';

class Repository {
  final _authenticationProvider = AuthenticationProvider();
  final _firestoreProvider = FirestoreProvider();

  Future<void> signout() {
    _authenticationProvider.signout();
  }

  Future<int> authenticateUser(String email) =>
      _authenticationProvider.authenticateUser(email);

  Future<void> registerUser(String uid, String email, String name, String birth,
          String genre, String photo, bool isSocialAuth) =>
      _authenticationProvider.registerUser(
          uid, email, name, birth, genre, photo, isSocialAuth);

  Future<void> registerDeletedUser(String birth, String genre, String photo,
          String reason, String message, String registerDate) =>
      _authenticationProvider.registerDeletedUser(
          birth, genre, photo, reason, message, registerDate);

  Future<int> signUpWithEmailAndPassword(String email, String password,
          String name, String birth, String genre, File image) =>
      _authenticationProvider.signUpWithEmailAndPassword(
          email, password, name, birth, genre, image);

  Future<int> signInWithEmailAndPassword(String email, String password) =>
      _authenticationProvider.signInWithEmailAndPassword(email, password);

  Future<void> resetPassword(String email) =>
      _authenticationProvider.resetPassword(email);

  Future<void> resetPasswordLogged() =>
      _authenticationProvider.resetPasswordLogged();

  Future<List> signInWithGoogle() => _authenticationProvider.signInWithGoogle();

  Future<List> signInWithFacebook() =>
      _authenticationProvider.signInWithFacebook();

/*  Future<void> uploadStore(String email, String title, String store) =>
      _firestoreProvider.uploadStore(title, email, store);

  Stream<DocumentSnapshot> myStoresList(String email) =>
      _firestoreProvider.myStoreList(email);

  Stream<QuerySnapshot> othersStoresList() => _firestoreProvider.othersStoreList();

  void removeStore(String title, email) =>
      _firestoreProvider.removeStore(title, email);*/

//  Future<void> registerStore(
//          String name,
//          String email,
//          String category,
//          String delivery,
//          String open,
//          String close,
//          String photo,
//          String adress,
//          String description) =>
//      _firestoreProvider.registerStore(name, email, category, delivery, open,
//          close, photo, adress, description);

  Future<void> submitToBag(
          String storeName,
          String storeAdress,
          String storePhoto,
          num storeScore,
          String productName,
          String note,
          String photo,
          num price,
          int amount) =>
      _firestoreProvider.submitToBag(storeName, storeAdress, storePhoto,
          storeScore, productName, note, photo, price, amount);

  Future<void> updateProductAmount(
          String email, String code, int amount, double total) =>
      _firestoreProvider.updateProductAmount(email, code, amount, total);

  Future<void> updateUserData({String name, String cpf, File image}) =>
      _authenticationProvider.updateUserData(
          name: name, cpf: cpf, image: image);

  Future<void> updateUserEmail(String email, String password) =>
      _authenticationProvider.updateUserEmail(email, password);

  Future<int> updateUserPassword(String password, String newPassword) =>
      _authenticationProvider.updateUserPassword(password, newPassword);

  Future<void> getChange(String email, String code, double change) =>
      _firestoreProvider.getChange(email, code, change);

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
  ) =>
      _firestoreProvider.orderProducts(
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
          total);

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
          double score) =>
      _firestoreProvider.registerOrder(code, products, prices, amounts,
          userName, storeName, adress, note, method, total, date, score);

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
          bool isReviwed) =>
      _firestoreProvider.registerUserOrder(
          code,
          products,
          prices,
          amounts,
          userName,
          storeName,
          storeAdress,
          storePhoto,
          note,
          method,
          total,
          date,
          review,
          isReviwed);

  Future<void> reviewStore(
          String storeName, String userComment, String code, int userReview) =>
      _firestoreProvider.reviewStore(storeName, userComment, code, userReview);

  Future<void> collectNPS(String userComment, int userReview) =>
      _firestoreProvider.collectNPS(userComment, userReview);

  Stream<QuerySnapshot> getCurrentUser() =>
      _authenticationProvider.getCurrentUser();

  Stream<QuerySnapshot> searchList() => _firestoreProvider.searchList();

  Stream<QuerySnapshot> getNotifications() =>
      _firestoreProvider.getNotifications();

  Stream<QuerySnapshot> getOrderStatus(String code) =>
      _firestoreProvider.getOrderStatus(code);

  Stream<QuerySnapshot> getStoreReview(String storeName) =>
      _firestoreProvider.getStoreReview(storeName);

  Stream<QuerySnapshot> userHistoric() => _firestoreProvider.userHistoric();

  Stream<QuerySnapshot> verifyOrderStatus(String userName, String code) =>
      _firestoreProvider.verifyOrderStatus(userName, code);

  Stream<QuerySnapshot> getBagItens() => _firestoreProvider.getBagItens();

  Stream<QuerySnapshot> searchProducts(String keyword) =>
      _firestoreProvider.searchProducts(keyword);

  Stream<QuerySnapshot> storesList(
          bool isSubcategory, String category, String subcategory) =>
      _firestoreProvider.storesList(isSubcategory, category, subcategory);

  Stream<QuerySnapshot> productsList(String store) =>
      _firestoreProvider.productsList(store);

  Stream<QuerySnapshot> getCoupon(String email) =>
      _firestoreProvider.getCoupon(email);

  getTotalPrice(String email) => _firestoreProvider.getTotalPrice(email);

  void removeUser(String email) => _firestoreProvider.removeStore(email);

  void removeStore(String name) => _firestoreProvider.removeStore(name);

  void removeBagItem(String email, String code) =>
      _firestoreProvider.removeBagItem(email, code);

  void concludeOrder(String storeName, String docID) =>
      _firestoreProvider.concludeOrder(storeName, docID);

  void removeProduct(String store, String product) =>
      _firestoreProvider.removeProduct(store, product);

  clearBag(
          String storeName,
          String storeAdress,
          String storePhoto,
          num storeScore,
          String productName,
          String note,
          String photo,
          num price,
          int amount) =>
      _firestoreProvider.clearBag(storeName, storeAdress, storePhoto,
          storeScore, productName, note, photo, price, amount);
}
