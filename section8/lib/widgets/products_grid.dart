import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:section8/widgets/product_item.dart';

import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  final bool filterFavorite;
  const ProductsGrid(this.filterFavorite, {super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products =
        filterFavorite ? productData.favoriteItems : productData.items;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      //contextで状態を渡さないvalue関数を使うことでWidgetの再利用バグに耐えれる
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
      ),
      itemCount: products.length,
      padding: const EdgeInsets.all(10),
    );
  }
}
