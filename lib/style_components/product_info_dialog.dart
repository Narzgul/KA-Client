import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../product.dart';

class ProductInfoDialog extends StatelessWidget {
  final Product product;

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  const ProductInfoDialog({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(product.title),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      children: [
        ListTile(
          leading: const Icon(Icons.attach_money),
          title: const Text('Price'),
          subtitle: Text(product.price.toString()),
        ),
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text('Location'),
          subtitle: Text(product.location + (product.vb ? ' VB' : '')),
        ),
        ListTile(
          leading: const Icon(Icons.local_shipping),
          title: const Text('Shipping'),
          subtitle: Text(product.shipping ? 'Yes' : 'No'),
        ),
        ListTile(
          leading: const Icon(Icons.open_in_browser),
          title: const Text('Open in browser'),
          onTap: () {
            // Open the product in the browser
            _launchUrl(
                "https://www.kleinanzeigen.de/s-anzeige/${product.id.toString()}");
          },
        )
      ],
    );
  }
}
