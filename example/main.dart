import 'dart:io';

import 'package:opml/opml.dart';

void main() {
  print('Reading example...\n');
  readExample();

  print('\nWriting example...\n');
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
  final head = OpmlHeadBuilder().title('Example Export').build();
  final body = <OpmlOutline>[];

  body.add(OpmlOutlineBuilder()
      .text('World')
      .title('World')
      .addChild(OpmlOutlineBuilder()
          .type('rss')
          .text('BBC News - World')
          .title('BBC News - World')
          .xmlUrl('http://feeds.bbci.co.uk/news/world/rss.xml')
          .build())
      .addChild(OpmlOutlineBuilder()
          .type('rss')
          .text('World news | The Guardian')
          .title('World news | The Guardian')
          .xmlUrl('http://feeds.guardian.co.uk/theguardian/world/rss')
          .build())
      .build());

  body.add(OpmlOutlineBuilder()
      .text('Uncategorized')
      .title('Uncategorized')
      .build());

  final opml = OpmlDocument(
    head: head,
    body: body,
  );

  final xml = opml.toXmlString(pretty: true);

  print(xml);
}
