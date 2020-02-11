import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/models/user.dart';

import '../utils/strings.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

bool isAuthMethod = false;

class LoginBloc {
  final _repository = Repository();
  final _email = BehaviorSubject<String>();
  final _resetEmail = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();
  final _cpf = BehaviorSubject<String>();
  final _birth = BehaviorSubject<String>();
  final _genre = BehaviorSubject<String>();
  final _photo = BehaviorSubject<String>();
  final _isSignedIn = BehaviorSubject<bool>();
  final _isSignedUp = BehaviorSubject<bool>();

  Observable<String> get email => _email.stream.transform(_validateEmail);

  Observable<String> get resetEmail =>
      _resetEmail.stream.transform(_validateResetEmail);

  Observable<String> get password =>
      _password.stream.transform(_validatePassword);

  Observable<String> get name => _name.stream.transform(_validateName);

  Observable<String> get cpf => _cpf.stream.transform(_validateCpf);

  Observable<String> get birth => _birth.stream.transform(_validateBirth);

  Observable<String> get genre => _genre.stream.transform(_validateGenre);

  Observable<String> get photo => _photo.stream;

  Observable<bool> get signInStatus => _isSignedIn.stream;

  Observable<bool> get signUpStatus => _isSignedUp.stream;

  String get emailAddress => _email.value;

  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changeResetEmail => _resetEmail.sink.add;

  Function(String) get changePassword => _password.sink.add;

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

  Future<int> authenticateUser(String email) {
    return _repository.authenticateUser(email);
  }

  Future<void> registerUser(String uid, String email, String name, String birth,
      String genre, String photo) {
    return _repository.registerUser(uid, email, name, birth, genre, photo);
  }

  Future<void> updateUserData({File image}) {
    return _repository.updateUserData(
        name: _name.value != null ? _name.value : currentUserName,
        cpf: _cpf.value != null ? _cpf.value : "Não Informado",
        image: image);
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
    print(_resetEmail.value);
    return _repository.resetPassword(_resetEmail.value);
  }

  Future<List> signInWithGoogle() {
    return _repository.signInWithGoogle();
  }

  Future<List> signInWithFacebook() {
    return _repository.signInWithFacebook();
  }

  Stream<QuerySnapshot> getCurrentUser(String email) {
    return _repository.getCurrentUser(email);
  }

  List mapToList({DocumentSnapshot doc, List<DocumentSnapshot> docList}) {
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
        User user = User(id, name, email, cpf, birth, genre, photo, range,
            experience, badges);
        userData.add(user);
      });
      return userData;
    } else {
      return null;
    }
  }

  void dispose() async {
    await _email.drain();
    _email.close();
    await _password.drain();
    _password.close();
    await _isSignedIn.drain();
    _isSignedIn.close();
    await _isSignedUp.drain();
    _isSignedUp.close();
  }

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

  bool validateResetField() {
    if (_resetEmail.value != null && _resetEmail.value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String confirmPasswordMessage(String confirmPassword) {
    if (confirmPassword != _password.value) {
      return "A senha de confirmação é diferente da senha inserida.";
    }
  }

  bool validateFieldsRegister(
      String birth, String genre, String confirmPassword) {
    _birth.value = birth;
    _genre.value = genre;
    if (_email.value != null &&
        _email.value.isNotEmpty &&
        _password.value != null &&
        _password.value.isNotEmpty &&
        _name.value != null &&
        _name.value.isNotEmpty &&
        _birth.value != null &&
        _birth.value.isNotEmpty &&
        _genre.value != null &&
        _genre.value.isNotEmpty &&
        confirmPassword == _password.value) {
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
}
