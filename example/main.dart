import 'dart:io';

import 'package:opml/opml.dart';

void main() {
  print('read example...\n');
  readExample();

  print('\nwrite example...\n');
  writeExample();
}

/// Reads a local OPML file and prints some properties.
void readExample() {
  final xml = File('example/example.xml').readAsStringSync();

  final doc = OpmlDocument.parse(xml);

  print(doc.head.title! + ':');

  for (var category in doc.body) {
    for (var feed in category.children!) {
      print('- ${feed.title} : ${feed.xmlUrl}');
    }
  }
}

/// Creates an OpmlDocument object and prints it to the screen as XML.
void writeExample() {
  final body = <OpmlOutline>[
    OpmlOutline(
      text: 'World',
      title: 'World',
      children: [
        OpmlOutline(
          type: 'rss',
          text: 'BBC News - World',
          title: 'BBC News - World',
          xmlUrl: 'http://feeds.bbci.co.uk/news/world/rss.xml',
        ),
        OpmlOutline(
          type: 'rss',
          text: 'World news | The Guardian',
          title: 'World news | The Guardian',
          xmlUrl: 'http://feeds.guardian.co.uk/theguardian/world/rss',
        ),
      ],
    ),
    OpmlOutline(
      text: 'Uncategorized',
      title: 'Uncategorized',
    ),
  ];

  final opml = OpmlDocument(
    head: OpmlHead(
      title: 'Example Export',
    ),
    body: body,
  );

  final xml = opml.toXmlString(
    pretty: true,
  );

  print(xml);
}
