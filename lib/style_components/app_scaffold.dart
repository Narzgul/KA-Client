import 'package:flutter/material.dart';
import 'package:ka_client/style_components/nav_drawer.dart';

import '../overview.dart';
import '../price_chart.dart';

class AppScaffold extends StatefulWidget {
  final String title;

  const AppScaffold({super.key, required this.title});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final _pages = {
    "Overview": const Overview(),
    "Price Chart": const PriceChart(
      prices: [1, 2, 3, 4, 5, 6],
    ),
  };

  String _currentPage = "";
  @override
  void initState() {
    super.initState();
    _currentPage = _pages.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HUntis',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        drawer: NavDrawer(
          updateCurrentPage: (String page) {
            setState(() {
              _currentPage = page;
            });
          },
        ),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _pages[_currentPage],
      ),
    );
  }
}
