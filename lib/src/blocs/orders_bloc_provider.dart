import 'package:flutter/material.dart';
import 'orders_bloc.dart';
class OrdersBlocProvider extends InheritedWidget{
  final bloc = OrdersBloc();

  OrdersBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static OrdersBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(OrdersBlocProvider) as OrdersBlocProvider).bloc;
  }
}