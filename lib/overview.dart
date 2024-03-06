import 'package:flutter/material.dart';
import 'package:ka_client/product.dart';
import 'package:ka_client/style_components/product_info_dialog.dart';
import 'package:watch_it/watch_it.dart';

import 'api_connection.dart';

class Overview extends WatchingWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> products = watchFuture<APIConnection, List<Product>>(
      (p0) => p0.getProducts(),
      initialValue: [],
    ).data!;
    if (products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 75),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(products[index].title),
          subtitle: Text(products[index].location),
          trailing: Text(products[index].price.toString()),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return ProductInfoDialog(product: products[index]);
              },
            );
          },
        );
      },
    );
  }
}
