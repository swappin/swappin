import 'package:flutter/material.dart';
import 'stores_bloc.dart';
export 'stores_bloc.dart';
class BlocProvider extends InheritedWidget{
  final bloc = Bloc();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static Bloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<BlocProvider>()).bloc;
  }
}