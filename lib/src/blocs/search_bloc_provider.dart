//import 'package:flutter/material.dart';
//import 'package:swappin/src/blocs/search_bloc.dart';
//class SearchBlocProvider extends InheritedWidget{
//  final bloc = SearchBloc();
//
//  SearchBlocProvider({Key key, Widget child}) : super(key: key, child: child);
//
//  bool updateShouldNotify(_) => true;
//
//  static SearchBloc of(BuildContext context) {
//    return (context.inheritFromWidgetOfExactType(SearchBlocProvider) as SearchBlocProvider).bloc;
//  }
//}