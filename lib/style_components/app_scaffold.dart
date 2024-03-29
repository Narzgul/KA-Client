import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ka_client/price_chart_page.dart';
import 'package:ka_client/style_components/category_selector.dart';
import 'package:ka_client/style_components/nav_drawer.dart';

import '../api_connection.dart';
import '../overview.dart';
import '../product_search.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final Map<String, Widget> _pages = {
    "Overview": const Overview(),
    "Price Chart": const PriceChartPage(),
    "Product Search": const ProductSearch(),
  };

  String _currentPage = "";
  @override
  void initState() {
    super.initState();
    _currentPage = _pages.keys.first;
  }

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KA-Scraper',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
          drawer: NavDrawer(
            updateCurrentPage: (String page) {
              setState(() {
                _currentPage = page;
              });
            },
          ),
          appBar: AppBar(
            title: Text(_currentPage),
            actions: const [CategorySelector()],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // update products
              setState(() {
                GetIt.I.get<APIConnection>().updateProducts().then((value) {
                  scaffoldMessengerKey.currentState?.showSnackBar(
                    const SnackBar(
                      content: Text('Updated products'),
                    ),
                  );
                });
              });
            },
            child: const Icon(Icons.refresh),
          ),
          body: _pages[_currentPage],
        ),
      ),
    );
  }
}
