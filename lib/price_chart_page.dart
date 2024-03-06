import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ka_client/product.dart';
import 'package:ka_client/style_components/price_chart.dart';
import 'package:watch_it/watch_it.dart';

import 'api_connection.dart';

class PriceChartPage extends WatchingWidget {
  final Future<List<Product>> products =
      GetIt.I<APIConnection>().fetchProducts();

  PriceChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> products = watchFuture<APIConnection, List<Product>>(
      (p0) => p0.fetchProducts(),
      initialValue: [],
    ).data!;
    if (products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return PriceChart(prices: products.map((e) => e.price).toList());
  }
}
