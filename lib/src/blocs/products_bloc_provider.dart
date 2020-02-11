import 'package:flutter/material.dart';
import 'products_bloc.dart';
class ProductsBlocProvider extends InheritedWidget{
  final bloc = ProductsBloc();

  ProductsBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static ProductsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ProductsBlocProvider) as ProductsBlocProvider).bloc;
  }
}