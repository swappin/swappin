import 'package:flutter/material.dart';
import 'package:swappin/src/blocs/bag_bloc.dart';
class BagBlocProvider extends InheritedWidget{
  final bloc = BagBloc();

  BagBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static BagBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BagBlocProvider) as BagBlocProvider).bloc;
  }
}