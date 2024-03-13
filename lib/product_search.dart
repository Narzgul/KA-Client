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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Name'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                _name = value;
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Link'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                _link = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (_name == null ||
                    _link == null ||
                    _name!.isEmpty ||
                    _link!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill out all fields'),
                    ),
                  );
                  return;
                }
                if (_name!.contains(' ')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Name cannot contain spaces'),
                    ),
                  );
                  return;
                }
                if (!Uri.parse(_link!).isAbsolute) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid URL'),
                    ),
                  );
                  return;
                }

                GetIt.I
                    .get<APIConnection>()
                    .sendNewProduct(_name!, _link!)
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added product'),
                    ),
                  );
                });
              },
              child: const Text('Add Product'),
            ),
          ),
        ],
      ),
    );
  }
}
