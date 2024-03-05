import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ka_client/product.dart';
import 'package:ka_client/style_components/price_chart.dart';

import 'api_connection.dart';

class PriceChartPage extends StatelessWidget {
  final Future<List<Product>> products = GetIt.I<APIConnection>().fetchProducts();

  PriceChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data != null) {
          List<Product> products = snapshot.data!; // Can't be null
          return PriceChart(prices: products.map((e) => e.price).toList());
        }
        if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        return const Center(child: Text('No data'));
      },
      future: products,
    );
  }
}
