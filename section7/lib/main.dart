import 'package:flutter/material.dart';
import 'package:section7/page/categories_page.dart';
import 'package:section7/page/category_meal_page.dart';
import 'package:section7/page/filters_page.dart';
import 'package:section7/page/tab_page.dart';

import 'page/meal_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> favorites = [];
  List<bool> filters = [false, false, false, false];
  void setFilters(newFilters) {
    filters = newFilters;
  }

  void toggleFavorite(String mealId) {
    final index = favorites.indexWhere((e) => e == mealId);
    if (index >= 0) {
      setState(() {
        favorites.removeAt(index);
      });
    } else {
      setState(() {
        favorites.add(mealId);
      });
    }
  }

  bool isFavorite(String id) {
    return favorites.any((element) => element == id);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return MaterialApp(
      title: 'section7',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
        canvasColor: const Color.fromARGB(255, 255, 207, 223),
        fontFamily: 'Raleway',
        textTheme: theme.textTheme.copyWith(
          bodyText1: const TextStyle(
            color: Colors.black,
          ),
          bodyText2: const TextStyle(
            color: Colors.black,
          ),
          headline6: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // home: const CategoriesPage(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabPage(favorites),
        CategoryMealPage.routeName: (ctx) => CategoryMealPage(filters),
        MealDetailPage.routeName: (ctx) =>
            MealDetailPage(toggleFavorite, isFavorite),
        FiltersPage.routeName: (ctx) => FiltersPage(filters, setFilters),
      },
      onGenerateRoute: ((settings) =>
          MaterialPageRoute(builder: (ctx) => CategoriesPage())),
      onUnknownRoute: ((settings) =>
          MaterialPageRoute(builder: (ctx) => CategoriesPage())),
    );
  }
}
