import 'sample_item.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class DataFetcher {
  Future<List<SampleItem>> fetchRssFeed() async {
    var rssFeed = await http.get(Uri.parse('https://recorder.ro/feed'));
    final document = XmlDocument.parse(rssFeed.body);
    final articles = document.rootElement.findAllElements('item');
    return articles
        .map((e) => SampleItem(
              e.findElements('title').first.innerText,
              e.findElements('content:encoded').first.innerText,
            ))
        .toList();
  }
}
