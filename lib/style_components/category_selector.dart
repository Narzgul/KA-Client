import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ka_client/api_connection.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {

  @override
  Widget build(BuildContext context) {
    APIConnection connection = GetIt.I<APIConnection>();
    return FutureBuilder(
      future: connection.categories,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<String> categories = snapshot.data!; // Can't be null
          return DropdownButton<String>(
            value: connection.selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                connection.selectedCategory = newValue!;
              });
            },
            items: categories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        } else if (snapshot.hasData && snapshot.data == null) {
          return const Center(child: Text('No data'));
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
