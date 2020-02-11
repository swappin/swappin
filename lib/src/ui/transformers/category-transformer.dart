import 'package:flutter/material.dart';
import 'package:swappin/src/ui/stores.dart';
import 'package:swappin/src/ui/transformers/buildin_transformers.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class categoryNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      StoreListscreen(
        category: "Comidas & Bebidas",
        cover: "assets/food-category.jpg",
        subcategories: [
          "Brasileira",
          "Lanches",
          "Drinks",
          "Churrasco",
          "Japonesa",
          "Chinesa",
          "Pizzas",
        ],
      ),
      StoreListscreen(
        category: "Moda & Acessórios",
        cover: "assets/fashion-category.jpg",
        subcategories: [
          "Feminino",
          "Masculino",
          "Bijouterias",
          "Calçados",
        ],
      ),
      StoreListscreen(
        category: "Saúde & Bem Estar",
        cover: "assets/fashion-category.jpg",
        subcategories: [
          "Remédios",
          "Fitness",
          "Higiene Pessoal",
        ],
      )
    ];
    return TransformerPageView(
      loop: false,
      transformer: ThreeDTransformer(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: list[index % list.length],
        );
      },
      itemCount: 3,
    );
  }
}
