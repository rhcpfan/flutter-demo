import 'package:flutter/material.dart';
import 'data_fetcher.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  SampleItemListView({
    super.key,
  });

  static const routeName = '/';

  final List<SampleItem> items = List.empty();

  Future<List<SampleItem>> fetchArticles() async {
    return DataFetcher().fetchRssFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Recorder'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Navigate to the settings page. If the user leaves and returns
                // to the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),

        // To work with lists that may contain a large number of items, it’s best
        // to use the ListView.builder constructor.
        //
        // In contrast to the default ListView constructor, which requires
        // building all Widgets up front, the ListView.builder constructor lazily
        // builds Widgets as they’re scrolled into view.
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<List<SampleItem>>(
              future: fetchArticles(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<SampleItem>> snapshot) {
                if (snapshot.hasData) {
                  List<SampleItem> items = snapshot.data ?? [];
                  return ListView.builder(
                    // Providing a restorationId allows the ListView to restore the
                    // scroll position when a user leaves and returns to the app after it
                    // has been killed while running in the background.
                    restorationId: 'sampleItemListView',
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = items[index];
                      return ListTile(
                          title: Text(item.title),
                          leading: const CircleAvatar(
                            // Display the Flutter Logo image asset.
                            foregroundImage:
                                AssetImage('assets/images/flutter_logo.png'),
                          ),
                          onTap: () {
                            // Navigate to the details page. If the user leaves and returns to
                            // the app after it has been killed while running in the
                            // background, the navigation stack is restored.
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SampleItemDetailsView(item: item),
                              ),
                            );
                          });
                    },
                  );
                } else {
                  return const Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.downloading_rounded,
                            color: Colors.yellow,
                            size: 60,
                          )
                        ]),
                  );
                }
              }),
        ));
  }
}
