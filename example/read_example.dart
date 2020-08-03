import 'dart:io';

import 'package:opml/opml.dart';

// Reads a local OPML file and prints some properties.
void main() {
  final xml = File('example.xml').readAsStringSync();

  final doc = OpmlDocument.parse(xml);

  print(doc.head.title + ':');

  for (var category in doc.body) {
    for (var feed in category.children) {
      print('- ${feed.title} : ${feed.xmlUrl}');
    }
  }
}
