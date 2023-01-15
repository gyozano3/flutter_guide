import 'package:flutter/material.dart';
import 'package:section7/widgets/meal_item.dart';

import '../dummy_data.dart';
import '../models/meal.dart';

class CategoryMealPage extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<bool> filters;
  const CategoryMealPage(this.filters, {super.key});

  @override
  State<CategoryMealPage> createState() => _CategoryMealPageState();
}

class _CategoryMealPageState extends State<CategoryMealPage> {
  List<Meal> meals = [];
  String title = '';
  bool firstLoad = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //context not created
    if (firstLoad) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      meals = DUMMY_MEALS
          .where((e) {
            if (widget.filters[0] && !e.isGlutenFree) return false;
            if (widget.filters[1] && !e.isLactoseFree) return false;
            if (widget.filters[2] && !e.isVegan) return false;
            if (widget.filters[3] && !e.isVegetarian) return false;

            return true;
          })
          .where((e) => e.categories.contains(routeArgs['id']))
          .toList();
      title = routeArgs['title']!;
      firstLoad = false;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void removeItem(String mealId) => setState(() {
        meals.removeWhere((element) => element.id == mealId);
      });
  // final String categoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
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
      ),
    );
  }
}
