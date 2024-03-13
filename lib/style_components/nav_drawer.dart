import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NavDrawer extends StatelessWidget {
  final Function(String page) updateCurrentPage;
  NavDrawer({super.key, required this.updateCurrentPage});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Text(
              'KA Scraper',
              style: TextStyle(
                fontSize: 26,
              ),
            ),
          ),
          ListTile(
            title: const Text('Overview'),
            leading: const Icon(Icons.home),
            onTap: () {
              updateCurrentPage("Overview");
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Price Chart'),
            leading: const Icon(Icons.show_chart),
            onTap: () {
              updateCurrentPage("Price Chart");
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Product Search'),
            leading: const Icon(Icons.search),
            onTap: () {
              updateCurrentPage("Product Search");
              Navigator.pop(context);
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Form(
              key: _formKey,
              onChanged: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
              child: FutureBuilder(
                future: SharedPreferences.getInstance(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  SharedPreferences prefs = snapshot.data;
                  return Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: () {
                          return prefs.getInt('minPrice') == null ? '' : prefs.getInt('minPrice').toString();
                        }(),
                        onChanged: (value) {
                          prefs.setInt('minPrice', int.parse(value));
                        },
                        decoration: const InputDecoration(
                          labelText: 'min price',
                          icon: Icon(Icons.search),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: () {
                          return prefs.getInt('maxPrice') == null ? '' : prefs.getInt('maxPrice').toString();
                        }(),
                        onChanged: (value) {
                          prefs.setInt('maxPrice', int.parse(value));
                        },
                        decoration: const InputDecoration(
                          labelText: 'max price',
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
