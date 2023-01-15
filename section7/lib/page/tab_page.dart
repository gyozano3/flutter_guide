import 'package:flutter/material.dart';
import 'package:section7/page/categories_page.dart';
import 'package:section7/page/favorites_page.dart';

import '../widgets/main_drawer.dart';

class TabPage extends StatefulWidget {
  final List<String> favorites;
  const TabPage(this.favorites, {Key? key}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  List<Widget> _pages = [];
  final List<String> _titles = ['CategoriesPage', 'FavoritesPage'];

  int selectPageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _pages = [CategoriesPage(), FavoritesPage(widget.favorites)];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[selectPageIndex]),
      ),
      drawer: MainDrawer(),
      body: _pages[selectPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.white,
        currentIndex: selectPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

// 上タブ
// class _TabPageState extends State<TabPage> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       // initialIndex: 0,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Meal'),
//           bottom: const TabBar(
//             tabs: [
//               Tab(
//                 icon: Icon(Icons.category),
//                 text: 'Categories',
//               ),
//               Tab(
//                 icon: Icon(Icons.star),
//                 text: 'Favorites',
//               )
//             ],
//           ),
//         ),
//         body: const TabBarView(children: [
//           CategoriesPage(),
//           FavoritesPage(),
//         ]),
//       ),
//     );
//   }
// }
