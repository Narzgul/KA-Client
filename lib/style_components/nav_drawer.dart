import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  final Function(String page) updateCurrentPage;
  const NavDrawer({super.key, required this.updateCurrentPage});

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
        ],
      ),
    );
  }
}
