import 'dart:convert';

import 'package:cocktail_database/model/cocktail.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class RandomCocktailController extends GetxController {
  final cocktail = Cocktail(drinks: []).obs;
  @override
  void onInit() async {
    await getCocktail();
    super.onInit();
  }

  Future<void> getCocktail() async {
     final dio = Dio();
    final response =
        await dio.get('https://www.thecocktaildb.com/api/json/v1/1/random.php');
    cocktail(cocktailFromJson(json.encode(response.data)));
  }
}
