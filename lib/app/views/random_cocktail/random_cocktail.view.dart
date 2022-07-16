import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/random_cocktail.controller.dart';

class RandomCocktailView extends GetView<RandomCocktailController> {
  const RandomCocktailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => controller.cocktail().drinks.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.grey,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    buildImage(controller),
                    buildInfo(controller),
                  ],
                ),
        ),
      ),
    );
  }

  Align buildInfo(RandomCocktailController controller) {
    List<String> ingredients = [];
    controller.cocktail.value.drinks[0].forEach((key, value) {
      if (key.contains('strIngredient') && value != 'null') {
        int index = int.parse(key.split('strIngredient')[1]);

        ingredients.add(
            '$value - ${controller.cocktail.value.drinks[0]['strMeasure$index']!}');
      }
    });

    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 530,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
                  child: Text(
                    controller.cocktail().drinks[0]['strDrink']!,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            'Ingredients',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Wrap(
                            spacing: 15,
                            runSpacing: 5,
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            children: ingredients
                                .map(
                                  (e) => Text(
                                    e,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Instructions',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 130,
                        child: ListView(
                          children: [
                            Text(
                              controller.cocktail().drinks[0]
                                  ['strInstructions']!,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: const AlignmentDirectional(0, 1),
              child: ElevatedButton(
                child: const Text('Random Cocktail'),
                onPressed: () async {
                  controller.cocktail().drinks.clear();
                  await controller.getCocktail();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ClipRRect buildImage(RandomCocktailController controller) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(300),
      ),
      child: Image.network(
        controller.cocktail().drinks[0]['strDrinkThumb']!,
        width: 400,
        height: 300,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
