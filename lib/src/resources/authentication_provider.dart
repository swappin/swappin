import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:swappin/main.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/models/user.dart';

class AuthenticationProvider {
  Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String signInMethod;
  String _verificationId;
  bool _success;
  String _userID;
  FirebaseUser mCurrentUser;

//  Future<User> getCurrentUser() async {
//    mCurrentUser = await _auth.currentUser();
//    currentUser = mCurrentUser.email;
//    var querySnapshot = await Firestore.instance
//        .collection('users')
//        .document(currentUser);
//    var document = querySnapshot.get();
//    User user;
//    document.then((value) {
//      user = User(
//          value['id'],
//          value['name'],
//          value['email'],
//          value['cpf'],
//          value['birth'],
//          value['genre'],
//          value['photo'],
//          value['range'],
//          value['experience'],
//          value['badges']);
//    });
//    return user;
//  }

  Future<int> authenticateUser(String email) async {
    final QuerySnapshot result = await _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments();
    final List<DocumentSnapshot> docs = result.documents;
    if (docs.length == 0) {
      return 0;
    } else {
      return 1;
    }
  }

  Future<void> signout() async {
    await _auth.signOut();
  }

  Future<void> registerUser(String uid, String email, String name, String birth,
      String genre, String photo, bool isSocialAuth) async {
    CollectionReference users = Firestore.instance.collection('users');
    var querySnapshot = await users.getDocuments();
    return _firestore
        .collection('users')
        .document(email)
        .setData({
          'uid': uid,
          'id': querySnapshot.documents.length,
          'name': name,
          'email': email,
          'cpf': "Não Informado",
          'birth': birth,
          'genre': genre,
          'photo': photo,
          'experience': 100.0,
          'register-date': DateTime.now(),
          'isSocialAuth': isSocialAuth,
        })
        .then((onValue) => onValue)
        .catchError((onError) => onError);
  }

  Future<void> registerDeletedUser(String birth, String genre, String photo,
      String reason, String message, String registerDate) async {

    FirebaseUser user = await _auth.currentUser();
    return _firestore.collection('deleted').document(currentUserEmail).setData({
      'uid': currentUserUID,
      'name': currentUserName,
      'email': currentUserEmail,
      'birth': birth,
      'genre': genre,
      'photo': photo,
      'register-date': registerDate,
      'delete-date': DateTime.now(),
      'reason': reason,
      'message': message,
    }).then((onValue) {

      user.delete();
    }).catchError((onError) => onError);
  }

  Stream<QuerySnapshot> getCurrentUser() {
    return _firestore
        .collection('users')
        .where('email', isEqualTo: currentUserEmail)
        .snapshots();
  }

  Future<void> updateUserData({String name, String cpf, File image}) async {
    DocumentReference ref =
        _firestore.collection('users').document(currentUserEmail);

    if (image != null) {
      String filePath = 'users/$currentUserUID.jpg';
      _uploadTask = _storage.ref().child(filePath).putFile(image);
      await (await _uploadTask.onComplete).ref.getDownloadURL().then(
        (storageValue) {
          UserUpdateInfo updateInfo = UserUpdateInfo();
          updateInfo.photoUrl = storageValue.toString();
          user.updateProfile(updateInfo).then((onUpdateSucess) {
            currentUserName = name;
            currentUserPhoto = storageValue.toString();
            ref.updateData({'photo': storageValue.toString()});
            ref.updateData({'name': name});
            ref.updateData({'cpf': cpf});
          });
        },
      ).catchError((onError) => print(onError.toString()));
    } else {
      currentUserName = name;
      ref.updateData({'name': name});
      ref.updateData({'cpf': cpf});
    }
  }

