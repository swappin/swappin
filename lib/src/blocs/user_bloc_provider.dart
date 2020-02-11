import 'package:flutter/material.dart';
import 'package:swappin/src/blocs/user_bloc.dart';
class UserBlocProvider extends InheritedWidget{
  final bloc = UserBloc();

  UserBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static UserBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(UserBlocProvider) as UserBlocProvider).bloc;
  }
}