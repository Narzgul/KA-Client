import 'dart:convert';

import 'package:ka_client/product.dart';
import 'package:http/http.dart' as http;

class APIConnection {
  String url = 'http://127.0.0.1:8000/products';
  late Future<List<Product>> products;

  APIConnection() {
    products = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(url));

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


}