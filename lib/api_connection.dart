import 'dart:convert';

import 'package:ka_client/product.dart';
import 'package:http/http.dart' as http;

class APIConnection {
  // Replace localhost with 10.0.2.2 for Android Emulator
  String baseUrl = 'http://127.0.0.1:8000';
  late Future<List<String>> categories;
  List<Product> products = [];

  APIConnection() {
    categories = getCategories();
  }

  Future<List<String>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List<String> categories = [];
      for (String category
          in jsonDecode(utf8.decode(response.body.codeUnits))) {
        categories.add(category);
      }
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Product>> fetchProducts() async {
    String category = (await categories)[0];
    final response = await http.get(Uri.parse('$baseUrl/products/$category'));

    if (response.statusCode == 200) {
      List<Product> products = []; // TODO: Write sleek oneliner
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

  /*Future<List<Product>> updateProducts() {
    products = fetchProducts();
    return products;
  }*/
}
