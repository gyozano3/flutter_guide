import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailPage extends StatelessWidget {
  static String routeName = '/product_detail';
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //listen falseで再ビルドされなくなる
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final _item = Provider.of<Products>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(_item.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                _item.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$${_item.price}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              _item.description,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
