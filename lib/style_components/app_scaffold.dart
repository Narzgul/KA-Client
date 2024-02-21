import 'package:flutter/material.dart';
import 'package:ka_client/price_chart_page.dart';
import 'package:ka_client/style_components/nav_drawer.dart';

import '../overview.dart';

class AppScaffold extends StatefulWidget {

  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final _pages = {
    "Overview": const Overview(),
    "Price Chart": PriceChartPage(),
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
          title: Text(_currentPage),
        ),
        body: _pages[_currentPage],
      ),
    );
  }
}
