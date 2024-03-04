import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ka_client/product.dart';
import 'package:ka_client/style_components/product_info_dialog.dart';

import 'api_connection.dart';

class Overview extends StatelessWidget {
  final Future<List<Product>> products = GetIt.I<APIConnection>().products;

  Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<Product> products = snapshot.data!; // Can't be null
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
                }
              );
            },
          );
        } else if (snapshot.hasData && snapshot.data == null) {
          return const Center(child: Text('No data'));
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        return const Center(child: CircularProgressIndicator());
      },
      future: products,
    );
  }
}
