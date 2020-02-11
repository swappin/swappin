import 'package:flutter/material.dart';
import 'stores_bloc.dart';
export 'stores_bloc.dart';
class StoresBlocProvider extends InheritedWidget{
  final bloc = StoresBloc();

  StoresBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static StoresBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoresBlocProvider) as StoresBlocProvider).bloc;
  }
}