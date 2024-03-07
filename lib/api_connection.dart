import 'dart:convert';

import 'package:ka_client/product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class APIConnection {
  // Replace localhost with 10.0.2.2 for Android Emulator
  String baseUrl =
  'http://127.0.0.1:8000';
  late Future<List<String>> categories;
  List<Product> products = [];
  String selectedCategory = '';
  int minPrice = 0;
  int maxPrice = 1000000;

  APIConnection() {
    categories = fetchCategories();
  }

  Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List<String> categories = [];
      for (String category
          in jsonDecode(utf8.decode(response.body.codeUnits))) {
        categories.add(category);
      }
      selectedCategory = categories[0];
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Product>> fetchProducts() async {
    await categories;
    final response =
        await http.get(Uri.parse('$baseUrl/products/$selectedCategory'));

    if (response.statusCode == 200) {
      List<Product> products = []; // TODO: Write sleek oneliner
      for (Map<String, dynamic> productString
          in jsonDecode(utf8.decode(response.body.codeUnits))) {
        // Convert to codeUnits to fix Umlauts
        products.add(Product.fromJson(productString));
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      minPrice = prefs.getInt('minPrice') ?? 0;
      maxPrice = prefs.getInt('maxPrice') ?? 1000000;
      products = products.where((element) => element.price >= minPrice && element.price <= maxPrice).toList();

      return products;
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<List<Product>> getProducts() async {
    if (products.isEmpty) {
      products = await fetchProducts();
    }
    return products;
  }

  Future<void> updateProducts() async {
    products = await fetchProducts();
  }
}
