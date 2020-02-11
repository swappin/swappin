import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swappin/src/models/bag.dart';
import 'package:swappin/src/models/coupon.dart';
import 'package:swappin/src/resources/repository.dart';

class CouponBloc {
  final _repository = Repository();
  final _showProgress = BehaviorSubject<bool>();

  Observable<bool> get showProgress => _showProgress.stream;

  Stream<QuerySnapshot> getCoupon(String email){
    return _repository.getCoupon(email);
  }

  List mapToList(
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

  void removeCouponItem(String email, String code) {
    return _repository.removeBagItem(email, code);
  }

  void dispose() async {
    await _showProgress.drain();
    _showProgress.close();
  }
}