  Future<void> updateUserEmail(String email, String password) async {
    FirebaseUser user = await _auth.currentUser();
    DocumentReference ref =
        _firestore.collection('users').document(currentUserEmail);
    String oldEmail = currentUserEmail;

    final AuthCredential credential = EmailAuthProvider.getCredential(
      email: currentUserEmail,
      password: password,
    );
    user.reauthenticateWithCredential(credential).then((onSignIn) {
      user.updateEmail(email).then((onUpdate) {
        _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((onReauthenticate) {
          currentUserEmail = email;
          ref.get().then((doc) {
            if (doc.exists) {
              var data = doc.data;
              _firestore
                  .collection("users")
                  .document(email)
                  .setData(data)
                  .then((onUpdate) {
                _firestore
                    .collection("users")
                    .document(email)
                    .updateData({'email': email});
                _firestore.collection('users').document(oldEmail).delete();
              });
            } else {}
          });
        });
      }).catchError((onError) {
        print("Erro ao tentar autenticar: $onError");
      });
    });
  }

  Future<int> updateUserPassword(String password, String newPassword) async {
    FirebaseUser user = await _auth.currentUser();
    final AuthCredential credential = EmailAuthProvider.getCredential(
      email: currentUserEmail,
      password: password,
    );
    await user.reauthenticateWithCredential(credential).then((onSignIn) {
      user.updatePassword(newPassword).then((onUpdate) {
        return 1;
      }).catchError((onError) {
        return 0;
      });
    });
  }

//  Future<int> signInWithEmailAndPassword(String email, String password) async {
//    List<String> providers =
//    await _auth.fetchSignInMethodsForEmail(email: email);
//    if (providers != null && providers.length > 0) {
//      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
//        email: email,
//        password: password,
//      ))
//          .user;
//      if (user != null) {
//        return 0;
//      }
//      return 1;
//    } else {
//      return 0;
//    }
//  }

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://swappin-database.appspot.com');

  StorageUploadTask _uploadTask;

  Future<void> _uploadProfilePhotoToStorage(
      String uid,
      String email,
      String password,
      String name,
      String birth,
      String genre,
      File image) async {
    String filePath = 'users/$uid.jpg';
    _uploadTask = _storage.ref().child(filePath).putFile(image);
    await (await _uploadTask.onComplete).ref.getDownloadURL().then(
      (storageValue) {
        UserUpdateInfo updateInfo = UserUpdateInfo();
        updateInfo.photoUrl = storageValue.toString();
        user.updateProfile(updateInfo).then((onUpdateSucess) {
          return registerUser(uid, email, name, birth, genre,
                  storageValue.toString(), false)
              .then((onRegisterValue) => 1);
        });
      },
    ).catchError((onError) => print(onError.toString()));
  }

  Future<int> signUpWithEmailAndPassword(String email, String password,
      String name, String birth, String genre, File image) async {
    List<String> providers =
        await _auth.fetchSignInMethodsForEmail(email: email);
    if (providers != null && providers.length > 0) {
      return 0;
    } else {
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
        (createValue) {
          if (image != null) {
            return _uploadProfilePhotoToStorage(createValue.user.uid, email,
                password, name, birth, genre, image);
          } else {
            return registerUser(createValue.user.uid, email, name, birth, genre,
                    null, false)
                .then((onRegisterValue) => 1);
          }
        },
      );
    }
  }

  Future<int> signInWithEmailAndPassword(String email, String password) async {
    List<String> providers =
        await _auth.fetchSignInMethodsForEmail(email: email);
    if (providers != null && providers.length > 0) {
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        return 1;
      }
      return 1;
    } else {
      return 0;
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> resetPasswordLogged() async {
    await _auth.sendPasswordResetEmail(email: currentUserEmail);
  }

  Future<List> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    if (user != null) {
      _success = true;
      _userID = user.uid;
      List<String> userData = [];
      userData.add(user.uid);
      userData.add(user.email);
      userData.add(user.displayName);
      userData.add(user.photoUrl);
      return userData;
    } else {
      _success = false;
    }
  }

  // Code to sign in with Facebook.
  final FacebookLogin facebookLogin = FacebookLogin();

  Future<List> signInWithFacebook() async {
    FacebookLoginResult facebookLoginResult =
        await facebookLogin.logIn(['email']);
    final FacebookAccessToken accessToken = facebookLoginResult.accessToken;
    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: accessToken.token,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    if (user != null) {
      _success = true;
      _userID = user.uid;
      List<String> userData = [];
      userData.add(user.uid);
      userData.add(user.email);
      userData.add(user.displayName);
      userData.add(user.photoUrl);
      return userData;
    } else {
      _success = false;
    }
  }
}
