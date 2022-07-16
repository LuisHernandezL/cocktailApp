import 'package:cocktail_database/app/views/random_cocktail/random_cocktail.view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RandomCocktailView(),
    );
  }
}
