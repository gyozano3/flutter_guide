import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:section8/widgets/app_drawer.dart';
import 'package:section8/widgets/shop_badge.dart';

import '../providers/cart.dart';
import '../widgets/products_grid.dart';
import 'cart_page.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewPage extends StatefulWidget {
  const ProductOverviewPage({super.key});

  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  bool filterFavorite = false;
  @override
  Widget build(BuildContext context) {
    // final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions val) {
              // products.toggleShowFavorite();
              setState(() {
                if (val == FilterOptions.Favorites) {
                  filterFavorite = true;
                } else {
                  filterFavorite = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text('only favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('show all'),
              )
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => ShopBadge(
                value: cart.itemCount.toString(),
                color: Theme.of(context).colorScheme.background,
                child: ch as Widget),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: ProductsGrid(filterFavorite),
      drawer: AppDrawer(),
    );
  }
}
