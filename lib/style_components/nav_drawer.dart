import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Form(
              key: _formKey,
              onChanged: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      labelText: 'min price',
                      icon: Icon(Icons.search),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      labelText: 'max price',
                      icon: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
