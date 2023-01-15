import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesPage extends StatelessWidget {
  final List<String> favorites;
  const FavoritesPage(this.favorites, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Meal> meals = [];

    for (var id in favorites) {
      meals.add(DUMMY_MEALS.firstWhere((element) => element.id == id));
    }
    if (favorites.isEmpty) {
      return const Text('add favorite');
    } else {
      return ListView.builder(
        itemBuilder: (cxt, index) {
          return MealItem(
            id: meals[index].id,
            title: meals[index].title,
            imageUrl: meals[index].imageUrl,
            duration: meals[index].duration,
            complexity: meals[index].complexity,
            affordability: meals[index].affordability,
          );
        },
        itemCount: meals.length,
      );
    }
  }
}
