import 'package:flutter/material.dart';
import 'package:swappin/src/blocs/coupon_bloc.dart';
class CouponBlocProvider extends InheritedWidget{
  final bloc = CouponBloc();

  CouponBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static CouponBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CouponBlocProvider) as CouponBlocProvider).bloc;
  }
}