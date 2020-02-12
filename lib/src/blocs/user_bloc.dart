import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swappin/src/models/user.dart';
import 'package:swappin/src/resources/repository.dart';

class UserBloc {
  final _repository = Repository();
  final _showProgress = BehaviorSubject<bool>();

  Observable<bool> get showProgress => _showProgress.stream;

  Stream<QuerySnapshot> getCurrentUser()  {
    return _repository.getCurrentUser();
  }

  List mapToList(
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
  void dispose() async {
    await _showProgress.drain();
    _showProgress.close();
  }
}
