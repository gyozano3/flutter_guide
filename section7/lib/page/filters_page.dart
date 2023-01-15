import 'package:flutter/material.dart';
import 'package:section7/widgets/main_drawer.dart';

class FiltersPage extends StatefulWidget {
  static const routeName = '/filters';
  final List<bool> filters;
  final Function setFilters;

  const FiltersPage(this.filters, this.setFilters, {super.key});

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  bool isGlutenFree = false;
  bool isVegan = false;
  bool isVegetarian = false;
  bool isLactoseFree = false;
  @override
  void initState() {
    isGlutenFree = widget.filters[0];
    isVegan = widget.filters[1];
    isVegetarian = widget.filters[2];
    isLactoseFree = widget.filters[3];
    // TODO: implement initState
    super.initState();
  }

  Widget buildSwitchListTile(
      String title, String subtitle, Function updateSetting, bool val) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: val,
      onChanged: (val) => updateSetting(val),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        actions: [
          IconButton(
              onPressed: () {
                widget.setFilters(
                    [isGlutenFree, isVegan, isVegetarian, isLactoseFree]);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'setting your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              buildSwitchListTile(
                'isGlutenFree',
                'only included gluten free',
                (val) {
                  setState(() {
                    isGlutenFree = val;
                  });
                },
                isGlutenFree,
              ),
              buildSwitchListTile(
                'isVegetarian',
                'only included Vegetarian free',
                (val) {
                  setState(() {
                    isVegetarian = val;
                  });
                },
                isVegetarian,
              ),
              buildSwitchListTile(
                'isVegan',
                'only included Vegan free',
                (val) {
                  setState(() {
                    isVegan = val;
                  });
                },
                isVegan,
              ),
              buildSwitchListTile(
                'isLactoseFree',
                'only included LactoseFree free',
                (val) {
                  setState(() {
                    isLactoseFree = val;
                  });
                },
                isLactoseFree,
              ),
            ],
          ))
        ],
      ),
      drawer: const MainDrawer(),
    );
  }
}
