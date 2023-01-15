import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailPage extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavorite;
  final Function isFavorite;
  const MealDetailPage(this.toggleFavorite, this.isFavorite, {Key? key})
      : super(key: key);

  Widget buildSection(context, title) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 200,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((element) => element.id == id);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          buildSection(context, 'Ingredients'),
          buildContainer(
            ListView.builder(
              itemBuilder: (context, index) => Card(
                color: Theme.of(context).primaryColorLight,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    meal.ingredients[index],
                  ),
                ),
              ),
              itemCount: meal.ingredients.length,
            ),
          ),
          buildSection(context, 'Step'),
          buildContainer(
            ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(meal.steps[index])),
                  const Divider(),
                ],
              ),
              itemCount: meal.steps.length,
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: (() {
        // Navigator.of(context).pop(id);
        // }),
        onPressed: () => toggleFavorite(id),
        child: isFavorite(id)
            ? const Icon(Icons.star)
            : const Icon(Icons.star_border),
      ),
    );
  }
}
