import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'sample_item.dart';
import 'package:url_launcher/url_launcher.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({super.key, required this.item});

  static const routeName = '/sample_item';
  final SampleItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Html(
            data: item.content,
            onLinkTap: (url, attributes, element) async {
              var uri = Uri.parse(url ?? "");
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              } else {
                throw Exception('Could not launch $uri');
              }
            },
          ),
        ),
      ),
    );
  }
}
