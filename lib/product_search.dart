import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'api_connection.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  String? _name, _link;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Name'),
        TextFormField(
          onChanged: (value) {
            _name = value;
          },
        ),
        const Text('Link'),
        TextFormField(
          onChanged: (value) {
            _link = value;
          },
        ),
        ElevatedButton(
          onPressed: () {
            GetIt.I.get<APIConnection>().sendNewProduct(_name!, _link!);
          },
          child: const Text('Add Product'),
        ),
      ],
    );
  }
}
