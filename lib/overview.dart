import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ka_client/product.dart';

import 'api_connection.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  Future<List<Product>> products = GetIt.I<APIConnection>().products;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<Product> products = snapshot.data!; // Can't be null
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(products[index].title),
                subtitle: Text(products[index].location),
                trailing: Text(products[index].price.toString()),
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
