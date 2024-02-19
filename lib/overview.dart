import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ka_client/price_chart.dart';
import 'package:ka_client/product.dart';

Future<List<Product>> fetchProducts() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/products'));

  if (response.statusCode == 200) {
    List<Product> products = []; // TODO: Write sleak oneliner
    for (Map<String, dynamic> productString
        in jsonDecode(utf8.decode(response.body.codeUnits))) {
      // Convert to codeUnits to fix Umlauts
      products.add(Product.fromJson(productString));
    }
    return products;
  } else {
    throw Exception('Failed to load product');
  }
}

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overview'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            List<Product> products = snapshot.data!; // Can't be null
            return PriceChart(prices: products.map((e) => e.price).toList());
          } else if (snapshot.hasData && snapshot.data == null) {
            return const Center(child: Text('No data'));
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
        future: products,
      ),
    );
  }
}
